import XCTest
import Swim

class ExtremaTests: XCTestCase {
    func testExtrema() {
        var image = Image<RGB, Double>(width: 4, height: 4, data: (0..<48).map { Double($0) })
        do { // shuffle pixels
            for _ in 0..<100 {
                let x0 = (0..<4).randomElement()!
                let y0 = (0..<4).randomElement()!
                let x1 = (0..<4).randomElement()!
                let y1 = (0..<4).randomElement()!
                
                let c = image[x0, y0]
                image[x0, y0] = image[x1, y1]
                image[x1, y1] = c
            }
        }
        
        do {
            let (min, max) = image.extrema()
            XCTAssertEqual(min, 0)
            XCTAssertEqual(max, 47)
        }
        do {
            let (min, max) = image.extrema(channel: .red)
            XCTAssertEqual(min, 0)
            XCTAssertEqual(max, 45)
        }
        do {
            let (min, max) = image.extrema(channel: .green)
            XCTAssertEqual(min, 1)
            XCTAssertEqual(max, 46)
        }
        do {
            let (min, max) = image.extrema(channel: .blue)
            XCTAssertEqual(min, 2)
            XCTAssertEqual(max, 47)
        }
    }
    
    static let allTests = [
        ("testExtrema", testExtrema)
    ]
}
