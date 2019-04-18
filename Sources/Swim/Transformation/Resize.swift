import Foundation

extension Image where T: BinaryInteger {
    
}

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
                        newImage[unsafe: x, y] = baseImage[unsafe: Int(startX), y]
                    }
                    continue
                }
                
                let startX_i = Int(startX) // floor
                let startVolume = ceilStartX - startX
                let endX_i = Int(endX) // floor
                let endVolume = endX - floorEndX
                
                for y in 0..<newImage.height {
                    // average
                    var pixel: Pixel<P, T> = Pixel<P, T>(value: 0)
                    if startVolume > 0 {
                        pixel += baseImage[unsafe: startX_i, y] * startVolume
                    }
                    for dx in Int(ceilStartX)..<Int(floorEndX) {
                        pixel += baseImage[unsafe: dx, y]
                    }
                    if endVolume > 0 {
                        pixel += baseImage[unsafe: endX_i, y] * endVolume
                    }
                    newImage[unsafe: x, y] = pixel / volume
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
                        newImage[unsafe: x, y] = baseImage[unsafe: x, Int(startY)]
                    }
                    continue
                }
                
                let startY_i = Int(startY) // floor
                let startVolume = ceilStartY - startY
                let endY_i = Int(endY)
                let endVolume = endY - floorEndY
                
                for x in 0..<newImage.width {
                    // average
                    var pixel: Pixel<P, T> = Pixel<P, T>(value: 0)
                    if startVolume > 0 {
                        pixel += baseImage[unsafe: x, startY_i] * startVolume
                    }
                    for dy in Int(ceilStartY)..<Int(floorEndY) {
                        pixel += baseImage[unsafe: x, dy]
                    }
                    if endVolume > 0 {
                        pixel += baseImage[unsafe: x, endY_i] * endVolume
                    }
                    newImage[unsafe: x, y] = pixel / volume
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
        
        let baseImage: Image<P, T>
        if areaAverageResizeBeforeDownSample {
            // downsample to avoid sparse sampling
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
        
        let intpl: (T, T, Image<P, T>) -> Pixel<P, T>
        switch method {
        case .nearestNeighbor:
            intpl = NearestNeighborInterpolator(mode: .edge).interpolate
        case .bilinear:
            intpl = BilinearInterpolator(mode: .edge).interpolate
        case .bicubic:
            intpl = BicubicInterpolator(mode: .edge).interpolate
        }
        
        for y in 0..<height {
            let yp = T(baseImage.height) * T(y) / T(height)
            for x in 0..<width {
                let xp = T(baseImage.width) * T(x) / T(width)
                dest[x, y] = intpl(xp-0.5, yp-0.5, baseImage)
            }
        }
        
        return dest
    }
}

public enum ResizeMethod {
    case nearestNeighbor
    case bilinear
    case bicubic
}
