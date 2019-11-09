import XCTest
import Swim

class PixelwiseConversion: XCTestCase {
    func testConvert() {
        do {
            let data = (0..<6).map { UInt8($0) }
            var image = Image(width: 2, height: 3, gray: data)
            let after = Image(width: 2, height: 3, gray: data.map { $0 + 1 })

            image.unsafePixelwiseConvert { px in
                px += 1
            }
            XCTAssertEqual(image, after)
        }
        do {
            let data = (0..<24).map { UInt8($0) }
            var image = Image(width: 2, height: 3, rgba: data)
            let after = Image(width: 2, height: 3, rgba: data.map { $0 + 1 })
            
            image.unsafePixelwiseConvert { px in px += 1 }
            XCTAssertEqual(image, after)

        }
    }
    
    func testConvertRange() {
        do {
            let data = (0..<24).map { UInt8($0) }
            var image = Image(width: 2, height: 3, rgba: data)
            var after = Image(width: 2, height: 3, rgba: data)
            after[1, 1] += 1
            after[1, 2] += 1
            
            image.unsafePixelwiseConvert(1..<2, 1..<3) { $0 += 1 }
            XCTAssertEqual(image, after)
        }
    }
    
    func testConverted() {
        do {
            let data = (0..<24).map { UInt8($0) }
            let image = Image(width: 2, height: 3, rgba: data)

            let red: Image<Gray, UInt8> = image.unsafePixelwiseConverted { src, dst in
                dst.initialize(channel: .gray, to: src[.red])
            }
            XCTAssertEqual(red, Image(width: 2, height: 3, data: [0, 4, 8, 12, 16, 20]))
            
            let redDouble: Image<Gray, Double> = image.unsafePixelwiseConverted { src, dst in
                dst.initialize(channel: .gray, to: Double(src[.red]))
            }
            XCTAssertEqual(redDouble, Image(width: 2, height: 3, data: [0, 4, 8, 12, 16, 20]))
        }
    }
    
    static let allTests = [
        ("testConvert", testConvert),
        ("testConvertRange", testConvertRange),
        ("testConverted", testConverted)
    ]
}
