
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
        
        public func cast() -> Image<P, Double> {
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
    }
    
    extension Image where T == Float {
        public func cast() -> Image<P, UInt8> {
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
        
        public func cast() -> Image<P, Double> {
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
    }
    
    extension Image where T == Double {
        public func cast() -> Image<P, UInt8> {
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
        
        public func cast() -> Image<P, Float> {
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
