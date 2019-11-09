@inlinable
func interleave<T: DataType>(data1: [T], data2: [T]) -> [T] {
    assert(data1.count == data2.count)
    
    let count = data1.count
    let newData = [T](unsafeUninitializedCapacity: count*2) { bp, initializedCount in
        var p = bp.baseAddress!
        for i in 0..<count {
            p.initialize(to: data1[i])
            p += 1
            p.initialize(to: data2[i])
            p += 1
        }
        initializedCount = bp.count
    }
    
    return newData
}

@inlinable
func interleave<T: DataType>(data1: [T], data2: [T], data3: [T]) -> [T] {
    assert(data1.count == data2.count && data2.count == data3.count)
    
    let count = data1.count
    let newData = [T](unsafeUninitializedCapacity: count*3) { bp, initializedCount in
        var p = bp.baseAddress!
        for i in 0..<count {
            p.initialize(to: data1[i])
            p += 1
            p.initialize(to: data2[i])
            p += 1
            p.initialize(to: data3[i])
            p += 1
        }
        initializedCount = bp.count
    }
    
    return newData
}

@inlinable
func interleave<T: DataType>(data1: [T], data2: [T], data3: [T], data4: [T]) -> [T] {
    assert(data1.count == data2.count && data2.count == data3.count && data3.count == data4.count)
    
    let count = data1.count
    let newData = [T](unsafeUninitializedCapacity: count*4) { bp, initializedCount in
        var p = bp.baseAddress!
        for i in 0..<count {
            p.initialize(to: data1[i])
            p += 1
            p.initialize(to: data2[i])
            p += 1
            p.initialize(to: data3[i])
            p += 1
            p.initialize(to: data4[i])
            p += 1
        }
        initializedCount = bp.count
    }
    
    return newData
}
