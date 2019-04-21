import Foundation

extension Blender {
    @inlinable
    public static func screenBlend<T: FloatingPoint>(top: Image<RGB, T>, bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        top.data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            bottom.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                
                for _ in 0..<$0.count {
                    // 1 - (1-a)*(1-b)
                    dst.pointee = src.pointee + dst.pointee - src.pointee * dst.pointee
                    src += 1
                    dst += 1
                }
            }
        }
    }
}
