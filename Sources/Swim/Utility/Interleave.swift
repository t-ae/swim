@inlinable
func interleave<T: DataType>(data1: [T], data2: [T]) -> [T] {
    assert(data1.count == data2.count)
    
    let count = data1.count
    let newData = [T](unsafeUninitializedCapacity: count*2) { bp, initializedCount in
        for i in 0..<count {
            bp[2*i+0] = data1[i]
            bp[2*i+1] = data2[i]
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
        for i in 0..<count {
            bp[3*i+0] = data1[i]
            bp[3*i+1] = data2[i]
            bp[3*i+2] = data3[i]
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
        for i in 0..<count {
            bp[4*i+0] = data1[i]
            bp[4*i+1] = data2[i]
            bp[4*i+2] = data3[i]
            bp[4*i+3] = data4[i]
        }
        initializedCount = bp.count
    }
    
    return newData
}
