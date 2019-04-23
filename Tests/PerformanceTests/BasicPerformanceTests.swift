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
}

#endif
