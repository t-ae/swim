import XCTest
import Swim

class SubimageVIsualTests: XCTestCase {
    func testSubimage() {
        let path = testResoruceRoot().appendingPathComponent("lena_256.png")
        let lena = try! Image<RGB, Double>(contentsOf: path)
        let zero = Image<Intensity, Double>(width: lena.width, height: lena.height, value: 0)
        
        var images: [Image<RGB, Double>] = []
        
        let red = Image(r: lena[channel: .red], g: zero, b: zero)
        images.append(red)
        let green = Image(r: zero, g: lena[channel: .green], b: zero)
        images.append(green)
        let blue = Image(r: zero, g: zero, b: lena[channel: .blue])
        images.append(blue)
        let sum = red + green + blue
        images.append(sum)
        
        let nsImage = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages in debugger.")
    }
}
