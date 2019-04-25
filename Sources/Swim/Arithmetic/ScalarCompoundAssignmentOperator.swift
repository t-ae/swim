extension DataContainer where T: AdditiveArithmetic {
    @inlinable
    public static func +=(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            var p = bp.baseAddress!
            for _ in 0..<bp.count {
                p.pointee += rhs
                p += 1
            }
        }
    }
    
    @inlinable
    public static func -=(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            var p = bp.baseAddress!
            for _ in 0..<bp.count {
                p.pointee -= rhs
                p += 1
            }
        }
    }
}

extension DataContainer where T: Numeric {
    @inlinable
    public static func *=(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            var p = bp.baseAddress!
            for _ in 0..<bp.count {
                p.pointee *= rhs
                p += 1
            }
        }
    }
}

extension DataContainer where T: BinaryInteger {
    @inlinable
    public static func /=(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            var p = bp.baseAddress!
            for _ in 0..<bp.count {
                p.pointee /= rhs
                p += 1
            }
        }
    }
}

extension DataContainer where T: FloatingPoint {
    @inlinable
    public static func /=(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            var p = bp.baseAddress!
            for _ in 0..<bp.count {
                p.pointee /= rhs
                p += 1
            }
        }
    }
}

#if canImport(Accelerate) && !DISABLE_ACCELERATE

// For Image only.
// Pixel only has up to 4 elements. So overhead will be overwhelming.

import Accelerate

extension Image where T == Float {
    @inlinable
    public static func +=(lhs: inout Image, rhs: T) {
        var rhs = rhs
        lhs.withUnsafeMutableBufferPointer {
            vDSP_vsadd($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    @inlinable
    public static func -=(lhs: inout Image, rhs: T) {
        lhs += -rhs
    }
    
    @inlinable
    public static func *=(lhs: inout Image, rhs: T) {
        var rhs = rhs
        lhs.withUnsafeMutableBufferPointer {
            vDSP_vsmul($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    @inlinable
    public static func /=(lhs: inout Image, rhs: T) {
        var rhs = rhs
        lhs.withUnsafeMutableBufferPointer {
            vDSP_vsdiv($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
}

extension Image where T == Double {
    @inlinable
    public static func +=(lhs: inout Image, rhs: T) {
        var rhs = rhs
        lhs.withUnsafeMutableBufferPointer {
            vDSP_vsaddD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    @inlinable
    public static func -=(lhs: inout Image, rhs: T) {
        lhs += -rhs
    }
    
    @inlinable
    public static func *=(lhs: inout Image, rhs: T) {
        var rhs = rhs
        lhs.withUnsafeMutableBufferPointer {
            vDSP_vsmulD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    @inlinable
    public static func /=(lhs: inout Image, rhs: T) {
        var rhs = rhs
        lhs.withUnsafeMutableBufferPointer {
            vDSP_vsdivD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
}

#endif
