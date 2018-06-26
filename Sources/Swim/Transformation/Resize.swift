import Foundation
import CStbImage

extension Image where T: BinaryFloatingPoint {
    /// Resize image with appropriate algorithm.
    ///
    /// Area average method for downsampling and Bilinear interpolation for upsampling.
    func _resized(width: Int, height: Int) -> Image<P, T> {
        
        var baseImage = self
        if width < baseImage.width {
            // downsample
            baseImage = baseImage.resizeAA(width: width, height: baseImage.height)
        }
        if height < baseImage.height {
            // downsample
            baseImage = baseImage.resizeAA(width: baseImage.width, height: height)
        }
        if width > baseImage.width || height > baseImage.height {
            // upsample
            baseImage = baseImage.resizeBL(width: width, height: height)
        }
        return baseImage
    }
    
    public func resized(width: Int, height: Int) -> Image<P, T> {
        return _resized(width: width, height: height)
    }
}

extension Image {
    /// Resize image with Narest Neighbor algorithm.
    func _resizeNN(width: Int, height: Int) -> Image<P, T> {
        var newImage = Image<P, T>(width: width, height: height)
        
        let scaleX = Double(self.width) / Double(width)
        let scaleY = Double(self.height) / Double(height)
        
        for y in 0..<height {
            let yp = Double(y) * scaleY
            for x in 0..<width {
                let xp = Double(x) * scaleX
                
                newImage[unsafe: x, y] = self.nearestNeighbor(x: xp, y: yp)
            }
        }
        
        return newImage
    }
    
    public func resizeNN(width: Int, height: Int) -> Image<P, T> {
        return _resizeNN(width: width, height: height)
    }
}

extension Image where T: BinaryFloatingPoint {
    /// Resize image with Area average method.
    func _resizeAA(width: Int, height: Int) -> Image<P, T> {
        
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
    
    public func resizeAA(width: Int, height: Int) -> Image<P, T> {
        return _resizeAA(width: width, height: height)
    }
}

extension Image where T: BinaryFloatingPoint {
    /// Resize image with Bilinear interpolation.
    func _resizeBL(width: Int, height: Int) -> Image<P, T> {
        
        let baseImage: Image<P, T>
        do {
            // downsample to avoid sparse sampling
            var image = self
            if width*2 < self.width {
                var newWidth = self.width >> 1
                while width*2 < newWidth {
                    newWidth >>= 1
                }
                image = image._resizeAA(width: newWidth, height: image.height)
            }
            if height*2 < self.height {
                var newHeight = self.height >> 1
                while height*2 < newHeight {
                    newHeight >>= 1
                }
                image = image._resizeAA(width: image.width, height: newHeight)
            }
            baseImage = image
        }
        
        var newImage = Image<P, T>(width: width, height: height)

        let scaleX = T(baseImage.width-1) / T(width-1)
        let scaleY = T(baseImage.height-1) / T(height-1)

        for y in 0..<height {
            // yp \in [0, self.height-1]
            let yp = T(y) * scaleY
            for x in 0..<width {
                // xp \in [0, self.width-1]
                let xp = T(x) * scaleX
                newImage[unsafe: x, y] = baseImage.interpolateBilinear(x: xp, y: yp)
            }
        }

        return newImage
    }
    
    public func resizeBL(width: Int, height: Int) -> Image<P, T> {
        return _resizeBL(width: width, height: height)
    }
}

extension Image where T: BinaryFloatingPoint {
    /// Resize image with Bicubic interpolation.
    func _resizeBC(width: Int, height: Int) -> Image<P, T> {
        
        let baseImage: Image<P, T>
        do {
            // downsample to avoid sparse sampling
            var image = self
            if width*2 < self.width {
                var newWidth = self.width >> 1
                while width*2 < newWidth {
                    newWidth >>= 1
                }
                image = image._resizeAA(width: newWidth, height: image.height)
            }
            if height*2 < self.height {
                var newHeight = self.height >> 1
                while height*2 < newHeight {
                    newHeight >>= 1
                }
                image = image._resizeAA(width: image.width, height: newHeight)
            }
            baseImage = image
        }
        
        var newImage = Image<P, T>(width: width, height: height)
        
        let scaleX = T(baseImage.width-1) / T(width-1)
        let scaleY = T(baseImage.height-1) / T(height-1)
        
        for y in 0..<height {
            // yp \in [0, self.height-1]
            let yp = T(y) * scaleY
            for x in 0..<width {
                // xp \in [0, self.width-1]
                let xp = T(x) * scaleX
                newImage[unsafe: x, y] = baseImage.interpolateBicubic(x: xp, y: yp)
            }
        }
        
        return newImage
    }
    
    public func resizeBC(width: Int, height: Int) -> Image<P, T> {
        return _resizeBC(width: width, height: height)
    }
}
