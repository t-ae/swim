
extension Image where T == UInt8 {
    public func cast() -> Image<P, Int> {
        return _channelwiseConverted(Int.init)
    }
    
    public func cast<T2: DataType&BinaryFloatingPoint>() -> Image<P, T2> {
        return _channelwiseConverted(T2.init)
    }
}

extension Image where T == Int {
    public func cast() -> Image<P, UInt8> {
        return _channelwiseConverted { UInt8($0) }
    }
    
    public func cast<T2: DataType&BinaryFloatingPoint>() -> Image<P, T2> {
        return _channelwiseConverted(T2.init)
    }
}

extension Image where T == Float {
    public func cast() -> Image<P, Int> {
        return _channelwiseConverted(Int.init)
    }
    
    public func cast<T2: DataType&BinaryFloatingPoint>() -> Image<P, T2> {
        return _channelwiseConverted(T2.init)
    }
}

extension Image where T == Double {
    public func cast() -> Image<P, Int> {
        return _channelwiseConverted(Int.init)
    }
    
    public func cast<T2: DataType&BinaryFloatingPoint>() -> Image<P, T2> {
        return _channelwiseConverted(T2.init)
    }
}

#if os(macOS) || os(iOS)
    import Accelerate
    
    extension Image where T == UInt8 {
        public func cast() -> Image<P, Float> {
            return self.unsafeChannelwiseConverted { src, dst in
                vDSP_vfltu8(src.baseAddress!, 1, dst.baseAddress!, 1, vDSP_Length(src.count))
            }
        }
        
        public func cast() -> Image<P, Double> {
            return self.unsafeChannelwiseConverted { src, dst in
                vDSP_vfltu8D(src.baseAddress!, 1, dst.baseAddress!, 1, vDSP_Length(src.count))
            }
        }
    }
    
    extension Image where T == Float {
        public func cast() -> Image<P, UInt8> {
            return self.unsafeChannelwiseConverted { src, dst in
                vDSP_vfixu8(src.baseAddress!, 1, dst.baseAddress!, 1, vDSP_Length(src.count))
            }
        }
        
        public func cast() -> Image<P, Double> {
            return self.unsafeChannelwiseConverted { src, dst in
                vDSP_vspdp(src.baseAddress!, 1, dst.baseAddress!, 1, vDSP_Length(src.count))
            }
        }
    }
    
    extension Image where T == Double {
        public func cast() -> Image<P, UInt8> {
            return self.unsafeChannelwiseConverted { src, dst in
                vDSP_vfixu8D(src.baseAddress!, 1, dst.baseAddress!, 1, vDSP_Length(src.count))
            }
        }
        
        public func cast() -> Image<P, Float> {
            return self.unsafeChannelwiseConverted { src, dst in
                vDSP_vdpsp(src.baseAddress!, 1, dst.baseAddress!, 1, vDSP_Length(src.count))
            }
        }
    }
    
#else
    extension Image where T == UInt8 {
        public func cast() -> Image<P, Double> {
            return _channelwiseConverted(Double.init)
        }
        
        public func cast() -> Image<P, Float> {
            return _channelwiseConverted(Float.init)
        }
    }
    
    extension Image where T == Int {
        public func cast() -> Image<P, Double> {
            return _channelwiseConverted(Double.init)
        }
        
        public func cast() -> Image<P, Float> {
            return _channelwiseConverted(Float.init)
        }
    }
    
    extension Image where T == Float {
        public func cast() -> Image<P, UInt8> {
            return Image<P, UInt8>(width: width, height: height, data: data.map { UInt8($0) })
        }
        
        public func cast() -> Image<P, Double> {
            return _channelwiseConverted(Double.init)
        }
    }
    
    extension Image where T == Double {
        public func cast() -> Image<P, UInt8> {
            return Image<P, UInt8>(width: width, height: height, data: data.map { UInt8($0) })
        }
        
        public func cast() -> Image<P, Float> {
            return _channelwiseConverted(Float.init)
        }
    }
#endif
