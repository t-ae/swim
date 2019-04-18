#if canImport(Accelerate)
import Accelerate
#endif

// MARK: - Generic

extension Image where T: BinaryInteger {
    @inlinable
    public func typeConverted<T2: BinaryInteger>(to: T2.Type = T2.self) -> Image<P, T2> {
        return channelwiseConverted { T2($0) }
    }
}

extension Image where T: SignedInteger {
    @inlinable
    public func typeConverted<T2: BinaryFloatingPoint>(to: T2.Type = T2.self) -> Image<P, T2> {
        return channelwiseConverted { T2(Int64($0)) }
    }
}

extension Image where T: UnsignedInteger {
    @inlinable
    public func typeConverted<T2: BinaryFloatingPoint>(to: T2.Type = T2.self) -> Image<P, T2> {
        return channelwiseConverted { T2(UInt64($0)) }
    }
}

extension Image where T: BinaryFloatingPoint {
    @inlinable
    public func typeConverted<T2: BinaryInteger>(to: T2.Type = T2.self) -> Image<P, T2> {
        return channelwiseConverted { T2($0) }
    }
}

extension Image where T == Float {
    @inlinable
    public func typeConverted<T2: BinaryFloatingPoint>(to: T2.Type = T2.self) -> Image<P, T2> {
        return channelwiseConverted(T2.init)
    }
}

extension Image where T == Double {
    @inlinable
    public func typeConverted<T2: BinaryFloatingPoint>(to: T2.Type = T2.self) -> Image<P, T2> {
        return channelwiseConverted(T2.init)
    }
}

// MARK: - Specializations
// MARK: UInt8 -> ?
extension Image where T == UInt8 {
    @inlinable
    public func typeConverted(to: UInt8.Type = UInt8.self) -> Image<P, UInt8> {
        return self
    }
    
    @inlinable
    public func typeConverted(to: Int.Type = Int.self) -> Image<P, Int> {
        return channelwiseConverted(Int.init)
    }
    
    #if canImport(Accelerate)
    
    @inlinable
    public func typeConverted(to: Float.Type = Float.self) -> Image<P, Float> {
        var newImage = Image<P, Float>(width: width, height: height)
        data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vfltu8(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
    
    @inlinable
    public func typeConverted(to: Double.Type = Double.self) -> Image<P, Double> {
        var newImage = Image<P, Double>(width: width, height: height)
        data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vfltu8D(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
    
    #else
    
    @inlinable
    public func typeConverted(to: Float.Type = Float.self) -> Image<P, Float> {
        return _channelwiseConverted(Float.init)
    }
    
    @inlinable
    public func typeConverted(to: Double.Type = Double.self) -> Image<P, Double> {
        return _channelwiseConverted(Double.init)
    }
    
    #endif
}

// MARK: Int -> ?
extension Image where T == Int {
    @inlinable
    public func typeConverted(to: UInt8.Type = UInt8.self) -> Image<P, UInt8> {
        return channelwiseConverted(UInt8.init)
    }
    
    @inlinable
    public func typeConverted(to: Int.Type = Int.self) -> Image<P, Int> {
        return self
    }
    
    @inlinable
    public func typeConverted(to: Float.Type = Float.self) -> Image<P, Float> {
        return channelwiseConverted(Float.init)
    }
    
    @inlinable
    public func typeConverted(to: Double.Type = Double.self) -> Image<P, Double> {
        return channelwiseConverted(Double.init)
    }
}

// MARK: Float -> ?
extension Image where T == Float {
    #if canImport(Accelerate)
    
    @inlinable
    public func typeConverted(to: UInt8.Type = UInt8.self) -> Image<P, UInt8> {
        var newImage = Image<P, UInt8>(width: width, height: height)
        data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vfixu8(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
    
    #else
    
    @inlinable
    public func typeConverted(to: UInt8.Type = UInt8.self) -> Image<P, UInt8> {
        return channelwiseConverted(UInt8.init)
    }
    
    #endif
    
    @inlinable
    public func typeConverted(to: Int.Type = Int.self) -> Image<P, Int> {
        return channelwiseConverted(Int.init)
    }
    
    @inlinable
    public func typeConverted(to: Float.Type = Float.self) -> Image<P, Float> {
        return self
    }
    
    #if canImport(Accelerate)
    
    @inlinable
    public func typeConverted(to: Double.Type = Double.self) -> Image<P, Double> {
        var newImage = Image<P, Double>(width: width, height: height)
        data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vspdp(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
    
    #else
    
    @inlinable
    public func typeConverted(to: Double.Type = Double.self) -> Image<P, Double> {
        return channelwiseConverted(Double.init)
    }
    
    #endif
}

// MARK: Double -> ?
extension Image where T == Double {
    #if canImport(Accelerate)
    
    public func typeConverted(to: UInt8.Type = UInt8.self) -> Image<P, UInt8> {
        var newImage = Image<P, UInt8>(width: width, height: height)
        data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vfixu8D(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
    
    #else
    
    public func typeConverted(to: UInt8.Type = UInt8.self) -> Image<P, UInt8> {
        return channelwiseConverted(UInt8.init)
    }
    
    #endif
    
    public func typeConverted(to: Int.Type = Int.self) -> Image<P, Int> {
        return channelwiseConverted(Int.init)
    }
    
    #if canImport(Accelerate)
    
    public func typeConverted(to: Float.Type = Float.self) -> Image<P, Float> {
        var newImage = Image<P, Float>(width: width, height: height)
        data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vdpsp(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
    
    #else
    
    public func typeConverted(to: Float.Type = Float.self) -> Image<P, Float> {
        return channelwiseConverted(Float.init)
    }
    
    #endif
    
    public func typeConverted(to: Double.Type = Double.self) -> Image<P, Double> {
        return self
    }
}
