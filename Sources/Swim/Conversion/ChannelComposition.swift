import Foundation

@inlinable
func compoundChannels<T: DataType>(data1: [T], data2: [T]) -> [T] {
    assert(data1.count == data2.count)
    
    let pixelCount = data1.count
    var newData = [T](repeating: T.swimDefaultValue, count: pixelCount * 2)
    
    data1.withUnsafeBufferPointer {
        var src1 = $0.baseAddress!
        data2.withUnsafeBufferPointer {
            var src2 = $0.baseAddress!
            newData.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                for _ in 0..<pixelCount {
                    dst.pointee = src1.pointee
                    dst += 1
                    src1 += 1
                    dst.pointee = src2.pointee
                    dst += 1
                    src2 += 1
                }
            }
        }
    }
    
    return newData
}

@inlinable
func compoundChannels<T: DataType>(data1: [T], data2: [T], data3: [T]) -> [T] {
    assert(data1.count == data2.count && data2.count == data3.count)
    
    let pixelCount = data1.count
    var newData = [T](repeating: T.swimDefaultValue, count: pixelCount * 3)
    
    data1.withUnsafeBufferPointer {
        var src1 = $0.baseAddress!
        data2.withUnsafeBufferPointer {
            var src2 = $0.baseAddress!
            data3.withUnsafeBufferPointer {
                var src3 = $0.baseAddress!
                newData.withUnsafeMutableBufferPointer {
                    var dst = $0.baseAddress!
                    for _ in 0..<pixelCount {
                        dst.pointee = src1.pointee
                        dst += 1
                        src1 += 1
                        dst.pointee = src2.pointee
                        dst += 1
                        src2 += 1
                        dst.pointee = src3.pointee
                        dst += 1
                        src3 += 1
                    }
                }
            }
        }
    }
    
    return newData
}

@inlinable
func compoundChannels<T: DataType>(data1: [T], data2: [T], data3: [T], data4: [T]) -> [T] {
    assert(data1.count == data2.count && data2.count == data3.count && data3.count == data4.count)
    
    let pixelCount = data1.count
    var newData = [T](repeating: T.swimDefaultValue, count: pixelCount * 4)
    
    data1.withUnsafeBufferPointer {
        var src1 = $0.baseAddress!
        data2.withUnsafeBufferPointer {
            var src2 = $0.baseAddress!
            data3.withUnsafeBufferPointer {
                var src3 = $0.baseAddress!
                data4.withUnsafeBufferPointer {
                    var src4 = $0.baseAddress!
                    newData.withUnsafeMutableBufferPointer {
                        var dst = $0.baseAddress!
                        for _ in 0..<pixelCount {
                            dst.pointee = src1.pointee
                            dst += 1
                            src1 += 1
                            dst.pointee = src2.pointee
                            dst += 1
                            src2 += 1
                            dst.pointee = src3.pointee
                            dst += 1
                            src3 += 1
                            dst.pointee = src4.pointee
                            dst += 1
                            src4 += 1
                        }
                    }
                }
            }
        }
    }
    
    return newData
}

@inlinable
func compoundChannels<T>(intensity: Image<Intensity, T>,
                         alpha: Image<Intensity, T>) -> Image<IntensityAlpha, T> {
    precondition(intensity.size == alpha.size, "Images must have same size.")
    
    let width = intensity.width
    let height = alpha.height
    let data = compoundChannels(data1: intensity.data, data2: alpha.data)
    
    return Image(width: width, height: height, data: data)
}

@inlinable
func compoundChannels<T>(r: Image<Intensity, T>,
                         g: Image<Intensity, T>,
                         b: Image<Intensity, T>) -> Image<RGB, T> {
    precondition(r.size == g.size && g.size == b.size, "Images must have same size.")
    
    let width = r.width
    let height = r.height
    let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data)
    
    return Image(width: width, height: height, data: data)
}

@inlinable
func compoundChannels<T>(r: Image<Intensity, T>,
                         g: Image<Intensity, T>,
                         b: Image<Intensity, T>,
                         a: Image<Intensity, T>) -> Image<RGBA, T> {
    precondition(r.size == g.size && g.size == b.size && b.size == a.size, "Images must have same size.")
    
    let width = r.width
    let height = r.height
    let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data, data4: a.data)
    
    return Image(width: width, height: height, data: data)
}

@inlinable
func compoundChannels<T>(a: Image<Intensity, T>,
                         r: Image<Intensity, T>,
                         g: Image<Intensity, T>,
                         b: Image<Intensity, T>) -> Image<ARGB, T> {
    precondition(a.size == r.size && r.size == g.size && g.size == b.size, "Images must have same size.")
    
    let width = a.width
    let height = a.height
    let data = compoundChannels(data1: a.data, data2: r.data, data3: g.data, data4: b.data)
    
    return Image(width: width, height: height, data: data)
}

extension Image where P == IntensityAlpha {
    @inlinable
    public init(intensity: Image<Intensity, T>, alpha: Image<Intensity, T>) {
        self = compoundChannels(intensity: intensity, alpha: alpha)
    }
}

extension Image where P == RGB {
    @inlinable
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        self = compoundChannels(r: r, g: g, b: b)
    }
}

extension Image where P == RGBA {
    @inlinable
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>, a: Image<Intensity, T>) {
        self = compoundChannels(r: r, g: g, b: b, a: a)
    }
}

extension Image where P == ARGB {
    @inlinable
    public init(a: Image<Intensity, T>, r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        self = compoundChannels(a: a, r: r, g: g, b: b)
    }
}

// MARK: - Accelerate
#if canImport(Accelerate)

import Accelerate

// MARK: Float
@inlinable
func compoundChannels(datas: [[Float]]) -> [Float] {
    let pixelCount = datas.first!.count
    assert(!datas.contains { $0.count != pixelCount})
    var newData = [Float](repeating: 0, count: pixelCount * datas.count)
    
    for i in 0..<datas.count {
        strideCopy(src: datas[i], srcOffset: 0, srcStride: 1,
                   dst: &newData, dstOffset: i, dstStride: datas.count,
                   count: pixelCount)
    }
    
    return newData
}

@inlinable
func compoundChannels(data1: [Float], data2: [Float]) -> [Float] {
    return compoundChannels(datas: [data1, data2])
}

@inlinable
func compoundChannels(data1: [Float], data2: [Float], data3: [Float]) -> [Float] {
    return compoundChannels(datas: [data1, data2, data3])
}

@inlinable
func compoundChannels(data1: [Float], data2: [Float], data3: [Float], data4: [Float]) -> [Float] {
    return compoundChannels(datas: [data1, data2, data3, data4])
}

@inlinable
func compoundChannels(intensity: Image<Intensity, Float>,
                      alpha: Image<Intensity, Float>) -> Image<IntensityAlpha, Float> {
    precondition(intensity.size == alpha.size, "Images must have same size.")
    
    let width = intensity.width
    let height = alpha.height
    let data = compoundChannels(data1: intensity.data, data2: alpha.data)
    
    return Image(width: width, height: height, data: data)
}

@inlinable
func compoundChannels(r: Image<Intensity, Float>,
                      g: Image<Intensity, Float>,
                      b: Image<Intensity, Float>) -> Image<RGB, Float> {
    precondition(r.size == g.size && g.size == b.size, "Images must have same size.")
    
    let width = r.width
    let height = r.height
    let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data)
    
    return Image(width: width, height: height, data: data)
}

@inlinable
func compoundChannels(r: Image<Intensity, Float>,
                      g: Image<Intensity, Float>,
                      b: Image<Intensity, Float>,
                      a: Image<Intensity, Float>) -> Image<RGBA, Float> {
    precondition(r.size == g.size && g.size == b.size && b.size == a.size, "Images must have same size.")
    
    let width = r.width
    let height = r.height
    let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data, data4: a.data)
    
    return Image(width: width, height: height, data: data)
}

@inlinable
func compoundChannels(a: Image<Intensity, Float>,
                      r: Image<Intensity, Float>,
                      g: Image<Intensity, Float>,
                      b: Image<Intensity, Float>) -> Image<ARGB, Float> {
    precondition(a.size == r.size && r.size == g.size && g.size == b.size)
    
    let width = a.width
    let height = a.height
    let data = compoundChannels(data1: a.data, data2: r.data, data3: g.data, data4: b.data)
    
    return Image(width: width, height: height, data: data)
}

// MARK: Double
@inlinable
func compoundChannels(datas: [[Double]]) -> [Double] {
    let pixelCount = datas.first!.count
    assert(!datas.contains { $0.count != pixelCount})
    var newData = [Double](repeating: 0, count: pixelCount * datas.count)
    
    for i in 0..<datas.count {
        strideCopy(src: datas[i], srcOffset: 0, srcStride: 1,
                   dst: &newData, dstOffset: i, dstStride: datas.count,
                   count: pixelCount)
    }
    
    return newData
}

@inlinable
func compoundChannels(data1: [Double], data2: [Double]) -> [Double] {
    return compoundChannels(datas: [data1, data2])
}

@inlinable
func compoundChannels(data1: [Double], data2: [Double], data3: [Double]) -> [Double] {
    return compoundChannels(datas: [data1, data2, data3])
}

@inlinable
func compoundChannels(data1: [Double], data2: [Double], data3: [Double], data4: [Double]) -> [Double] {
    return compoundChannels(datas: [data1, data2, data3, data4])
}

@inlinable
func compoundChannels(intensity: Image<Intensity, Double>,
                      alpha: Image<Intensity, Double>) -> Image<IntensityAlpha, Double> {
    precondition(intensity.size == alpha.size, "Images must have same size.")
    
    let width = intensity.width
    let height = alpha.height
    let data = compoundChannels(data1: intensity.data, data2: alpha.data)
    
    return Image(width: width, height: height, data: data)
}

@inlinable
func compoundChannels(r: Image<Intensity, Double>,
                      g: Image<Intensity, Double>,
                      b: Image<Intensity, Double>) -> Image<RGB, Double> {
    precondition(r.size == g.size && g.size == b.size, "Images must have same size.")
    
    let width = r.width
    let height = r.height
    let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data)
    
    return Image(width: width, height: height, data: data)
}

@inlinable
func compoundChannels(r: Image<Intensity, Double>,
                      g: Image<Intensity, Double>,
                      b: Image<Intensity, Double>,
                      a: Image<Intensity, Double>) -> Image<RGBA, Double> {
    precondition(r.size == g.size && g.size == b.size && b.size == a.size, "Images must have same size.")
    
    let width = r.width
    let height = r.height
    let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data, data4: a.data)
    
    return Image(width: width, height: height, data: data)
}

@inlinable
func compoundChannels(a: Image<Intensity, Double>,
                      r: Image<Intensity, Double>,
                      g: Image<Intensity, Double>,
                      b: Image<Intensity, Double>) -> Image<ARGB, Double> {
    precondition(a.size == r.size && r.size == g.size && g.size == b.size, "Images must have same size.")
    
    let width = a.width
    let height = a.height
    let data = compoundChannels(data1: a.data, data2: r.data, data3: g.data, data4: b.data)
    
    return Image(width: width, height: height, data: data)
}

#endif
