extension DataContainer where T: AdditiveArithmetic {
    @inlinable
    static func addAssign(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            var p = bp.baseAddress!
            for _ in 0..<bp.count {
                p.pointee += rhs
                p += 1
            }
        }
    }
    
    @inlinable
    static func subtractAssign(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            var p = bp.baseAddress!
            for _ in 0..<bp.count {
                p.pointee -= rhs
                p += 1
            }
        }
    }
    
    @inlinable
    public static func +=(lhs: inout Self, rhs: T) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func -=(lhs: inout Self, rhs: T) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
}

extension DataContainer where T: Numeric {
    @inlinable
    static func multiplyAssign(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            var p = bp.baseAddress!
            for _ in 0..<bp.count {
                p.pointee *= rhs
                p += 1
            }
        }
    }
    
    @inlinable
    public static func *=(lhs: inout Self, rhs: T) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
}

extension DataContainer where T: BinaryInteger {
    @inlinable
    static func divideAssign(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            var p = bp.baseAddress!
            for _ in 0..<bp.count {
                p.pointee /= rhs
                p += 1
            }
        }
    }
    
    @inlinable
    public static func /=(lhs: inout Self, rhs: T) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension DataContainer where T: FloatingPoint {
    @inlinable
    static func divideAssign(lhs: inout Self, rhs: T) {
        lhs.withUnsafeMutableBufferPointer { bp in
            var p = bp.baseAddress!
            for _ in 0..<bp.count {
                p.pointee /= rhs
                p += 1
            }
        }
    }
    
    @inlinable
    public static func /=(lhs: inout Self, rhs: T) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

#if canImport(Accelerate) && !DISABLE_ACCELERATE

// For Image only.
// Pixel only has up to 4 elements. So overhead will be overwhelming.

import Accelerate

extension Image where T == Float {
    @inlinable
    static func addAssign(lhs: inout Image, rhs: T) {
        var rhs = rhs
        lhs.withUnsafeMutableBufferPointer {
            vDSP_vsadd($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    @inlinable
    static func subtractAssign(lhs: inout Image, rhs: T) {
        addAssign(lhs: &lhs, rhs: -rhs)
    }
    
    @inlinable
    static func multiplyAssign(lhs: inout Image, rhs: T) {
        var rhs = rhs
        lhs.withUnsafeMutableBufferPointer {
            vDSP_vsmul($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    @inlinable
    static func divideAssign(lhs: inout Image, rhs: T) {
        var rhs = rhs
        lhs.withUnsafeMutableBufferPointer {
            vDSP_vsdiv($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    @inlinable
    public static func +=(lhs: inout Image, rhs: T) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func -=(lhs: inout Image, rhs: T) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func *=(lhs: inout Image, rhs: T) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func /=(lhs: inout Image, rhs: T) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

extension Image where T == Double {
    @inlinable
    static func addAssign(lhs: inout Image, rhs: T) {
        var rhs = rhs
        lhs.withUnsafeMutableBufferPointer {
            vDSP_vsaddD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    @inlinable
    static func subtractAssign(lhs: inout Image, rhs: T) {
        addAssign(lhs: &lhs, rhs: -rhs)
    }
    
    @inlinable
    static func multiplyAssign(lhs: inout Image, rhs: T) {
        var rhs = rhs
        lhs.withUnsafeMutableBufferPointer {
            vDSP_vsmulD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    @inlinable
    static func divideAssign(lhs: inout Image, rhs: T) {
        var rhs = rhs
        lhs.withUnsafeMutableBufferPointer {
            vDSP_vsdivD($0.baseAddress!, 1, &rhs, $0.baseAddress!, 1, vDSP_Length($0.count))
        }
    }
    
    @inlinable
    public static func +=(lhs: inout Image, rhs: T) {
        addAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func -=(lhs: inout Image, rhs: T) {
        subtractAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func *=(lhs: inout Image, rhs: T) {
        multiplyAssign(lhs: &lhs, rhs: rhs)
    }
    
    @inlinable
    public static func /=(lhs: inout Image, rhs: T) {
        divideAssign(lhs: &lhs, rhs: rhs)
    }
}

#endif
