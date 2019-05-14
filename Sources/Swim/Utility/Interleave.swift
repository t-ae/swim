@inlinable
func interleave<T: DataType>(data1: [T], data2: [T]) -> [T] {
    assert(data1.count == data2.count)
    
    let count = data1.count
    var newData = [T](repeating: T.swimDefaultValue, count: count * 2)
    
    for i in 0..<count {
        newData[2*i+0] = data1[i]
        newData[2*i+1] = data2[i]
    }
    
    return newData
}

@inlinable
func interleave<T: DataType>(data1: [T], data2: [T], data3: [T]) -> [T] {
    assert(data1.count == data2.count && data2.count == data3.count)
    
    let count = data1.count
    var newData = [T](repeating: T.swimDefaultValue, count: count * 3)
    
    for i in 0..<count {
        newData[3*i+0] = data1[i]
        newData[3*i+1] = data2[i]
        newData[3*i+2] = data3[i]
    }
    
    return newData
}

@inlinable
func interleave<T: DataType>(data1: [T], data2: [T], data3: [T], data4: [T]) -> [T] {
    assert(data1.count == data2.count && data2.count == data3.count && data3.count == data4.count)
    
    let count = data1.count
    var newData = [T](repeating: T.swimDefaultValue, count: count * 4)
    
    for i in 0..<count {
        newData[4*i+0] = data1[i]
        newData[4*i+1] = data2[i]
        newData[4*i+2] = data3[i]
        newData[4*i+3] = data4[i]
    }
    
    return newData
}
