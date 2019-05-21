extension Image where P: NoAlpha {
    /// Draw image.
    ///
    /// This method only overwrites the pixel values.
    @inlinable
    public mutating func drawImage(origin: (x: Int, y: Int),
                                   image: Image,
                                   mask: Image<Gray, Bool>? = nil) {
        precondition(image.size == mask?.size ?? image.size, "Image and mask must have same size.")
        
        let selfRangeX = max(origin.x, 0)..<min(origin.x + image.width, width)
        let selfRangeY = max(origin.y, 0)..<min(origin.y + image.height, height)
        
        let imageStartX = max(-origin.x, 0)
        let imageStartY = max(-origin.y, 0)
        
        pixelwiseConvert(selfRangeX, selfRangeY) { ref in
            let imageX = ref.x - selfRangeX.startIndex + imageStartX
            let imageY = ref.y - selfRangeY.startIndex + imageStartY
            
            guard mask?[imageX, imageY, .gray] ?? true else {
                return
            }
            
            ref.assign(x: imageX, y: imageY, in: image)
        }
    }
}

extension Image where P: NoAlpha, T: BinaryFloatingPoint {
    /// Draw image with alpha blending.
    @inlinable
    public mutating func drawImage<P2: HasAlpha>(origin: (x: Int, y: Int),
                                                 image: Image<P2, T>) where P2.BaseType == P {
        let selfRangeX = max(origin.x, 0)..<min(origin.x + image.width, width)
        let selfRangeY = max(origin.y, 0)..<min(origin.y + image.height, height)
        
        let imageStartX = max(-origin.x, 0)
        let imageStartY = max(-origin.y, 0)
        
        pixelwiseConvert(selfRangeX, selfRangeY) { ref in
            let imageX = ref.x - selfRangeX.startIndex + imageStartX
            let imageY = ref.y - selfRangeY.startIndex + imageStartY
            
            let alpha = image[imageX, imageY, P2.alphaIndex]
            let colorStartIndex = image.dataIndex(x: imageX, y: imageY, c: P2.colorStartIndex)
            for c in 0..<P.channels {
                ref[c] *= (1-alpha)
                ref[c] += alpha * image[data: colorStartIndex + c]
            }
        }
    }
}

extension Image where P: HasAlpha, T: BinaryFloatingPoint {
    /// Draw image with alpha blending.
    @inlinable
    public mutating func drawImage<P2: HasAlpha>(origin: (x: Int, y: Int),
                                                 image: Image<P2, T>) where P2.BaseType == P {
        let selfRangeX = max(origin.x, 0)..<min(origin.x + image.width, width)
        let selfRangeY = max(origin.y, 0)..<min(origin.y + image.height, height)
        
        let imageStartX = max(-origin.x, 0)
        let imageStartY = max(-origin.y, 0)
        
        pixelwiseConvert(selfRangeX, selfRangeY) { ref in
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
                    ref[colorIndex] += imageAlpha * image[data: imageColorStartIndex + c]
                    ref[colorIndex] /= blendAlpha
                }
                ref[P.alphaIndex] = blendAlpha
            }
        }
    }
}
