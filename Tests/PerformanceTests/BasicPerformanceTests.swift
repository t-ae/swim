import XCTest

class BasicPerformanceTests: XCTestCase {

}

#if canImport(Accelerate)

import Accelerate

extension BasicPerformanceTests {
    func testAddPixel() {
        measure {
            var rgba = [Double](repeating: 0, count: 4)
            let scalar: Double = 1
            for _ in 0..<100000 {
                rgba.withUnsafeMutableBufferPointer {
                    var p = $0.baseAddress!
                    for _ in 0..<$0.count {
                        p.pointee += scalar
                        p += 1
                    }
                }
            }
        }
    }
    
    func testAddPixel_accelerate() {
        measure {
            for _ in 0..<100000 {
                var rgba = [Double](repeating: 0, count: 4)
                var scalar: Double = 1
                rgba.withUnsafeMutableBufferPointer {
                    let p = $0.baseAddress!
                    vDSP_vsaddD(p, 1, &scalar, p, 1, vDSP_Length($0.count))
                }
            }
        }
    }
    
    func testInterleave() {
        let cnt = 1000000
        let x = [Double](repeating: 0, count: cnt)
        let y = [Double](repeating: 1, count: cnt)
        measure {
            var result = [Double](repeating: 0, count: 2*cnt)
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
        let cnt = 1000000
        let x = [Double](repeating: 0, count: cnt)
        let y = [Double](repeating: 1, count: cnt)
        measure {
            var result = [Double](repeating: 0, count: 2*cnt)
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
