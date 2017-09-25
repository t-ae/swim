
#if os(macOS) || os(iOS)
    import Accelerate
#endif

// MARK: - Generic

extension Image where T: BinaryInteger {
    public func converted<T2: BinaryInteger>(to: T2.Type = T2.self) -> Image<P, T2> {
        return _channelwiseConverted { T2($0) }
    }
}

extension Image where T: SignedInteger {
    public func converted<T2: BinaryFloatingPoint>(to: T2.Type = T2.self) -> Image<P, T2> {
        return _channelwiseConverted { T2(Int64($0)) }
    }
}

extension Image where T: UnsignedInteger {
    public func converted<T2: BinaryFloatingPoint>(to: T2.Type = T2.self) -> Image<P, T2> {
        return _channelwiseConverted { T2(UInt64($0)) }
    }
}

extension Image where T: BinaryFloatingPoint {
    public func converted<T2: BinaryInteger>(to: T2.Type = T2.self) -> Image<P, T2> {
        return _channelwiseConverted { T2($0) }
    }
}

extension Image where T == Float {
    public func converted<T2: BinaryFloatingPoint>(to: T2.Type = T2.self) -> Image<P, T2> {
        return _channelwiseConverted(T2.init)
    }
}

extension Image where T == Double {
    public func converted<T2: BinaryFloatingPoint>(to: T2.Type = T2.self) -> Image<P, T2> {
        return _channelwiseConverted(T2.init)
    }
}

// MARK: - Specializations

extension Image where T == UInt8 {
    public func converted(to: UInt8.Type = UInt8.self) -> Image<P, UInt8> {
        return self
    }
    
    public func converted(to: Int.Type = Int.self) -> Image<P, Int> {
        return _channelwiseConverted(Int.init)
    }
    
    #if os(macOS) || os(iOS)
    public func converted(to: Float.Type = Float.self) -> Image<P, Float> {
        var newImage = Image<P, Float>(width: width, height: height)
        _data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vfltu8(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
    
    public func converted(to: Double.Type = Double.self) -> Image<P, Double> {
        var newImage = Image<P, Double>(width: width, height: height)
        _data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vfltu8D(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
    
    #else
    
    public func converted(to: Float.Type = Float.self) -> Image<P, Float> {
        return _channelwiseConverted(Float.init)
    }
    
    public func converted(to: Double.Type = Double.self) -> Image<P, Double> {
        return _channelwiseConverted(Double.init)
    }
    #endif
}

extension Image where T == Int {
    public func converted(to: UInt8.Type = UInt8.self) -> Image<P, UInt8> {
        return _channelwiseConverted(UInt8.init)
    }
    
    public func converted(to: Int.Type = Int.self) -> Image<P, Int> {
        return self
    }
    
    public func converted(to: Float.Type = Float.self) -> Image<P, Float> {
        return _channelwiseConverted(Float.init)
    }
    
    public func converted(to: Double.Type = Double.self) -> Image<P, Double> {
        return _channelwiseConverted(Double.init)
    }
}

extension Image where T == Float {
    #if os(macOS) || os(iOS)
    public func converted(to: UInt8.Type = UInt8.self) -> Image<P, UInt8> {
        var newImage = Image<P, UInt8>(width: width, height: height)
        _data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vfixu8(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
    #else
    public func converted(to: UInt8.Type = UInt8.self) -> Image<P, UInt8> {
        return _channelwiseConverted(UInt8.init)
    }
    #endif
    
    public func converted(to: Int.Type = Int.self) -> Image<P, Int> {
        return _channelwiseConverted(Int.init)
    }
    
    public func converted(to: Float.Type = Float.self) -> Image<P, Float> {
        return self
    }
    
    #if os(macOS) || os(iOS)
    public func converted(to: Double.Type = Double.self) -> Image<P, Double> {
        var newImage = Image<P, Double>(width: width, height: height)
        _data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vspdp(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
    #else
    
    public func converted(to: Double.Type = Double.self) -> Image<P, Double> {
        return _channelwiseConverted(Double.init)
    }
    #endif
}

extension Image where T == Double {
    #if os(macOS) || os(iOS)
    public func converted(to: UInt8.Type = UInt8.self) -> Image<P, UInt8> {
        var newImage = Image<P, UInt8>(width: width, height: height)
        _data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vfixu8D(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
    #else
    public func converted(to: UInt8.Type = UInt8.self) -> Image<P, UInt8> {
        return _channelwiseConverted(UInt8.init)
    }
    #endif
    
    public func converted(to: Int.Type = Int.self) -> Image<P, Int> {
        return _channelwiseConverted(Int.init)
    }
    
    #if os(macOS) || os(iOS)
    public func converted(to: Float.Type = Float.self) -> Image<P, Float> {
        var newImage = Image<P, Float>(width: width, height: height)
        _data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vdpsp(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
    #else
    public func converted(to: Float.Type = Float.self) -> Image<P, Float> {
        return _channelwiseConverted(Float.init)
    }
    #endif
    
    public func converted(to: Double.Type = Double.self) -> Image<P, Double> {
        return self
    }
}
