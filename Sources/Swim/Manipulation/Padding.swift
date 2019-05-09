import Foundation

extension Image {
    @inlinable
    public func withPadding(_ padding: ((left: Int, right: Int), (top: Int, bottom: Int)),
                            edgeMode: EdgeMode<P, T>) -> Image<P, T> {
        let width = self.width + padding.0.left + padding.0.right
        let height = self.height + padding.1.top + padding.1.bottom
        var newImage = Image(width: width, height: height)
        
        newImage.pixelwiseConvert { ref in
            let originalX = ref.x - padding.0.left
            let originalY = ref.y - padding.1.top
            
            if let x = edgeMode.clampValue(value: originalX, max: self.width),
                let y = edgeMode.clampValue(value: originalY, max: self.height) {
                ref.assign(x: x, y: y, in: self)
            } else if case let .constant(px) = edgeMode {
                ref.assign(pixel: px)
            } else {
                fatalError("Never happens.")
            }
        }
        
        return newImage
    }
    
    @inlinable
    public func withPadding(_ padding: (x: Int, y: Int),
                            edgeMode: EdgeMode<P, T>) -> Image<P, T> {
        return withPadding(((padding.x, padding.x), (padding.y, padding.y)), edgeMode: edgeMode)
    }
    
    @inlinable
    public func withPadding(_ padding: Int,
                            edgeMode: EdgeMode<P, T>) -> Image<P, T> {
        return withPadding((padding, padding), edgeMode: edgeMode)
    }
}
