// MARK: Generic
extension Image {
    @inlinable
    public init(cast image: Image<P, T>, to: T.Type = T.self) {
        self = image
    }
}

extension Image where T: BinaryInteger {
    @inlinable
    public init<T2: BinaryInteger>(cast image: Image<P, T2>, to: T.Type = T.self) {
        self = image.channelwiseConverted { T($0) }
    }

    @inlinable
    public init<T2: BinaryFloatingPoint>(cast image: Image<P, T2>, to: T.Type = T.self) {
        self = image.channelwiseConverted { T($0) }
    }
}

extension Image where T: BinaryFloatingPoint {
    @inlinable
    public init<T2: BinaryInteger>(cast image: Image<P, T2>, to: T.Type = T.self) {
        self = image.channelwiseConverted { T($0) }
    }

    @inlinable
    public init<T2: BinaryFloatingPoint>(cast image: Image<P, T2>, to: T.Type = T.self) {
        self = image.channelwiseConverted { T($0) }
    }
}

extension Image where T == UInt8 {
    @inlinable
    public init<T2: BinaryFloatingPoint>(uncheckedCast image: Image<P, T2>, to: T.Type = T.self) {
        self = image.channelwiseConverted { T(Int($0) | 0xff) }
    }
}

// MARK: Accelerate

#if canImport(Accelerate)

import Accelerate

extension Image where T == UInt8 {
    @inlinable
    public init(uncheckedCast image: Image<P, Float>, to: T.Type = T.self) {
        self = Image<P, UInt8>(width: image.width, height: image.height)
        image.data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            self.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vfixu8(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
    }
    
    @inlinable
    public init(uncheckedCast image: Image<P, Double>, to: T.Type = T.self) {
        self = Image<P, UInt8>(width: image.width, height: image.height)
        image.data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            self.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vfixu8D(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
    }
}

extension Image where T == Float {
    @inlinable
    public init(cast image: Image<P, UInt8>, to: T.Type = T.self) {
        self = Image<P, Float>(width: image.width, height: image.height)
        image.data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            self.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vfltu8(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
    }
    
    @inlinable
    public init(cast image: Image<P, Double>, to: T.Type = T.self) {
        self = Image<P, Float>(width: image.width, height: image.height)
        image.data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            self.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vdpsp(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
    }
}

extension Image where T == Double {
    @inlinable
    public init(cast image: Image<P, UInt8>, to: T.Type = T.self) {
        self = Image<P, Double>(width: image.width, height: image.height)
        image.data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            self.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vfltu8D(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
    }
    
    @inlinable
    public init(cast image: Image<P, Float>, to: T.Type = T.self) {
        self = Image<P, Double>(width: image.width, height: image.height)
        image.data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            self.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vspdp(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
    }
}

#endif
