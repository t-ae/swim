import XCTest
import Swim

class EdgeModeTests: XCTestCase {

    func testConstant() {
        let image = Image(width: 2, height: 2, rgba: (0..<16).map { $0 })
        let constant = Color<RGBA, Int>(data: [100, 101, 102, 103])
        let edgeMode = EdgeMode<RGBA, Int>.constant(color: constant)
        
        XCTAssertEqual(edgeMode.getColor(x: 0, y: 0, in: image), image[0, 0])
        XCTAssertEqual(edgeMode.getColor(x: 1, y: 0, in: image), image[1, 0])
        XCTAssertEqual(edgeMode.getColor(x: 0, y: 1, in: image), image[0, 1])
        XCTAssertEqual(edgeMode.getColor(x: 1, y: 1, in: image), image[1, 1])
        
        XCTAssertEqual(edgeMode.getColor(x: -1, y: 0, in: image), constant)
        XCTAssertEqual(edgeMode.getColor(x: 0, y: -1, in: image), constant)
        XCTAssertEqual(edgeMode.getColor(x: 2, y: 0, in: image), constant)
        XCTAssertEqual(edgeMode.getColor(x: 0, y: 2, in: image), constant)
    }

    func testEdge() {
        let image = Image(width: 2, height: 2, rgba: (0..<16).map { $0 })
        let edgeMode = EdgeMode<RGBA, Int>.edge
        
        XCTAssertEqual(edgeMode.getColor(x: 0, y: 0, in: image), image[0, 0])
        XCTAssertEqual(edgeMode.getColor(x: 1, y: 0, in: image), image[1, 0])
        XCTAssertEqual(edgeMode.getColor(x: 0, y: 1, in: image), image[0, 1])
        XCTAssertEqual(edgeMode.getColor(x: 1, y: 1, in: image), image[1, 1])
        
        XCTAssertEqual(edgeMode.getColor(x: -1, y: 0, in: image), image[0, 0])
        XCTAssertEqual(edgeMode.getColor(x: 0, y: -1, in: image), image[0, 0])
        XCTAssertEqual(edgeMode.getColor(x: 2, y: 0, in: image), image[1, 0])
        XCTAssertEqual(edgeMode.getColor(x: 0, y: 2, in: image), image[0, 1])
        
        XCTAssertEqual(edgeMode.getColor(x: -10, y: -10, in: image), image[0, 0])
        XCTAssertEqual(edgeMode.getColor(x: 10, y: -10, in: image), image[1, 0])
        XCTAssertEqual(edgeMode.getColor(x: -10, y: 10, in: image), image[0, 1])
        XCTAssertEqual(edgeMode.getColor(x: 10, y: 10, in: image), image[1, 1])
    }
    
    func testSymmetric() {
        let image = Image(width: 2, height: 2, rgba: (0..<16).map { $0 })
        let edgeMode = EdgeMode<RGBA, Int>.symmetric
        
        XCTAssertEqual(edgeMode.getColor(x: 0, y: 0, in: image), image[0, 0])
        XCTAssertEqual(edgeMode.getColor(x: 1, y: 0, in: image), image[1, 0])
        XCTAssertEqual(edgeMode.getColor(x: 0, y: 1, in: image), image[0, 1])
        XCTAssertEqual(edgeMode.getColor(x: 1, y: 1, in: image), image[1, 1])
        
        XCTAssertEqual(edgeMode.getColor(x: -1, y: 0, in: image), image[0, 0])
        XCTAssertEqual(edgeMode.getColor(x: 0, y: -1, in: image), image[0, 0])
        XCTAssertEqual(edgeMode.getColor(x: 2, y: 0, in: image), image[1, 0])
        XCTAssertEqual(edgeMode.getColor(x: 0, y: 2, in: image), image[0, 1])
        
        XCTAssertEqual(edgeMode.getColor(x: -1, y: -1, in: image), image[0, 0])
        XCTAssertEqual(edgeMode.getColor(x: 2, y: -1, in: image), image[1, 0])
        XCTAssertEqual(edgeMode.getColor(x: -1, y: 2, in: image), image[0, 1])
        XCTAssertEqual(edgeMode.getColor(x: 2, y: 2, in: image), image[1, 1])
    }
    
    func testReflect() {
        let image = Image(width: 2, height: 2, rgba: (0..<16).map { $0 })
        let edgeMode = EdgeMode<RGBA, Int>.reflect
        
        XCTAssertEqual(edgeMode.getColor(x: 0, y: 0, in: image), image[0, 0])
        XCTAssertEqual(edgeMode.getColor(x: 1, y: 0, in: image), image[1, 0])
        XCTAssertEqual(edgeMode.getColor(x: 0, y: 1, in: image), image[0, 1])
        XCTAssertEqual(edgeMode.getColor(x: 1, y: 1, in: image), image[1, 1])
        
        XCTAssertEqual(edgeMode.getColor(x: -1, y: 0, in: image), image[1, 0])
        XCTAssertEqual(edgeMode.getColor(x: 0, y: -1, in: image), image[0, 1])
        XCTAssertEqual(edgeMode.getColor(x: 2, y: 0, in: image), image[0, 0])
        XCTAssertEqual(edgeMode.getColor(x: 0, y: 2, in: image), image[0, 0])
        
        XCTAssertEqual(edgeMode.getColor(x: -1, y: -1, in: image), image[1, 1])
        XCTAssertEqual(edgeMode.getColor(x: 2, y: -1, in: image), image[0, 1])
        XCTAssertEqual(edgeMode.getColor(x: -1, y: 2, in: image), image[1, 0])
        XCTAssertEqual(edgeMode.getColor(x: 2, y: 2, in: image), image[0, 0])
    }
    
    static let allTests = [
        ("testConstant", testConstant),
        ("testEdge", testEdge),
        ("testSymmetric", testSymmetric),
        ("testReflect", testReflect)
    ]
}
