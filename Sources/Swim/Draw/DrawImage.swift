extension Image {
    /// Draw image.
    ///
    /// This method only overwrite the pixel values.
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
