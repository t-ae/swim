import XCTest
import Swim

class PowerTests: XCTestCase {

    func testPowFloat() {
        let data: [Float] = [0, 1, 2, -3, 4, -5, 6, -7, 8, -9, 10, -11, 12, 13, 14, -15]
        let image = Image(width: 2, height: 2, rgba: data)
        
        let answer = Image(width: 2, height: 2, rgba: data.map { pow($0, 2) })
        
        XCTAssertEqual(image.powered(2), answer)
    }

    func testPowDouble() {
        let data: [Double] = [0, 1, 2, -3, 4, -5, 6, -7, 8, -9, 10, -11, 12, 13, 14, -15]
        let image = Image(width: 2, height: 2, rgba: data)
        
        let answer = Image(width: 2, height: 2, rgba: data.map { pow($0, 2) })
        
        XCTAssertEqual(image.powered(2), answer)
    }
    
    static let allTests = [
        ("testPowFloat", testPowFloat),
        ("testPowDouble", testPowDouble)
    ]
}
