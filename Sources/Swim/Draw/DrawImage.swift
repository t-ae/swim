extension Image where P: NoAlpha {
    /// Draw image.
    ///
    /// This method only overwrites the pixel values.
    ///
    /// - Parameters:
    ///   - origin: Origin in `self` to draw
    ///   - image: Image to draw.
    ///   - mask: If given, `image[x, y]` is drawn iff `mask[x, y]` is `true`.
    /// - Precondition: `image` and `mask` have same size.
    @inlinable
    public mutating func drawImage(origin: (x: Int, y: Int),
                                   image: Image,
                                   mask: Image<Gray, Bool>? = nil) {
        precondition(image.size == mask?.size ?? image.size, "Image and mask must have same size.")
        
        guard origin.x < width && origin.y < height
            && origin.x + image.width > 0 && origin.y + image.height > 0 else {
            // Drawing area is out of image.
            return
        }
        
        let selfRangeX = max(origin.x, 0)..<min(origin.x + image.width, width)
        let selfRangeY = max(origin.y, 0)..<min(origin.y + image.height, height)
        
        let imageStartX = max(-origin.x, 0)
        let imageStartY = max(-origin.y, 0)
        
        unsafePixelwiseConvert(selfRangeX, selfRangeY) { ref in
            let imageX = ref.x - selfRangeX.startIndex + imageStartX
            let imageY = ref.y - selfRangeY.startIndex + imageStartY
            
            guard mask?[imageX, imageY, .gray] ?? true else {
                return
            }
            
            ref.setColor(x: imageX, y: imageY, in: image)
        }
    }
}

extension Image where P: NoAlpha, T: BinaryInteger {
    /// Draw image with alpha blending.
    ///
    /// Pixel values are assumed to be in range [0, 255].
    @inlinable
    public mutating func drawImage<P2: HasAlpha>(origin: (x: Int, y: Int),
                                                 image: Image<P2, T>) where P2.BaseType == P {
        guard origin.x < width && origin.y < height
            && origin.x + image.width > 0 && origin.y + image.height > 0 else {
                // Drawing area is out of image.
                return
        }
        
        let selfRangeX = max(origin.x, 0)..<min(origin.x + image.width, width)
        let selfRangeY = max(origin.y, 0)..<min(origin.y + image.height, height)
        
        let imageStartX = max(-origin.x, 0)
        let imageStartY = max(-origin.y, 0)
        
        unsafePixelwiseConvert(selfRangeX, selfRangeY) { ref in
            let imageX = ref.x - selfRangeX.startIndex + imageStartX
            let imageY = ref.y - selfRangeY.startIndex + imageStartY
            
            let alpha = Int(image[imageX, imageY, P2.alphaIndex])
            guard alpha > 0 else {
                return
            }
            
            let colorStartIndex = image.dataIndex(x: imageX, y: imageY, c: P2.colorStartIndex)
            for c in 0..<P.channels {
                let value: Int = (255-alpha) * Int(ref[c])
                    + alpha * Int(image.data[colorStartIndex + c])
                ref[c] = T(value / 255)
            }
        }
    }
}

extension Image where P: NoAlpha, T: BinaryFloatingPoint {
    /// Draw image with alpha blending.
    ///
    /// Pixel values are assumed to be in range [0, 1].
    @inlinable
    public mutating func drawImage<P2: HasAlpha>(origin: (x: Int, y: Int),
                                                 image: Image<P2, T>) where P2.BaseType == P {
        guard origin.x < width && origin.y < height
            && origin.x + image.width > 0 && origin.y + image.height > 0 else {
                // Drawing area is out of image.
                return
        }
        
        let selfRangeX = max(origin.x, 0)..<min(origin.x + image.width, width)
        let selfRangeY = max(origin.y, 0)..<min(origin.y + image.height, height)
        
        let imageStartX = max(-origin.x, 0)
        let imageStartY = max(-origin.y, 0)
        
        unsafePixelwiseConvert(selfRangeX, selfRangeY) { ref in
            let imageX = ref.x - selfRangeX.startIndex + imageStartX
            let imageY = ref.y - selfRangeY.startIndex + imageStartY
            
            let alpha = image[imageX, imageY, P2.alphaIndex]
            guard alpha > 0 else {
                return
            }
            
            let colorStartIndex = image.dataIndex(x: imageX, y: imageY, c: P2.colorStartIndex)
            for c in 0..<P.channels {
                ref[c] *= (1-alpha)
                ref[c] += alpha * image.data[colorStartIndex + c]
            }
        }
    }
}

extension Image where P: HasAlpha, T: BinaryInteger {
    /// Draw image with alpha blending.
    ///
    /// Pixel values are assumed to be in range [0, 1].
    @inlinable
    public mutating func drawImage<P2: HasAlpha>(origin: (x: Int, y: Int),
                                                 image: Image<P2, T>) where P2.BaseType == P.BaseType{
        guard origin.x < width && origin.y < height
            && origin.x + image.width > 0 && origin.y + image.height > 0 else {
                // Drawing area is out of image.
                return
        }
        
        let selfRangeX = max(origin.x, 0)..<min(origin.x + image.width, width)
        let selfRangeY = max(origin.y, 0)..<min(origin.y + image.height, height)
        
        let imageStartX = max(-origin.x, 0)
        let imageStartY = max(-origin.y, 0)
        
        unsafePixelwiseConvert(selfRangeX, selfRangeY) { ref in
            let imageX = ref.x - selfRangeX.startIndex + imageStartX
            let imageY = ref.y - selfRangeY.startIndex + imageStartY
            
            let imageAlpha = Int(image[imageX, imageY, P2.alphaIndex])
            let imageColorStartIndex = image.dataIndex(x: imageX, y: imageY, c: P2.colorStartIndex)
            let selfAlpha = Int(ref[P2.alphaIndex])
            
            if imageAlpha == 0 {
                if selfAlpha == 0 {
                    for c in 0..<P.channels {
                        ref[P.colorStartIndex + c] = 0
                    }
                } else {
                    // Keep color
                }
            } else {
                let factor = (255-imageAlpha) * selfAlpha
                let blendAlpha255 = (255*imageAlpha + factor)
                
                for c in 0..<P.channels {
                    let colorIndex = P.colorStartIndex + c
                    var value = Int(ref[colorIndex]) * factor
                    value += 255 * imageAlpha * Int(image.data[imageColorStartIndex + c])
                    value /= blendAlpha255
                    ref[colorIndex] = T(value)
                }
                ref[P.alphaIndex] = T(blendAlpha255 / 255)
            }
        }
    }
}


extension Image where P: HasAlpha, T: BinaryFloatingPoint {
    /// Draw image with alpha blending.
    ///
    /// Pixel values are assumed to be in range [0, 1].
    @inlinable
    public mutating func drawImage<P2: HasAlpha>(origin: (x: Int, y: Int),
                                                 image: Image<P2, T>) where P2.BaseType == P.BaseType{
        guard origin.x < width && origin.y < height
            && origin.x + image.width > 0 && origin.y + image.height > 0 else {
                // Drawing area is out of image.
                return
        }
        
        let selfRangeX = max(origin.x, 0)..<min(origin.x + image.width, width)
        let selfRangeY = max(origin.y, 0)..<min(origin.y + image.height, height)
        
        let imageStartX = max(-origin.x, 0)
        let imageStartY = max(-origin.y, 0)
        
        unsafePixelwiseConvert(selfRangeX, selfRangeY) { ref in
            let imageX = ref.x - selfRangeX.startIndex + imageStartX
            let imageY = ref.y - selfRangeY.startIndex + imageStartY
            
            let imageAlpha = image[imageX, imageY, P2.alphaIndex]
            let imageColorStartIndex = image.dataIndex(x: imageX, y: imageY, c: P2.colorStartIndex)
            let selfAlpha = ref[P2.alphaIndex]
            
            if imageAlpha == 0 {
                if selfAlpha == 0 {
                    for c in 0..<P.channels {
                        ref[P.colorStartIndex + c] = 0
                    }
                } else {
                    // Keep color
                }
            } else {
                let factor = (1-imageAlpha) * selfAlpha
                let blendAlpha = imageAlpha + factor
                
                for c in 0..<P.channels {
                    let colorIndex = P.colorStartIndex + c
                    ref[colorIndex] *= factor
                    ref[colorIndex] += imageAlpha * image.data[imageColorStartIndex + c]
                    ref[colorIndex] /= blendAlpha
                }
                ref[P.alphaIndex] = blendAlpha
            }
        }
    }
}
