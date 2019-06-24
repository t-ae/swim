extension Image {
    /// Add padding for each edge.
    ///
    /// - Parameters:
    ///   - edgeMode: Determine how to fill padding area.
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
        
        return .createWithUnsafeMutableBufferPointer(width: width, height: height) { bp in
            // draw self part
            for y in 0..<self.height {
                let selfOffset = self.dataIndex(x: 0, y: y)
                let bpOffset = Image<P, T>.dataIndex(x: left, y: top+y, width: width, height: height)
                copy(src: self.data, srcOffset: selfOffset,
                     dst: bp, dstOffset: bpOffset, count: self.width*P.channels)
            }
            
            // draw padding parts
            for y in 0..<top {
                for x in 0..<width {
                    let start = Image<P, T>.dataIndex(x: x, y: y, width: width, height: height)
                    let ref = UnsafePixelRef<P, T>(x: x, y: y, rebasing: bp[start..<start+P.channels])
                    ref.setColor(x: x-left, y: y-top, in: self, edgeMode: edgeMode)
                }
            }
            for y in top..<top+self.height {
                for x in 0..<left {
                    let start = Image<P, T>.dataIndex(x: x, y: y, width: width, height: height)
                    let ref = UnsafePixelRef<P, T>(x: x, y: y, rebasing: bp[start..<start+P.channels])
                    ref.setColor(x: x-left, y: y-top, in: self, edgeMode: edgeMode)
                }
                for x in left+self.width..<width {
                    let start = Image<P, T>.dataIndex(x: x, y: y, width: width, height: height)
                    let ref = UnsafePixelRef<P, T>(x: x, y: y, rebasing: bp[start..<start+P.channels])
                    ref.setColor(x: x-left, y: y-top, in: self, edgeMode: edgeMode)
                }
            }
            for y in top+self.height..<height {
                for x in 0..<width {
                    let start = Image<P, T>.dataIndex(x: x, y: y, width: width, height: height)
                    let ref = UnsafePixelRef<P, T>(x: x, y: y, rebasing: bp[start..<start+P.channels])
                    ref.setColor(x: x-left, y: y-top, in: self, edgeMode: edgeMode)
                }
            }
        }
    }
    
    /// Add padding for each edge.
    ///
    /// - Parameters:
    ///   - edgeMode: Determine how to fill padding area.
    @inlinable
    public func withPadding(x: Int, y: Int, edgeMode: EdgeMode<P, T>) -> Image<P, T> {
        return withPadding(left: x, right: x, top: y, bottom: y, edgeMode: edgeMode)
    }
    
    /// Add padding for left/right edges.
    ///
    /// - Parameters:
    ///   - edgeMode: Determine how to fill padding area.
    @inlinable
    public func withPadding(x: Int, edgeMode: EdgeMode<P, T>) -> Image<P, T> {
        return withPadding(left: x, right: x, top: 0, bottom: 0, edgeMode: edgeMode)
    }
    
    /// Add padding for top/bottom edges.
    ///
    /// - Parameters:
    ///   - edgeMode: Determine how to fill padding area.
    @inlinable
    public func withPadding(y: Int, edgeMode: EdgeMode<P, T>) -> Image<P, T> {
        return withPadding(left: 0, right: 0, top: y, bottom: y, edgeMode: edgeMode)
    }
    
    /// Add padding for each edge.
    ///
    /// - Parameters:
    ///   - edgeMode: Determine how to fill padding area.
    @inlinable
    public func withPadding(_ paddingSize: Int,
                            edgeMode: EdgeMode<P, T>) -> Image<P, T> {
        return withPadding(x: paddingSize, y: paddingSize, edgeMode: edgeMode)
    }
}
