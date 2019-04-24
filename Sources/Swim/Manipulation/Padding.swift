import Foundation

extension Image {
    @inlinable
    public init(image: Image<P, T>,
         with padding: ((left: Int, right: Int), (top: Int, bottom: Int)),
         paddingPixel: Pixel<P, T>) {
        
        let width = image.width + padding.0.left + padding.0.right
        let height = image.height + padding.1.top + padding.1.bottom
        self.init(width: width, height: height, pixel: paddingPixel)
        
        let xRange = padding.0.left..<padding.0.left+image.width
        let yRange = padding.1.top..<padding.1.top+image.height
        self[xRange, yRange] = image
    }
    
    @inlinable
    public init(image: Image<P, T>,
                with padding: (x: Int, y: Int),
                paddingPixel: Pixel<P, T>) {
        self.init(image: image,
                  with: ((padding.x, padding.x), (padding.y, padding.y)),
                  paddingPixel: paddingPixel)
    }
    
    @inlinable
    public init(image: Image<P, T>,
                with padding: Int,
                paddingPixel: Pixel<P, T>) {
        self.init(image: image,
                  with: (padding, padding),
                  paddingPixel: paddingPixel)
    }
}
