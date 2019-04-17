import Foundation

public enum Padding<T: DataType> {
    case nearest
    case constant(T)
}

extension Padding where T: ExpressibleByIntegerLiteral {
    public static var zero: Padding {
        return constant(0)
    }
    
    public static var one: Padding {
        return constant(1)
    }
}

extension Padding where T: FloatingPoint {
    public static var nan: Padding {
        return constant(.nan)
    }
}

extension Image where P == Intensity {
    @inlinable
    public func im2col(patchWidth: Int,
                       patchHeight: Int,
                       padding: Padding<T> = .nearest) -> (m: Int, n: Int, matrix: [T]) {
        
        let m = patchWidth*patchHeight
        let n = width*height
        
        var ret: [T]
        switch padding {
        case .constant(let v):
            ret = [T](repeating: v, count: m*n)
        default:
            ret = [T](repeating: T.swimDefaultValue, count: m*n)
        }
        
        let padTop = (patchHeight-1) / 2
        let padLeft = (patchWidth-1) / 2
        
        data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            ret.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                
                for dy in -padTop..<patchHeight-padTop {
                    for dx in -padLeft..<patchWidth-padLeft {
                        for y in 0..<height {
                            var yy = y + dy
                            if !(0..<height ~= yy) {
                                switch padding {
                                case .nearest:
                                    yy = min(max(yy, 0), height-1)
                                case .constant:
                                    dst += width
                                    continue
                                }
                            }

                            // point leftest pixel
                            let x = min(max(dx, 0), width-1)
                            var sp = src + (yy * width + x)
                            
                            // left padding
                            switch padding {
                            case .nearest:
                                let padLeftValue = sp.pointee
                                for _ in 0..<max(-dx, 0) {
                                    dst.pointee = padLeftValue
                                    dst += 1
                                }
                            case .constant:
                                dst += max(-dx, 0)
                            }
                            
                            // copy
                            let count = width - abs(dx)
                            memcpy(dst, sp, count*MemoryLayout<T>.size)
                            dst += count
                            
                            // right padding
                            switch padding {
                            case .nearest:
                                sp += count - 1 // point rightest pixel
                                let padRightValue = sp.pointee
                                for _ in 0..<max(dx, 0) {
                                    dst.pointee = padRightValue
                                    dst += 1
                                }
                            case .constant:
                                dst += max(dx, 0)
                            }
                            
                        }
                    }
                }
            }
        }
        
        return (m, n, ret)
    }
}
