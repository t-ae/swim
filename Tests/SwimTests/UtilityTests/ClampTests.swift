import XCTest
@testable import Swim

class ClampTests: XCTestCase {
    func testClamp() {
        do {
            let x = -0.3
            
            XCTAssertEqual(clamp(x, min: 0, max: 1), 0)
        }
        do {
            let x = 0.3
            
            XCTAssertEqual(clamp(x, min: 0, max: 1), x)
        }
        do {
            let x = 1.2
            
            XCTAssertEqual(clamp(x, min: 0, max: 1), 1)
        }
        do {
            let x = Double.nan
            
            XCTAssertTrue(clamp(x, min: 0, max: 1).isNaN)
        }
    }
    
    static let allTests = [
        ("testClamp", testClamp)
    ]
}
