
import XCTest
import Swim

class TransformTests: XCTestCase {
    
    func testFlipLR() {
        do {
            let data = (0..<10).map { UInt8($0) }
            let image = Image<Intensity, UInt8>(width: 2, height: 5, data: data)
            
            let flipped = image.flipLR()
            XCTAssertEqual(flipped.data, [1, 0,
                                          3, 2,
                                          5, 4,
                                          7, 6,
                                          9, 8])
        }
        do {
            let data = (0..<16).map { UInt8($0) }
            let image = Image<RGBA, UInt8>(width: 2, height: 2, data: data)
            
            let flipped = image.flipLR()
            XCTAssertEqual(flipped.data, [4, 5, 6, 7,
                                          0, 1, 2, 3,
                                          12, 13, 14, 15,
                                          8, 9, 10, 11])
        }
    }
    
    func testFlipUD() {
        do {
            let data = (0..<10).map { UInt8($0) }
            let image = Image<Intensity, UInt8>(width: 2, height: 5, data: data)
            
            let flipped = image.flipUD()
            XCTAssertEqual(flipped.data, [8, 9,
                                          6, 7,
                                          4, 5,
                                          2, 3,
                                          0, 1])
        }
        do {
            let data = (0..<16).map { UInt8($0) }
            let image = Image<RGBA, UInt8>(width: 2, height: 2, data: data)
            
            let flipped = image.flipUD()
            XCTAssertEqual(flipped.data, [8, 9, 10, 11,
                                          12, 13, 14, 15,
                                          0, 1, 2, 3,
                                          4, 5, 6, 7])
        }
    }
    
}
