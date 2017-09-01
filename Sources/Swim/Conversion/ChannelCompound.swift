
import Foundation

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

extension Image where P == RGB {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        precondition(r.width == g.width && g.width == b.width)
        precondition(r.height == g.height && g.height == b.height)
        
        let width = r.width
        let height = r.height
        let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == RGBA {
    public init(r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>, a: Image<Intensity, T>) {
        precondition(r.width == g.width && g.width == b.width && b.width == a.width)
        precondition(r.height == g.height && g.height == b.height && b.height == a.height)
        
        let width = r.width
        let height = r.height
        let data = compoundChannels(data1: r.data, data2: g.data, data3: b.data, data4: a.data)
        
        self.init(width: width, height: height, data: data)
    }
}

extension Image where P == ARGB {
    public init(a: Image<Intensity, T>, r: Image<Intensity, T>, g: Image<Intensity, T>, b: Image<Intensity, T>) {
        precondition(a.width == r.width && r.width == g.width && g.width == b.width)
        precondition(a.height == r.height && r.height == g.height && g.height == b.height)
        
        let width = a.width
        let height = a.height
        let data = compoundChannels(data1: a.data, data2: r.data, data3: g.data, data4: b.data)
        
        self.init(width: width, height: height, data: data)
    }
}

#if os(macOS) || os(iOS)
    import Accelerate
    
    func compoundChannels<T: DataType>(datas: [[T]],
                          strideCopyFunc: (Int32, UnsafePointer<T>, Int32, UnsafeMutablePointer<T>, Int32)->Void) -> [T] {
        let pixelCount = datas.first!.count
        assert(!datas.contains { $0.count != pixelCount})
        var newData = [T](repeating: T.swimDefaultValue, count: pixelCount * datas.count)
        
        newData.withUnsafeMutableBufferPointer {
            var dst = $0.baseAddress!
            for i in 0..<datas.count {
                
                datas[i].withUnsafeBufferPointer {
                    let src = $0.baseAddress!
                    strideCopyFunc(Int32(pixelCount), src, 1, dst, Int32(datas.count))
                }
                
                dst += 1
            }
        }
        
        return newData
    }
    
    func compoundChannels(data1: [Float], data2: [Float], data3: [Float]) -> [Float] {
        return compoundChannels(datas: [data1, data2, data3], strideCopyFunc: cblas_scopy)
    }
    
    func compoundChannels(data1: [Float], data2: [Float], data3: [Float], data4: [Float]) -> [Float] {
        return compoundChannels(datas: [data1, data2, data3, data4], strideCopyFunc: cblas_scopy)
    }
    
    func compoundChannels(data1: [Double], data2: [Double], data3: [Double]) -> [Double] {
        return compoundChannels(datas: [data1, data2, data3], strideCopyFunc: cblas_dcopy)
    }
    
    func compoundChannels(data1: [Double], data2: [Double], data3: [Double], data4: [Double]) -> [Double] {
        return compoundChannels(datas: [data1, data2, data3, data4], strideCopyFunc: cblas_dcopy)
    }

#endif
