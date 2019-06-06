import Foundation

/// It's for all `DataType`s. But if T: BinaryFloatingPoint, this method is overloaded and invisible.
extension Image {
    /// Resize image with nearest neighbor method.
    ///
    /// If you need more sophisticated methods, see `Image<P, BinaryFloatingPoint>.resize`.
    ///
    /// - Parameters:
    ///   - width: width of output image
    ///   - height: height of output image
    @inlinable
    public func resize(width: Int,
                       height: Int) -> Image<P, T> {
        let intpl = NearestNeighborInterpolator<P, T>(edgeMode: .edge)
        
        return .createWithPixelRef(width: width, height: height) { ref in
            // range: -0.5 ... baseImage.width+0.5
            let xp = Double(self.width) * Double(ref.x) / Double(width)
            let yp = Double(self.height) * Double(ref.y) / Double(height)
            intpl.interpolate(x: xp-0.5, y: yp-0.5, in: self, into: ref)
        }
    }
}

extension Image where T: BinaryFloatingPoint {
    /// Resize image with Area average method.
    @inlinable
    func resizeAA(width: Int, height: Int) -> Image<P, T> {
        let xScaleImage: Image<P, T>
        if width != self.width {
            let baseImage = self
            
            let height = self.height
            
            xScaleImage = .createWithUnsafeMutableBufferPointer(width: width, height: height) { bp in
                let volume: T = T(self.width) / T(width)
                
                for x in 0..<width {
                    let startX: T = T(x) * volume
                    let endX: T = T(x+1) * volume
                    
                    let ceilStartX = Foundation.ceil(startX)
                    let floorEndX = Foundation.floor(endX)
                    
                    for y in 0..<height {
                        let start = Image<P, T>.dataIndex(x: x, y: y, width: width, height: height)
                        let ref = PixelRef<P, T>(x: x, y: y, rebasing: bp[start..<start+P.channels])
                        
                        guard ceilStartX <= floorEndX else {
                            // refer single pixel
                            ref.setColor(x: Int(startX), y: ref.y, in: baseImage)
                            continue
                        }
                        
                        let startVolume = ceilStartX - startX
                        let endVolume = endX - floorEndX
                        
                        ref.fill(value: 0)
                        
                        if startVolume > 0 {
                            ref.addColor(x: Int(startX), y: ref.y, in: baseImage, with: startVolume)
                        }
                        for dx in Int(ceilStartX)..<Int(floorEndX) {
                            ref.addColor(x: dx, y: ref.y, in: baseImage)
                        }
                        if endVolume > 0 {
                            ref.addColor(x: Int(endX), y: ref.y, in: baseImage, with: endVolume)
                        }
                        ref /= volume
                    }
                }
            }
        } else {
            xScaleImage = self
        }
        
        let yScaleImage: Image<P, T>
        if height != self.height {
            let baseImage = xScaleImage
            
            yScaleImage = .createWithUnsafeMutableBufferPointer(width: width, height: height) { bp in
                let volume: T = T(self.height) / T(height)
                
                for y in 0..<height {
                    let startY: T = T(y) * volume
                    let endY: T = T(y+1) * volume
                    
                    let ceilStartY = Foundation.ceil(startY)
                    let floorEndY = Foundation.floor(endY)
                    
                    for x in 0..<width {
                        let start = Image<P, T>.dataIndex(x: x, y: y, width: width, height: height)
                        let ref = PixelRef<P, T>(x: x, y: y, rebasing: bp[start..<start+P.channels])
                        
                        guard ceilStartY <= floorEndY else {
                            // refer single pixel
                            ref.setColor(x: ref.x, y: Int(startY), in: baseImage)
                            continue
                        }
                        
                        let startVolume = ceilStartY - startY
                        let endVolume = endY - floorEndY
                        
                        ref.fill(value: 0)
                        if startVolume > 0 {
                            ref.addColor(x: ref.x, y: Int(startY), in: baseImage, with: startVolume)
                        }
                        for dy in Int(ceilStartY)..<Int(floorEndY) {
                            ref.addColor(x: ref.x, y: dy, in: baseImage)
                        }
                        if endVolume > 0 {
                            ref.addColor(x: ref.x, y: Int(endY), in: baseImage, with: endVolume)
                        }
                        ref /= volume
                    }
                }
            }
        } else {
            yScaleImage = xScaleImage
        }
        
        return yScaleImage
    }
    
    /// Resize image.
    /// - Parameters:
    ///   - width: width of output image.
    ///   - height: height of output image.
    ///   - method: resize method to use. Default: .bilinear
    ///   - avoidSparseSampling: Resize with area average method before down sampling. It doesn't effect if output size is larger than self or `method` is `.areaAverage`.
    @inlinable
    public func resize(width: Int,
                       height: Int,
                       method: ResizeMethod = .bilinear,
                       avoidSparseSampling: Bool = true) -> Image<P, T> {
        switch method {
        case .nearestNeighbor:
            return resize(width: width,
                          height: height,
                          interpolator: NearestNeighborInterpolator(edgeMode: .edge),
                          avoidSparseSampling: avoidSparseSampling)
        case .bilinear:
            return resize(width: width,
                          height: height,
                          interpolator: BilinearInterpolator(edgeMode: .edge),
                          avoidSparseSampling: avoidSparseSampling)
        case .bicubic:
            return resize(width: width,
                          height: height,
                          interpolator: BicubicInterpolator(edgeMode: .edge),
                          avoidSparseSampling: avoidSparseSampling)
        case .lanczos2:
            return resize(width: width,
                          height: height,
                          interpolator: Lanczos2Interpolator(edgeMode: .edge),
                          avoidSparseSampling: avoidSparseSampling)
        case .lanczos3:
            return resize(width: width,
                          height: height,
                          interpolator: Lanczos3Interpolator(edgeMode: .edge),
                          avoidSparseSampling: avoidSparseSampling)
        case .areaAverage:
            return resizeAA(width: width, height: height)
        }
    }
    
    @inlinable
    func resize<Intpl: Interpolator>(width: Int,
                                     height: Int,
                                     interpolator: Intpl,
                                     avoidSparseSampling: Bool = true) -> Image<P, T> where Intpl.P == P, Intpl.T == T {
        let baseImage: Image<P, T>
        if avoidSparseSampling {
            // downsample for avoiding sparse sampling
            var tmpWidth = self.width
            while width*4 < tmpWidth {
                tmpWidth >>= 1
            }
            var tmpHeight = self.height
            while height*4 < tmpHeight {
                tmpHeight >>= 1
            }
            baseImage = self.resizeAA(width: tmpWidth, height: tmpHeight)
        } else {
            baseImage = self
        }
        
        let xc = Double(baseImage.width) / Double(width-1)
        let yc = Double(baseImage.height) / Double(height-1)
        return .createWithPixelRef(width: width, height: height)  { ref in
            // range: -0.5 ... baseImage.width+0.5
            let xp = xc * Double(ref.x)
            let yp = yc * Double(ref.y)
            interpolator.interpolate(x: xp-0.5, y: yp-0.5, in: baseImage, into: ref)
        }
    }
}

public enum ResizeMethod {
    case nearestNeighbor
    case bilinear
    case bicubic
    case lanczos2
    case lanczos3
    case areaAverage
}
