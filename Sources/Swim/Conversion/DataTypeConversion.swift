
extension Image where T == UInt8 {
    public func cast<T2: DataType&BinaryFloatingPoint>() -> Image<P, T2> {
        return Image<P, T2>(width: width, height: height, data: data.map { T2($0) })
    }
}

extension Image where T == Float {
    public func cast<T2: DataType&BinaryFloatingPoint>() -> Image<P, T2> {
        return Image<P, T2>(width: width, height: height, data: data.map { T2($0) })
    }
}

extension Image where T == Double {
    public func cast<T2: DataType&BinaryFloatingPoint>() -> Image<P, T2> {
        return Image<P, T2>(width: width, height: height, data: data.map { T2($0) })
    }
}

#if os(macOS) || os(iOS)
    import Accelerate
    
    private func vDSPConvert<T, U: ExpressibleByIntegerLiteral>(_ src: [T],
                             _ f: (UnsafePointer<T>, vDSP_Stride, UnsafeMutablePointer<U>, vDSP_Stride, vDSP_Length)->Void) -> [U] {
        let count = src.count
        var ret = [U](repeating: 0, count: count)
        
        src.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            ret.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                f(src, 1, dst, 1, vDSP_Length(count))
            }
        }
        
        return ret
    }
    
    extension Image where T == UInt8 {
        public func cast() -> Image<P, Float> {
            let data = vDSPConvert(self.data, vDSP_vfltu8)
            return Image<P, Float>(width: width, height: height, data: data)
        }
        
        public func cast() -> Image<P, Double> {
            let data = vDSPConvert(self.data, vDSP_vfltu8D)
            return Image<P, Double>(width: width, height: height, data: data)
        }
    }
    
    extension Image where T == Float {
        public func cast() -> Image<P, UInt8> {
            let data = vDSPConvert(self.data, vDSP_vfixu8)
            return Image<P, UInt8>(width: width, height: height, data: data)
        }
        
        public func cast() -> Image<P, Double> {
            let data = vDSPConvert(self.data, vDSP_vspdp)
            return Image<P, Double>(width: width, height: height, data: data)
        }
    }
    
    extension Image where T == Double {
        public func cast() -> Image<P, UInt8> {
            let data = vDSPConvert(self.data, vDSP_vfixu8D)
            return Image<P, UInt8>(width: width, height: height, data: data)
        }
        
        public func cast() -> Image<P, Float> {
            let data = vDSPConvert(self.data, vDSP_vdpsp)
            return Image<P, Float>(width: width, height: height, data: data)
        }
    }
    
#else
    extension Image where T == Float {
        public func cast() -> Image<P, UInt8> {
            return Image<P, UInt8>(width: width, height: height, data: data.map { UInt8($0) })
        }
    }
    
    extension Image where T == Double {
        public func cast() -> Image<P, UInt8> {
            return Image<P, UInt8>(width: width, height: height, data: data.map { UInt8($0) })
        }
    }
#endif
