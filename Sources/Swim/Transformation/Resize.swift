import Foundation

extension Image where T: BinaryFloatingPoint {
    /// Resize image with Area average method.
    @inlinable
    public func resizeAA(width: Int, height: Int) -> Image<P, T> {
        let xScaleImage: Image<P, T>
        if width != self.width {
            let baseImage = self
            var newImage = Image<P, T>(width: width, height: self.height, value: 0)
            
            let volume: T = T(self.width) / T(width)
            for x in 0..<newImage.width {
                let startX: T = T(x) * volume
                let endX: T = T(x+1) * volume
                
                let ceilStartX = Foundation.ceil(startX)
                let floorEndX = Foundation.floor(endX)
                
                guard ceilStartX <= floorEndX else {
                    // refer single pixel
                    for y in 0..<newImage.height {
                        newImage.withMutablePixelRef(x: x, y: y) { ref in
                            ref.add(x: Int(startX), y: y, in: baseImage)
                        }
                    }
                    continue
                }
                
                let startX_i = Int(startX) // floor
                let startVolume = ceilStartX - startX
                let endX_i = Int(endX) // floor
                let endVolume = endX - floorEndX
                
                for y in 0..<newImage.height {
                    newImage.withMutablePixelRef(x: x, y: y) { ref in
                        if startVolume > 0 {
                            ref.add(x: startX_i, y: y, in: baseImage, with: startVolume)
                        }
                        for dx in Int(ceilStartX)..<Int(floorEndX) {
                            ref.add(x: dx, y: y, in: baseImage)
                        }
                        if endVolume > 0 {
                            ref.add(x: endX_i, y: y, in: baseImage, with: endVolume)
                        }
                        ref /= volume
                    }
                }
            }
            xScaleImage = newImage
        } else {
            xScaleImage = self
        }
        
        let yScaleImage: Image<P, T>
        if height != self.height {
            let baseImage = xScaleImage
            var newImage = Image<P, T>(width: width, height: height, value: 0)
            let volume: T = T(self.height) / T(height)
            for y in 0..<newImage.height {
                let startY: T = T(y) * volume
                let endY: T = T(y+1) * volume
                
                let ceilStartY = Foundation.ceil(startY)
                let floorEndY = Foundation.floor(endY)
                
                guard ceilStartY <= floorEndY else {
                    // refer single pixel
                    for x in 0..<newImage.width {
                        newImage.withMutablePixelRef(x: x, y: y) { ref in
                            ref.add(x: x, y: Int(startY), in: baseImage)
                        }
                    }
                    continue
                }
                
                let startY_i = Int(startY) // floor
                let startVolume = ceilStartY - startY
                let endY_i = Int(endY)
                let endVolume = endY - floorEndY
                
                for x in 0..<newImage.width {
                    newImage.withMutablePixelRef(x: x, y: y) { ref in
                        if startVolume > 0 {
                            ref.add(x: x, y: startY_i, in: baseImage, with: startVolume)
                        }
                        for dy in Int(ceilStartY)..<Int(floorEndY) {
                            ref.add(x: x, y: dy, in: baseImage)
                        }
                        if endVolume > 0 {
                            ref.add(x: x, y: endY_i, in: baseImage, with: endVolume)
                        }
                        ref /= volume
                    }
                }
            }
            yScaleImage = newImage
        } else {
            yScaleImage = xScaleImage
        }
        
        return yScaleImage
    }
    
    @inlinable
    public func resize(width: Int,
                       height: Int,
                       method: ResizeMethod = .bilinear,
                       areaAverageResizeBeforeDownSample: Bool = true) -> Image<P, T> {
        switch method {
        case .nearestNeighbor:
            return resize(width: width,
                          height: height,
                          interpolator: NearestNeighborInterpolator(edgeMode: .edge),
                          areaAverageResizeBeforeDownSample: areaAverageResizeBeforeDownSample)
        case .bilinear:
            return resize(width: width,
                          height: height,
                          interpolator: BilinearInterpolator(edgeMode: .edge),
                          areaAverageResizeBeforeDownSample: areaAverageResizeBeforeDownSample)
        case .bicubic:
            return resize(width: width,
                          height: height,
                          interpolator: BicubicInterpolator(edgeMode: .edge),
                          areaAverageResizeBeforeDownSample: areaAverageResizeBeforeDownSample)
        }
    }
    
    @inlinable
    func resize<Intpl: Interpolator>(width: Int,
                                     height: Int,
                                     interpolator: Intpl,
                                     areaAverageResizeBeforeDownSample: Bool = true) -> Image<P, T> where Intpl.P == P, Intpl.T == T {
        let baseImage: Image<P, T>
        if areaAverageResizeBeforeDownSample {
            // downsample for avoiding sparse sampling
            var image = self
            if width*4 < self.width {
                var newWidth = self.width >> 1
                while width*4 < newWidth {
                    newWidth >>= 1
                }
                image = image.resizeAA(width: newWidth, height: image.height)
            }
            if height*4 < self.height {
                var newHeight = self.height >> 1
                while height*4 < newHeight {
                    newHeight >>= 1
                }
                image = image.resizeAA(width: image.width, height: newHeight)
            }
            baseImage = image
        } else {
            baseImage = self
        }
        
        var dest = Image<P, T>(width: width, height: height)
        
        dest.pixelwiseConvert { ref in
            let xp = T(baseImage.width) * T(ref.x) / T(width)
            let yp = T(baseImage.height) * T(ref.y) / T(height)
            interpolator.interpolate(x: xp-0.5, y: yp-0.5, in: baseImage, into: ref)
        }
        
        return dest
    }
}

public enum ResizeMethod {
    case nearestNeighbor
    case bilinear
    case bicubic
}
