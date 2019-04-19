import XCTest
import Swim

class AlphaBlendVisualTests: XCTestCase {
    func testAlphaBlend() {
        var imageBase = Image<RGB, Double>(width: 500,
                                           height: 500,
                                           value: 1)
        
        let red = Shape.circle(size: 200,
                               lineWidth: 3,
                               lineColor: Pixel(r: 1.0, g: 0.0, b: 0.0, a: 1.0),
                               fillColor: Pixel(r: 1.0, g: 0.0, b: 0.0, a: 0.5))
        let green = Shape.circle(size: 200,
                                 lineWidth: 3,
                                 lineColor: Pixel(r: 0.0, g: 1.0, b: 0.0, a: 1.0),
                                 fillColor: Pixel(r: 0.0, g: 1.0, b: 0.0, a: 0.5))
        let blue = Shape.circle(size: 200,
                                lineWidth: 3,
                                lineColor: Pixel(r: 0.0, g: 0.0, b: 1.0, a: 1.0),
                                fillColor: Pixel(r: 0.0, g: 0.0, b: 1.0, a: 0.5))
        
        
        imageBase[150..<350, 100..<300].alphaBlend(with: red)
        imageBase[100..<300, 200..<400].alphaBlend(with: green)
        imageBase[200..<400, 200..<400].alphaBlend(with: blue)
        
        let rgb256 = (imageBase * 255).dataTypeConverter.cast(to: UInt8.self)
        let nsImage = rgb256.nsImage()
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
}
