@inlinable
func interleave<T: DataType>(data1: [T], data2: [T]) -> [T] {
    assert(data1.count == data2.count)
    
    let count = data1.count
    var newData = [T](repeating: T.swimDefaultValue, count: count * 2)
    
    data1.withUnsafeBufferPointer {
        var src1 = $0.baseAddress!
        data2.withUnsafeBufferPointer {
            var src2 = $0.baseAddress!
            newData.withUnsafeMutableBufferPointer {
                var dst = $0.baseAddress!
                for _ in 0..<count {
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
func interleave<T: DataType>(data1: [T], data2: [T], data3: [T]) -> [T] {
    assert(data1.count == data2.count && data2.count == data3.count)
    
    let count = data1.count
    var newData = [T](repeating: T.swimDefaultValue, count: count * 3)
    
    data1.withUnsafeBufferPointer {
        var src1 = $0.baseAddress!
        data2.withUnsafeBufferPointer {
            var src2 = $0.baseAddress!
            data3.withUnsafeBufferPointer {
                var src3 = $0.baseAddress!
                newData.withUnsafeMutableBufferPointer {
                    var dst = $0.baseAddress!
                    for _ in 0..<count {
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
func interleave<T: DataType>(data1: [T], data2: [T], data3: [T], data4: [T]) -> [T] {
    assert(data1.count == data2.count && data2.count == data3.count && data3.count == data4.count)
    
    let count = data1.count
    var newData = [T](repeating: T.swimDefaultValue, count: count * 4)
    
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
                        for _ in 0..<count {
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
