public struct Complex<T: BinaryFloatingPoint> {
    public var real: T
    public var imag: T
    
    @inlinable
    public init(real: T, imag: T = .zero) {
        self.real = real
        self.imag = imag
    }
    
    @inlinable
    public var conj: Complex {
        return Complex(real: real, imag: -imag)
    }
}

extension Complex: Equatable {}
extension Complex: Hashable {}

extension Complex: ExpressibleByIntegerLiteral {
    @inlinable
    public init(integerLiteral value: T.IntegerLiteralType) {
        self.init(real: T(integerLiteral: value))
    }
}

extension Complex: ExpressibleByFloatLiteral {
    @inlinable
    public init(floatLiteral value: T.FloatLiteralType) {
        self.init(real: T(floatLiteral: value))
    }
}

extension Complex: AdditiveArithmetic {
    @inlinable
    public static var zero: Complex<T> {
        return Complex(real: .zero)
    }
    
    @inlinable
    public static func +(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(real: lhs.real + rhs.real, imag: lhs.imag + rhs.imag)
    }
    
    @inlinable
    public static func += (lhs: inout Complex<T>, rhs: Complex<T>) {
        lhs.real += rhs.real
        lhs.imag += rhs.imag
    }
    
    @inlinable
    public static func -(lhs: Complex, rhs: Complex) -> Complex {
        return Complex(real: lhs.real - rhs.real, imag: lhs.imag - rhs.imag)
    }
    
    @inlinable
    public static func -= (lhs: inout Complex<T>, rhs: Complex<T>) {
        lhs.real -= rhs.real
        lhs.imag -= rhs.imag
    }
}

extension Complex: Numeric {
    @inlinable
    public init?<I>(exactly source: I) where I : BinaryInteger {
        guard let value = T(exactly: source) else {
            return nil
        }
        self.init(real: value)
    }
    
    @inlinable
    public var magnitude: T {
        if imag == 0 {
            return real.magnitude
        } else {
            return (real*real + imag*imag).squareRoot()
        }
    }
    
    @inlinable
    public static func *(lhs: Complex, rhs: Complex) -> Complex {
        let real = lhs.real * rhs.real - lhs.imag * rhs.imag
        let imag = lhs.real * rhs.imag + lhs.imag * rhs.real
        return Complex(real: real, imag: imag)
    }
    
    @inlinable
    public static func *= (lhs: inout Complex<T>, rhs: Complex<T>) {
        lhs = lhs * rhs
    }
}

extension Complex: SignedNumeric {
    @inlinable
    public prefix static func - (operand: Complex) -> Complex {
        return Complex(real: -operand.real, imag: -operand.imag)
    }
    
    @inlinable
    public mutating func negate() {
        self.real.negate()
        self.imag.negate()
    }
}

extension Complex {
    @inlinable
    public static func /(lhs: Complex, rhs: Complex) -> Complex {
        let mul = lhs * rhs.conj
        let divisor = rhs.real*rhs.real + rhs.imag*rhs.imag
        return Complex(real: mul.real / divisor, imag: mul.imag / divisor)
    }
    
    @inlinable
    public static func /= (lhs: inout Complex<T>, rhs: Complex<T>) {
        lhs = lhs / rhs
    }
}
