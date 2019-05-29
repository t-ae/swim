import Foundation

extension Image {
    @inlinable
    public func withPadding(left: Int,
                            right: Int,
                            top: Int,
                            bottom: Int,
                            edgeMode: EdgeMode<P, T>) -> Image<P, T> {
        precondition(left >= 0, "Padding size can't be negative.")
        precondition(right >= 0, "Padding size can't be negative.")
        precondition(top >= 0, "Padding size can't be negative.")
        precondition(bottom >= 0, "Padding size can't be negative.")
        
        let width = self.width + left + right
        let height = self.height + top + bottom
        
        return .createWithPixelRef(width: width, height: height) { ref in
            let originalX = ref.x - left
            let originalY = ref.y - top
            
            if let x = edgeMode.clampValue(value: originalX, max: self.width),
                let y = edgeMode.clampValue(value: originalY, max: self.height) {
                ref.setColor(x: x, y: y, in: self)
            } else if case let .constant(px) = edgeMode {
                ref.setColor(color: px)
            } else {
                fatalError("Never happens.")
            }
        }
    }
    
    @inlinable
    public func withPadding(x: Int, y: Int, edgeMode: EdgeMode<P, T>) -> Image<P, T> {
        return withPadding(left: x, right: x, top: y, bottom: y, edgeMode: edgeMode)
    }
    
    @inlinable
    public func withPadding(x: Int, edgeMode: EdgeMode<P, T>) -> Image<P, T> {
        return withPadding(left: x, right: x, top: 0, bottom: 0, edgeMode: edgeMode)
    }
    
    @inlinable
    public func withPadding(y: Int, edgeMode: EdgeMode<P, T>) -> Image<P, T> {
        return withPadding(left: 0, right: 0, top: y, bottom: y, edgeMode: edgeMode)
    }
    
    @inlinable
    public func withPadding(_ paddingSize: Int,
                            edgeMode: EdgeMode<P, T>) -> Image<P, T> {
        return withPadding(x: paddingSize, y: paddingSize, edgeMode: edgeMode)
    }
}
