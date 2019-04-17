import XCTest
import Swim

class Im2colTests: XCTestCase {
    
    func testIm2col() {
        let image = Image(width: 3, height: 2, intensity: (0..<6).map { Float($0) })
        
        do {
            let (m, n, matrix) = image.im2col(patchWidth: 4, patchHeight: 3, padding: .constant(9))
            XCTAssertEqual(m, 4*3)
            XCTAssertEqual(n, 3*2)
            XCTAssertEqual(matrix, [9, 9, 9, 9, 0, 1,
                                    9, 9, 9, 0, 1, 2,
                                    9, 9, 9, 1, 2, 9,
                                    9, 9, 9, 2, 9, 9,
                                    
                                    9, 0, 1, 9, 3, 4,
                                    0, 1, 2, 3, 4, 5,
                                    1, 2, 9, 4, 5, 9,
                                    2, 9, 9, 5, 9, 9,
                                    
                                    9, 3, 4, 9, 9, 9,
                                    3, 4, 5, 9, 9, 9,
                                    4, 5, 9, 9, 9, 9,
                                    5, 9, 9, 9, 9, 9])
        }
        do {
            let (m, n, matrix) = image.im2col(patchWidth: 4, patchHeight: 3, padding: .nearest)
            XCTAssertEqual(m, 4*3)
            XCTAssertEqual(n, 3*2)
            XCTAssertEqual(matrix, [0, 0, 1, 0, 0, 1,
                                    0, 1, 2, 0, 1, 2,
                                    1, 2, 2, 1, 2, 2,
                                    2, 2, 2, 2, 2, 2,
                                    
                                    0, 0, 1, 3, 3, 4,
                                    0, 1, 2, 3, 4, 5,
                                    1, 2, 2, 4, 5, 5,
                                    2, 2, 2, 5, 5, 5,
                                    
                                    3, 3, 4, 3, 3, 4,
                                    3, 4, 5, 3, 4, 5,
                                    4, 5, 5, 4, 5, 5,
                                    5, 5, 5, 5, 5, 5])
        }
        
        
    }
    
}
