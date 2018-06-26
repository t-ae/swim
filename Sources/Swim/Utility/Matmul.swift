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

#if canImport(Accelerate)

import Accelerate

func matmul(lhs: [Float], rhs: [Float], m: Int, n: Int, p: Int) -> [Float] {
    assert(lhs.count == m*p)
    assert(rhs.count == p*n)
    
    var ret = [Float](repeating: 0, count: m*n)
    
    vDSP_mmul(lhs, 1, rhs, 1, &ret, 1, vDSP_Length(m), vDSP_Length(n), vDSP_Length(p))
    
    return ret
}

func matmul(lhs: [Double], rhs: [Double], m: Int, n: Int, p: Int) -> [Double] {
    assert(lhs.count == m*p)
    assert(rhs.count == p*n)
    
    var ret = [Double](repeating: 0, count: m*n)
    
    vDSP_mmulD(lhs, 1, rhs, 1, &ret, 1, vDSP_Length(m), vDSP_Length(n), vDSP_Length(p))
    
    return ret
}

#endif
