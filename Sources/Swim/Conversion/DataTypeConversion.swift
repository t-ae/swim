public struct DataTypeConverter<P: PixelType, T: DataType> {
    @usableFromInline
    let image: Image<P, T>
    
    @inlinable
    public init(_ image: Image<P, T>) {
        self.image = image
    }
    
    @inlinable
    public func cast<T2: DataType>(to: T2.Type = T2.self,
                                   transform: (T)->T2) -> Image<P, T2> {
        return image.channelwiseConverted(transform)
    }
}

extension Image {
    @inlinable
    public var dataTypeConverter: DataTypeConverter<P, T> {
        return DataTypeConverter(self)
    }
}

// MARK: - Generic

extension DataTypeConverter {
    @inlinable
    public func cast(to: T.Type = T.self) -> Image<P, T> {
        return image
    }
}

extension DataTypeConverter where T: BinaryInteger {
    @inlinable
    public func cast<T2: BinaryInteger>(to: T2.Type = T2.self) -> Image<P, T2> {
        return image.channelwiseConverted { T2($0) }
    }
    
    @inlinable
    public func cast<T2: BinaryFloatingPoint>(to: T2.Type = T2.self) -> Image<P, T2> {
        return image.channelwiseConverted { T2($0) }
    }
    
    @inlinable
    public func uncheckedCast(to: UInt8.Type = UInt8.self) -> Image<P, UInt8> {
        return image.channelwiseConverted { UInt8(Int($0) | 0xff) }
    }
}

extension DataTypeConverter where T: BinaryFloatingPoint {
    @inlinable
    public func cast<T2: BinaryInteger>(to: T2.Type = T2.self) -> Image<P, T2> {
        return image.channelwiseConverted { T2($0) }
    }
    
    @inlinable
    public func cast<T2: BinaryFloatingPoint>(to: T2.Type = T2.self) -> Image<P, T2> {
        return image.channelwiseConverted { T2($0) }
    }
    
    @inlinable
    public func uncheckedCast(to: UInt8.Type = UInt8.self) -> Image<P, UInt8> {
        return image.channelwiseConverted { UInt8(Int($0) | 0xff) }
    }
}

// MARK: - Accelerate

#if canImport(Accelerate)

import Accelerate

extension DataTypeConverter where T == UInt8 {
    @inlinable
    public func cast(to: Float.Type = Float.self) -> Image<P, Float> {
        var newImage = Image<P, Float>(width: image.width, height: image.height)
        image.data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vfltu8(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
    
    @inlinable
    public func cast(to: Double.Type = Double.self) -> Image<P, Double> {
        var newImage = Image<P, Double>(width: image.width, height: image.height)
        image.data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vfltu8D(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
}

extension DataTypeConverter where T == Float {
    public func uncheckedCast(to: UInt8.Type = UInt8.self) -> Image<P, UInt8> {
        var newImage = Image<P, UInt8>(width: image.width, height: image.height)
        image.data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vfixu8(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
    
    @inlinable
    public func cast(to: Double.Type = Double.self) -> Image<P, Double> {
        var newImage = Image<P, Double>(width: image.width, height: image.height)
        image.data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vspdp(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
}

extension DataTypeConverter where T == Double {
    public func uncheckedCast(to: UInt8.Type = UInt8.self) -> Image<P, UInt8> {
        var newImage = Image<P, UInt8>(width: image.width, height: image.height)
        image.data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vfixu8D(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
    
    @inlinable
    public func cast(to: Float.Type = Float.self) -> Image<P, Float> {
        var newImage = Image<P, Float>(width: image.width, height: image.height)
        image.data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                vDSP_vdpsp(src, 1, dst, 1, vDSP_Length($0.count))
            }
        }
        return newImage
    }
}

#endif
