import XCTest
import Swim

class ShiftTests: XCTestCase {
    func testShifted() {
        let image = Image<RGB, Double>(width: 4, height: 5, data: (0..<60).map { Double($0) })
        
        do {
            let color = Color(r: 0, g: 0.5, b: 1)
            let shifted = image.shifted(x: 1, y: 1, edgeMode: .constant(color: color))
            XCTAssertEqual(shifted[1..<shifted.width, 1..<shifted.height],
                           image[0..<image.width-1, 0..<image.height-1])
            XCTAssertEqual(shifted[row: 0], Image(width: 4, height: 1, color: color))
            XCTAssertEqual(shifted[col: 0], Image(width: 1, height: 5, color: color))
        }
        do {
            let shifted = image.shifted(x: 2, y: -1, edgeMode: .wrap)
            
            XCTAssertEqual(shifted[2..<shifted.width, 0..<shifted.height-1],
                           image[0..<image.width-2, 1..<image.height])
            XCTAssertEqual(shifted[2..<shifted.width, shifted.height-1..<shifted.height],
                           image[0..<image.width-2, 0..<1])
            XCTAssertEqual(shifted[0..<2, 0..<shifted.height-1],
                           image[image.width-2..<image.width, 1..<image.height])
            XCTAssertEqual(shifted[0..<2, shifted.height-1..<shifted.height],
                           image[image.width-2..<image.width, 0..<1])
        }
    }
}
