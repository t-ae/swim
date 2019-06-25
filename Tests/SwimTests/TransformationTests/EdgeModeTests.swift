import XCTest
import Swim

class EdgeModeTests: XCTestCase {

    func testConstant() {
        do {
            let constant = Color<RGBA, Int>(data: [100, 101, 102, 103])
            let edgeMode = EdgeMode<RGBA, Int>.constant(color: constant)
            
            XCTAssertNil(edgeMode.clampValue(value: -1, max: 1))
            XCTAssertEqual(edgeMode.clampValue(value: 0, max: 1), 0)
            XCTAssertNil(edgeMode.clampValue(value: 1, max: 1))
            
            XCTAssertEqual(edgeMode.clampValue(value: -3, max: 3), nil)
            XCTAssertEqual(edgeMode.clampValue(value: -2, max: 3), nil)
            XCTAssertEqual(edgeMode.clampValue(value: -1, max: 3), nil)
            XCTAssertEqual(edgeMode.clampValue(value: 0, max: 3), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 1, max: 3), 1)
            XCTAssertEqual(edgeMode.clampValue(value: 2, max: 3), 2)
            XCTAssertEqual(edgeMode.clampValue(value: 3, max: 3), nil)
            XCTAssertEqual(edgeMode.clampValue(value: 4, max: 3), nil)
            XCTAssertEqual(edgeMode.clampValue(value: 5, max: 3), nil)
        }
        do {
            let image = Image(width: 2, height: 2, rgba: (0..<16).map { $0 })
            let constant = Color<RGBA, Int>(data: [100, 101, 102, 103])
            let edgeMode = EdgeMode<RGBA, Int>.constant(color: constant)
            
            XCTAssertEqual(image[0, 0, edgeMode: edgeMode], image[0, 0])
            XCTAssertEqual(image[1, 0, edgeMode: edgeMode], image[1, 0])
            XCTAssertEqual(image[0, 1, edgeMode: edgeMode], image[0, 1])
            XCTAssertEqual(image[1, 1, edgeMode: edgeMode], image[1, 1])
            
            XCTAssertEqual(image[-1, 0, edgeMode: edgeMode], constant)
            XCTAssertEqual(image[0, -1, edgeMode: edgeMode], constant)
            XCTAssertEqual(image[2, 0, edgeMode: edgeMode], constant)
            XCTAssertEqual(image[0, 2, edgeMode: edgeMode], constant)
        }
    }

    func testEdge() {
        do {
            let edgeMode = EdgeMode<RGBA, Int>.edge
            
            XCTAssertEqual(edgeMode.clampValue(value: -1, max: 1), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 0, max: 1), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 1, max: 1), 0)
            
            XCTAssertEqual(edgeMode.clampValue(value: -3, max: 3), 0)
            XCTAssertEqual(edgeMode.clampValue(value: -2, max: 3), 0)
            XCTAssertEqual(edgeMode.clampValue(value: -1, max: 3), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 0, max: 3), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 1, max: 3), 1)
            XCTAssertEqual(edgeMode.clampValue(value: 2, max: 3), 2)
            XCTAssertEqual(edgeMode.clampValue(value: 3, max: 3), 2)
            XCTAssertEqual(edgeMode.clampValue(value: 4, max: 3), 2)
            XCTAssertEqual(edgeMode.clampValue(value: 5, max: 3), 2)
        }
        do {
            let image = Image(width: 2, height: 2, rgba: (0..<16).map { $0 })
            let edgeMode = EdgeMode<RGBA, Int>.edge
            
            XCTAssertEqual(image[0, 0, edgeMode: edgeMode], image[0, 0])
            XCTAssertEqual(image[1, 0, edgeMode: edgeMode], image[1, 0])
            XCTAssertEqual(image[0, 1, edgeMode: edgeMode], image[0, 1])
            XCTAssertEqual(image[1, 1, edgeMode: edgeMode], image[1, 1])
            
            XCTAssertEqual(image[-1, 0, edgeMode: edgeMode], image[0, 0])
            XCTAssertEqual(image[0, -1, edgeMode: edgeMode], image[0, 0])
            XCTAssertEqual(image[2, 0, edgeMode: edgeMode], image[1, 0])
            XCTAssertEqual(image[0, 2, edgeMode: edgeMode], image[0, 1])
            
            XCTAssertEqual(image[-10, -10, edgeMode: edgeMode], image[0, 0])
            XCTAssertEqual(image[10, -10, edgeMode: edgeMode], image[1, 0])
            XCTAssertEqual(image[-10, 10, edgeMode: edgeMode], image[0, 1])
            XCTAssertEqual(image[10, 10, edgeMode: edgeMode], image[1, 1])
        }
    }
    
    func testWrap() {
        do {
            let edgeMode = EdgeMode<RGBA, Int>.wrap
            
            XCTAssertEqual(edgeMode.clampValue(value: -1, max: 1), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 0, max: 1), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 1, max: 1), 0)
            
            XCTAssertEqual(edgeMode.clampValue(value: -3, max: 3), 0)
            XCTAssertEqual(edgeMode.clampValue(value: -2, max: 3), 1)
            XCTAssertEqual(edgeMode.clampValue(value: -1, max: 3), 2)
            XCTAssertEqual(edgeMode.clampValue(value: 0, max: 3), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 1, max: 3), 1)
            XCTAssertEqual(edgeMode.clampValue(value: 2, max: 3), 2)
            XCTAssertEqual(edgeMode.clampValue(value: 3, max: 3), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 4, max: 3), 1)
            XCTAssertEqual(edgeMode.clampValue(value: 5, max: 3), 2)
        }
        do {
            let image = Image(width: 2, height: 2, rgba: (0..<16).map { $0 })
            let edgeMode = EdgeMode<RGBA, Int>.wrap
            
            XCTAssertEqual(image[0, 0, edgeMode: edgeMode], image[0, 0])
            XCTAssertEqual(image[1, 0, edgeMode: edgeMode], image[1, 0])
            XCTAssertEqual(image[0, 1, edgeMode: edgeMode], image[0, 1])
            XCTAssertEqual(image[1, 1, edgeMode: edgeMode], image[1, 1])
            
            XCTAssertEqual(image[-1, 0, edgeMode: edgeMode], image[1, 0])
            XCTAssertEqual(image[0, -1, edgeMode: edgeMode], image[0, 1])
            XCTAssertEqual(image[2, 0, edgeMode: edgeMode], image[0, 0])
            XCTAssertEqual(image[0, 2, edgeMode: edgeMode], image[0, 0])
            
            XCTAssertEqual(image[-1, -1, edgeMode: edgeMode], image[1, 1])
            XCTAssertEqual(image[2, -1, edgeMode: edgeMode], image[0, 1])
            XCTAssertEqual(image[-1, 2, edgeMode: edgeMode], image[1, 0])
            XCTAssertEqual(image[2, 2, edgeMode: edgeMode], image[0, 0])
        }
    }
    
    func testSymmetric() {
        do {
            let edgeMode = EdgeMode<RGBA, Int>.symmetric
            
            XCTAssertEqual(edgeMode.clampValue(value: -1, max: 1), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 0, max: 1), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 1, max: 1), 0)
            
            XCTAssertEqual(edgeMode.clampValue(value: -3, max: 3), 2)
            XCTAssertEqual(edgeMode.clampValue(value: -2, max: 3), 1)
            XCTAssertEqual(edgeMode.clampValue(value: -1, max: 3), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 0, max: 3), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 1, max: 3), 1)
            XCTAssertEqual(edgeMode.clampValue(value: 2, max: 3), 2)
            XCTAssertEqual(edgeMode.clampValue(value: 3, max: 3), 2)
            XCTAssertEqual(edgeMode.clampValue(value: 4, max: 3), 1)
            XCTAssertEqual(edgeMode.clampValue(value: 5, max: 3), 0)
        }
        do {
            let image = Image(width: 2, height: 2, rgba: (0..<16).map { $0 })
            let edgeMode = EdgeMode<RGBA, Int>.symmetric
            
            XCTAssertEqual(image[0, 0, edgeMode: edgeMode], image[0, 0])
            XCTAssertEqual(image[1, 0, edgeMode: edgeMode], image[1, 0])
            XCTAssertEqual(image[0, 1, edgeMode: edgeMode], image[0, 1])
            XCTAssertEqual(image[1, 1, edgeMode: edgeMode], image[1, 1])
            
            XCTAssertEqual(image[-1, 0, edgeMode: edgeMode], image[0, 0])
            XCTAssertEqual(image[0, -1, edgeMode: edgeMode], image[0, 0])
            XCTAssertEqual(image[2, 0, edgeMode: edgeMode], image[1, 0])
            XCTAssertEqual(image[0, 2, edgeMode: edgeMode], image[0, 1])
            
            XCTAssertEqual(image[-1, -1, edgeMode: edgeMode], image[0, 0])
            XCTAssertEqual(image[2, -1, edgeMode: edgeMode], image[1, 0])
            XCTAssertEqual(image[-1, 2, edgeMode: edgeMode], image[0, 1])
            XCTAssertEqual(image[2, 2, edgeMode: edgeMode], image[1, 1])
        }
    }
    
    func testReflect() {
        do {
            let edgeMode = EdgeMode<RGBA, Int>.reflect
            
            XCTAssertEqual(edgeMode.clampValue(value: -1, max: 1), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 0, max: 1), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 1, max: 1), 0)
            
            XCTAssertEqual(edgeMode.clampValue(value: -3, max: 3), 1)
            XCTAssertEqual(edgeMode.clampValue(value: -2, max: 3), 2)
            XCTAssertEqual(edgeMode.clampValue(value: -1, max: 3), 1)
            XCTAssertEqual(edgeMode.clampValue(value: 0, max: 3), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 1, max: 3), 1)
            XCTAssertEqual(edgeMode.clampValue(value: 2, max: 3), 2)
            XCTAssertEqual(edgeMode.clampValue(value: 3, max: 3), 1)
            XCTAssertEqual(edgeMode.clampValue(value: 4, max: 3), 0)
            XCTAssertEqual(edgeMode.clampValue(value: 5, max: 3), 1)
        }
        do {
            let image = Image(width: 2, height: 2, rgba: (0..<16).map { $0 })
            let edgeMode = EdgeMode<RGBA, Int>.reflect
            
            XCTAssertEqual(image[0, 0, edgeMode: edgeMode], image[0, 0])
            XCTAssertEqual(image[1, 0, edgeMode: edgeMode], image[1, 0])
            XCTAssertEqual(image[0, 1, edgeMode: edgeMode], image[0, 1])
            XCTAssertEqual(image[1, 1, edgeMode: edgeMode], image[1, 1])
            
            XCTAssertEqual(image[-1, 0, edgeMode: edgeMode], image[1, 0])
            XCTAssertEqual(image[0, -1, edgeMode: edgeMode], image[0, 1])
            XCTAssertEqual(image[2, 0, edgeMode: edgeMode], image[0, 0])
            XCTAssertEqual(image[0, 2, edgeMode: edgeMode], image[0, 0])
            
            XCTAssertEqual(image[-1, -1, edgeMode: edgeMode], image[1, 1])
            XCTAssertEqual(image[2, -1, edgeMode: edgeMode], image[0, 1])
            XCTAssertEqual(image[-1, 2, edgeMode: edgeMode], image[1, 0])
            XCTAssertEqual(image[2, 2, edgeMode: edgeMode], image[0, 0])
        }
    }
    
    static let allTests = [
        ("testConstant", testConstant),
        ("testEdge", testEdge),
        ("testWrap", testWrap),
        ("testSymmetric", testSymmetric),
        ("testReflect", testReflect)
    ]
}
