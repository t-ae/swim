
import XCTest
import Swim

class PixelwiseConversion: XCTestCase {
    
    func testConversion() {
        do {
            let data = (0..<2*3).map { UInt8($0) }
            var image = Image<Intensity, UInt8>(width: 2, height: 3, data: data)
            let after = Image<Intensity, UInt8>(width: 2, height: 3, data: data.map { $0 + 1 })

            XCTAssertEqual(image.converted { (px: UInt8) in px + 1 }, after)
            image.convert { (px: UInt8) -> UInt8 in
                px + 1
            }
            XCTAssertEqual(image, after)
        }
        do {
            let data = (0..<2*3).map { UInt8($0) }
            var image = Image<Intensity, UInt8>(width: 2, height: 3, data: data)
            let after = Image<Intensity, UInt8>(width: 2, height: 3, data: data.map { $0 + 1 })

            XCTAssertEqual(image.converted { px -> Pixel<Intensity, UInt8> in px + 1 }, after)
            image.convert { (px: Pixel<Intensity, UInt8>) -> Pixel<Intensity, UInt8> in
                px + 1
            }
            XCTAssertEqual(image, after)
        }
        do {
            let data = (0..<2*3).map { UInt8($0) }
            let image = Image<Intensity, UInt8>(width: 2, height: 3, data: data)
            let a: [UInt8] = data.flatMap { (v: UInt8)-> [UInt8] in [v, v+1, v+2, v+3] }
            let afterData: [Float] = a.map { Float($0) }
            let after = Image<RGBA, Float>(width: 2, height: 3, data: afterData)

            let result: Image<RGBA, Float> = image.converted { (px: UInt8) in
                let uints: [UInt8] = [px, px+1, px+2, px+3]
                return Pixel<RGBA, Float>(data: uints.map(Float.init))
            }
            XCTAssertEqual(result, after)
        }
        do {
            let data = (0..<2*3*4).map { UInt8($0) }
            var image = Image<RGBA, UInt8>(width: 2, height: 3, data: data)
            let after = Image<RGBA, UInt8>(width: 2, height: 3, data: data.map { $0 + 1 })
            
            XCTAssertEqual(image.converted { px in px + 1 }, after)
            image.convert { px in px + 1 }
            XCTAssertEqual(image, after)

        }
    }
}
