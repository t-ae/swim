import XCTest
import Swim

class PixelwiseConversion: XCTestCase {
    
    func testConversion() {
        do {
            let data = (0..<6).map { UInt8($0) }
            var image = Image(width: 2, height: 3, intensity: data)
            let after = Image(width: 2, height: 3, intensity: data.map { $0 + 1 })

            XCTAssertEqual(image.pixelwiseConverted { (px: UInt8) in px + 1 }, after)
            image.pixelwiseConvert { (px: UInt8) -> UInt8 in
                px + 1
            }
            XCTAssertEqual(image, after)
        }
        do {
            let data = (0..<6).map { UInt8($0) }
            var image = Image(width: 2, height: 3, intensity: data)
            let after = Image(width: 2, height: 3, intensity: data.map { $0 + 1 })

            XCTAssertEqual(image.pixelwiseConverted { (px: Pixel<Intensity, UInt8>) -> Pixel<Intensity, UInt8> in px + 1 }, after)
            image.pixelwiseConvert { (px: Pixel<Intensity, UInt8>) -> Pixel<Intensity, UInt8> in
                px + 1
            }
            XCTAssertEqual(image, after)
        }
        do {
            let data = (0..<6).map { UInt8($0) }
            let image = Image(width: 2, height: 3, intensity: data)
            let a: [UInt8] = data.flatMap { (v: UInt8) -> [UInt8] in [v, v+1, v+2, v+3] }
            let afterData: [Float] = a.map { Float($0) }
            let after = Image(width: 2, height: 3, rgba: afterData)

            let result: Image<RGBA, Float> = image.pixelwiseConverted { (px: UInt8) in
                let uints: [UInt8] = [px, px+1, px+2, px+3]
                return Pixel<RGBA, Float>(data: uints.map(Float.init))
            }
            XCTAssertEqual(result, after)
        }
        do {
            let data = (0..<24).map { UInt8($0) }
            var image = Image(width: 2, height: 3, rgba: data)
            let after = Image(width: 2, height: 3, rgba: data.map { $0 + 1 })
            
            XCTAssertEqual(image.pixelwiseConverted { (px: Pixel<RGBA, UInt8>) in px + 1 }, after)
            image.pixelwiseConvert { px in px + 1 }
            XCTAssertEqual(image, after)

        }
    }
    
    func testConverted() {
        do {
            let data = (0..<24).map { UInt8($0) }
            let image = Image(width: 2, height: 3, rgba: data)

            let red = image.pixelwiseConverted { (px: Pixel<RGBA, UInt8>) -> UInt8 in
                px[.red]
            }
            XCTAssertEqual(red, Image(width: 2, height: 3, data: [0, 4, 8, 12, 16, 20]))
            
            let redDouble = image.pixelwiseConverted { (px: Pixel<RGBA, UInt8>) -> Double in
                Double(px[.red])
            }
            XCTAssertEqual(redDouble, Image(width: 2, height: 3, data: [0, 4, 8, 12, 16, 20]))
        }
        do {
            let data = (0..<6).map { UInt8($0) }
            let image = Image(width: 2, height: 3, intensity: data)
            
            let rgb = image.pixelwiseConverted { (px: UInt8) -> Pixel<RGB, Double> in
                Pixel<RGB, Double>(r: Double(px), g: Double(px), b: Double(px))
            }
            XCTAssertEqual(rgb,
                           Image(width: 2,
                                 height: 3,
                                 data: [0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 4, 5, 5, 5]))
        }
        
    }
}
