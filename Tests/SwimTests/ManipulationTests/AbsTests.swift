import XCTest
import Swim

class AbsTests: XCTestCase {

    func testInt() {
        let data: [Int] = [0, 1, 2, -3, 4, -5, 6, -7, 8, -9, 10, -11, 12, 13, 14, -15]
        var image = Image(width: 2, height: 2, rgba: data)
        
        let answer = Image(width: 2, height: 2, rgba: data.map(abs))
        
        XCTAssertEqual(image.abs(), answer)
        
        image.applyAbs()
        XCTAssertEqual(image, answer)
    }
    
    func testFloat() {
        let data: [Float] = [0, 1, 2, -3, 4, -5, 6, -7, 8, -9, 10, -11, 12, 13, 14, -15]
        var image = Image(width: 2, height: 2, rgba: data)
        
        let answer = Image(width: 2, height: 2, rgba: data.map(abs))
        
        XCTAssertEqual(image.abs(), answer)
        
        image.applyAbs()
        XCTAssertEqual(image, answer)
    }
    
    func testDouble() {
        let data: [Double] = [0, 1, 2, -3, 4, -5, 6, -7, 8, -9, 10, -11, 12, 13, 14, -15]
        var image = Image(width: 2, height: 2, rgba: data)
        
        let answer = Image(width: 2, height: 2, rgba: data.map(abs))
        
        XCTAssertEqual(image.abs(), answer)
        
        image.applyAbs()
        XCTAssertEqual(image, answer)
    }
}
