import Foundation

extension Blender {
    @inlinable
    public static func addBlend<T: BinaryFloatingPoint>(top: Image<RGB, T>, bottom: inout Image<RGB, T>) {
        precondition(top.size == bottom.size, "Images must have same size.")
        
        top.data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            bottom.data.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                
                for _ in 0..<$0.count {
                    dst.pointee = min(dst.pointee + src.pointee, 1)
                    src += 1
                    dst += 1
                }
            }
        }
    }
}
