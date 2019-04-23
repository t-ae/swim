import XCTest

class BasicPerformanceTests: XCTestCase {

}

#if canImport(Accelerate) && !DISABLE_ACCELERATE

import Accelerate

extension BasicPerformanceTests {
    func testMultiplyImage() {
        var rgba = [Double](repeating: 1, count: 4000000)
        let scalar: Double = 0.99
        measure {
            for _ in 0..<10 {
                rgba.withUnsafeMutableBufferPointer {
                    var p = $0.baseAddress!
                    for _ in 0..<$0.count {
                        p.pointee *= scalar
                        p += 1
                    }
                }
            }
        }
    }
    
    func testMultiplyImage_accelerate() {
        var rgba = [Double](repeating: 1, count: 4000000)
        var scalar: Double = 0.99
        measure {
            for _ in 0..<10 {
                rgba.withUnsafeMutableBufferPointer {
                    let p = $0.baseAddress!
                    vDSP_vsmulD(p, 1, &scalar, p, 1, vDSP_Length($0.count))
                }
            }
        }
    }
    
    func testMultiplyPixel() {
        var rgba = [Double](repeating: 1, count: 4)
        let scalar: Double = 0.99
        measure {
            for _ in 0..<300000 {
                rgba.withUnsafeMutableBufferPointer {
                    var p = $0.baseAddress!
                    for _ in 0..<$0.count {
                        p.pointee *= scalar
                        p += 1
                    }
                }
            }
        }
    }
    
    func testMultiplyPixel_accelerate() {
        var rgba = [Double](repeating: 1, count: 4)
        var scalar: Double = 0.99
        measure {
            for _ in 0..<300000 {
                rgba.withUnsafeMutableBufferPointer {
                    let p = $0.baseAddress!
                    vDSP_vsmulD(p, 1, &scalar, p, 1, vDSP_Length($0.count))
                }
            }
        }
    }
    
    func testInterleave() {
        let cnt = 10000000
        let x = [Double](repeating: 0, count: cnt)
        let y = [Double](repeating: 1, count: cnt)
        var result = [Double](repeating: 0, count: 2*cnt)
        measure {
            x.withUnsafeBufferPointer {
                var xp = $0.baseAddress!
                y.withUnsafeBufferPointer {
                    var yp = $0.baseAddress!
                    result.withUnsafeMutableBufferPointer {
                        var p = $0.baseAddress!
                        
                        for _ in 0..<cnt {
                            p.pointee = xp.pointee
                            p += 1
                            xp += 1
                            p.pointee = yp.pointee
                            p += 1
                            yp += 1
                        }
                    }
                }
            }
        }
    }
    
    func testInterleave_accelerate() {
        let cnt = 10000000
        let x = [Double](repeating: 0, count: cnt)
        let y = [Double](repeating: 1, count: cnt)
        var result = [Double](repeating: 0, count: 2*cnt)
        measure {
            result.withUnsafeMutableBufferPointer {
                var p = $0.baseAddress!
                x.withUnsafeBufferPointer {
                    let xp = $0.baseAddress!
                    
                    cblas_dcopy(Int32(cnt), xp, 1, p, 2)
                }
                p += 1
                y.withUnsafeBufferPointer {
                    let yp = $0.baseAddress!
                    
                    cblas_dcopy(Int32(cnt), yp, 1, p, 2)
                }
            }
        }
    }
}

#endif
