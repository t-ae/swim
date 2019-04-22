import XCTest
import Swim

class WarpTests: XCTestCase {
    func testHomogeneousTransform() {
        do {
            let a = HomogeneousTransformationMatrix(elements: [1, -1, 1,
                                                               1, 1, 0,
                                                               0, 3, 1])
            let inv = try! a.inverted()
            let id = a * inv
            
            XCTAssertEqual(id.elements, [1, 0, 0,
                                         0, 1, 0,
                                         0, 0, 1], accuracy: 1e-4)
        }
    }
    
    func testWarp() {
        
    }
}
