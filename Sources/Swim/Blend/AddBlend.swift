import Foundation

extension Blender {
    @inlinable
    public static func addBlend<T: BinaryFloatingPoint>(src: Image<RGB, T>, dst: inout Image<RGB, T>) {
        precondition(src.size == dst.size, "Images must have same size.")
        
        src.data.withUnsafeBufferPointer {
            var src = $0.baseAddress!
            dst.data.withUnsafeMutableBufferPointer {
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
