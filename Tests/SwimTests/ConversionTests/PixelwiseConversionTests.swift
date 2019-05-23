import XCTest
import Swim

class PixelwiseConversion: XCTestCase {
    func testConvert() {
        do {
            let data = (0..<6).map { UInt8($0) }
            var image = Image(width: 2, height: 3, gray: data)
            let after = Image(width: 2, height: 3, gray: data.map { $0 + 1 })

            image.pixelwiseConvert { px in
                px += 1
            }
            XCTAssertEqual(image, after)
        }
        do {
            let data = (0..<24).map { UInt8($0) }
            var image = Image(width: 2, height: 3, rgba: data)
            let after = Image(width: 2, height: 3, rgba: data.map { $0 + 1 })
            
            image.pixelwiseConvert { px in px += 1 }
            XCTAssertEqual(image, after)

        }
    }
    
    func testConverted() {
        do {
            let data = (0..<24).map { UInt8($0) }
            let image = Image(width: 2, height: 3, rgba: data)

            let red = image.pixelwiseConverted { px in
                Pixel(gray: px[.red])
            }
            XCTAssertEqual(red, Image(width: 2, height: 3, data: [0, 4, 8, 12, 16, 20]))
            
            let redDouble = image.pixelwiseConverted { px in
                Pixel(gray: Double(px[.red]))
            }
            XCTAssertEqual(redDouble, Image(width: 2, height: 3, data: [0, 4, 8, 12, 16, 20]))
        }
    }
    
    static let allTests = [
        ("testConvert", testConvert),
        ("testConverted", testConverted)
    ]
}
