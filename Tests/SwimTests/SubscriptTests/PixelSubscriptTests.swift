import XCTest
import Swim

class PixelSubscriptTests: XCTestCase {
    
    func testSubscriptGet() {
        do {
            let data = (0..<16).map { UInt8($0) }
            let image = Image(width: 4, height: 4, gray: data)
            
            // channel
            XCTAssertEqual(image[0, 0, 0], 0)
            XCTAssertEqual(image[1, 0, 0], 1)
            XCTAssertEqual(image[0, 1, 0], 4)
            XCTAssertEqual(image[1, 1, 0], 5)
            
            // pixel
            XCTAssertEqual(image[0, 0], Pixel(gray: 0))
            XCTAssertEqual(image[1, 0], Pixel(gray: 1))
            XCTAssertEqual(image[0, 1], Pixel(gray: 4))
            XCTAssertEqual(image[1, 1], Pixel(gray: 5))
            
            // mix
            XCTAssertEqual(image[0, 0][0], 0)
        }
        do {
            let data = (0..<64).map { UInt8($0) }
            let image = Image(width: 4, height: 4, rgba: data)
            
            // channel
            XCTAssertEqual(image[0, 0, 0], 0)
            XCTAssertEqual(image[1, 0, 1], 5)
            XCTAssertEqual(image[0, 1, 2], 18)
            XCTAssertEqual(image[0, 1, 3], 19)
            
            // pixel
            XCTAssertEqual(image[0, 0], Pixel(r: 0, g: 1, b: 2, a: 3))
            XCTAssertEqual(image[1, 0], Pixel(r: 4, g: 5, b: 6, a: 7))
            XCTAssertEqual(image[0, 1], Pixel(r: 16, g: 17, b: 18, a: 19))
            
            // mix
            XCTAssertEqual(image[0, 0][0], 0)
            XCTAssertEqual(image[1, 0][.green], 5)
            XCTAssertEqual(image[0, 1][2], 18)
            XCTAssertEqual(image[0, 1][.alpha], 19)
        }
    }
    
    func testSubscriptSet() {
        do {
            let data = (0..<4).map { Double($0) }
            var image = Image(width: 2, height: 2, gray: data)
            XCTAssertEqual(image, Image(width: 2, height: 2, data: [0, 1, 2, 3]))
            
            image[0, 0, 0] = 100
            XCTAssertEqual(image, Image(width: 2, height: 2, data: [100, 1, 2, 3]))
            
            image[1, 0] = Pixel(gray: 5)
            XCTAssertEqual(image, Image(width: 2, height: 2, data: [100, 5, 2, 3]))
            
            image[0, 1][0] = 6
            XCTAssertEqual(image, Image(width: 2, height: 2, data: [100, 5, 6, 3]))
            
            image[1, 1][.gray] = 7
            XCTAssertEqual(image, Image(width: 2, height: 2, data: [100, 5, 6, 7]))
        }
        do {
            let data = (0..<16).map { UInt8($0) }
            var image = Image(width: 2, height: 2, rgba: data)
            
            image[0, 0, 0] = 100
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [100, 1, 2, 3,
                                                             4, 5, 6, 7,
                                                             8, 9, 10, 11,
                                                             12, 13, 14, 15]))
            
            image[1, 0] = Pixel(r: 99, g: 98, b: 97, a: 96)
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [100, 1, 2, 3,
                                                             99, 98, 97, 96,
                                                             8, 9, 10, 11, 12,
                                                             13, 14, 15]))
            
            image[0, 0][1] = 66
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [100, 66, 2, 3,
                                                             99, 98, 97, 96,
                                                             8, 9, 10, 11,
                                                             12, 13, 14, 15]))
            
            image[0, 0][.blue] = 67
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [100, 66, 67, 3,
                                                             99, 98, 97, 96,
                                                             8, 9, 10, 11,
                                                             12, 13, 14, 15]))
            
            image[0, 1] += 1
            XCTAssertEqual(image,
                           Image(width: 2, height: 2, data: [100, 66, 67, 3,
                                                             99, 98, 97, 96,
                                                             9, 10, 11, 12,
                                                             12, 13, 14, 15]))
        }
    }
    
    static let allTests = [
        ("testSubscriptGet", testSubscriptGet),
        ("testSubscriptSet", testSubscriptSet)
    ]
}
