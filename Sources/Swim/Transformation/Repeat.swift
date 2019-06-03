import Foundation

extension Image {
    /// Create new image repeating self horizontally/vertically.
    ///
    /// - Parameters:
    ///   - horizontally: The number of times to repeat self horizontally.
    ///   - vertically: The number of times to repeat self vertically.
    /// - Precondition: horizontally > 0 && vertically > 0
    public func repeated(horizontally: Int = 1, vertically: Int = 1) -> Image {
        precondition(horizontally > 0, "horizontally must be positive.")
        precondition(vertically > 0, "vertically must be positive.")
        
        let newWidth = width * horizontally
        let newHeight = height * vertically
        
        return .createWithUnsafeMutableBufferPointer(width: newWidth, height: newHeight) { bp in
            // horizontally
            for y in 0..<height {
                let srcOffset = self.dataIndex(x: 0, y: y)
                for i in 0..<horizontally {
                    let dstOffset = Image<P, T>.dataIndex(x: i*width, y: y, width: newWidth, height: newHeight)
                    copy(src: data, srcOffset: srcOffset,
                         dst: bp, dstOffset: dstOffset, count: width*P.channels)
                }
            }
            
            // vertically
            for i in 0..<vertically {
                let dstOffset = i * height*newWidth*P.channels
                copy(src: bp, srcOffset: 0,
                     dst: bp, dstOffset: dstOffset, count: height*newWidth*P.channels)
            }
        }
    }
}
