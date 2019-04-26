@inlinable
func matmul<T: Numeric>(lhs: [T], rhs: [T], m: Int, n: Int, p: Int) -> [T] {
    assert(lhs.count == m*p)
    assert(rhs.count == p*n)
    
    var ret = [T](repeating: 0, count: m*n)
    
    lhs.withUnsafeBufferPointer { lbp in
        rhs.withUnsafeBufferPointer { rbp in
            ret.withUnsafeMutableBufferPointer { bp in
                var lp = lbp.baseAddress!
                for i in 0..<m {
                    var rp = rbp.baseAddress!
                    for _ in 0..<p {
                        var pp = bp.baseAddress! + n*i
                        for _ in 0..<n {
                            pp.pointee += lp.pointee * rp.pointee
                            
                            pp += 1
                            rp += 1
                        }
                        lp += 1
                    }
                }
            }
        }
    }
    
    return ret
}
