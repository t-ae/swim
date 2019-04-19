import XCTest
import Swim

class TransformationTests: XCTestCase {
    
    func testFlipLR() {
        do {
            let data = (0..<10).map { UInt8($0) }
            let image = Image(width: 2, height: 5, intensity: data)
            
            let flipped = image.transform.flipLR()
            XCTAssertEqual(flipped,
                           Image(width: 2, height: 5, data: [1, 0,
                                                             3, 2,
                                                             5, 4,
                                                             7, 6,
                                                             9, 8]))
        }
        do {
            let data = (0..<16).map { UInt8($0) }
            let image = Image(width: 2, height: 2, rgba: data)
            
            let flipped = image.transform.flipLR()
            XCTAssertEqual(flipped,
                           Image(width: 2, height: 2, data: [4, 5, 6, 7,
                                                             0, 1, 2, 3,
                                                             12, 13, 14, 15,
                                                             8, 9, 10, 11]))
        }
    }
    
    func testFlipUD() {
        do {
            let data = (0..<10).map { UInt8($0) }
            let image = Image(width: 2, height: 5, intensity: data)
            
            let flipped = image.transform.flipUD()
            XCTAssertEqual(flipped,
                           Image(width: 2, height: 5, data: [8, 9,
                                                             6, 7,
                                                             4, 5,
                                                             2, 3,
                                                             0, 1]))
        }
        do {
            let data = (0..<16).map { UInt8($0) }
            let image = Image(width: 2, height: 2, rgba: data)
            
            let flipped = image.transform.flipUD()
            XCTAssertEqual(flipped,
                           Image(width: 2, height: 2, data: [8, 9, 10, 11,
                                                             12, 13, 14, 15,
                                                             0, 1, 2, 3,
                                                             4, 5, 6, 7]))
        }
    }
    
    func testRot() {
        do {
            let data = (0..<2*3*3).map { UInt8($0) }
            let image = Image(width: 3, height: 2, rgb: data)
            
            XCTAssertEqual(image.transform.rot90(),
                           Image(width: 2, height: 3, data: [9, 10, 11, 0, 1, 2,
                                                             12, 13, 14, 3, 4, 5,
                                                             15, 16, 17, 6, 7, 8]))
        }
        do {
            let data = (0..<40).map { UInt8($0) }
            let image = Image(width: 2, height: 5, rgba: data)
            
            let r180 = image.transform.rot180()
            let r270 = image.transform.rot270()
            
            XCTAssertEqual(r180, image.transform.rot90().transform.rot90())
            XCTAssertEqual(r270, image.transform.rot90().transform.rot90().transform.rot90())
        }
    }
}
