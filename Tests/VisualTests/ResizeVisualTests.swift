import XCTest
import Swim

class ResizeVisualTests: XCTestCase {
    func testResize() {
        do {
            let image = Image<RGB, Float>(width: 4,
                                          height: 4,
                                          data: (0..<4*4*3).map { _ in Float.random(in: 0..<1) })
            
            let resizedNN = image.resize(width: 128, height: 192, method: .nearestNeighbor)
            let resizedBL = image.resize(width: 128, height: 192, method: .bilinear)
            let resizedBC = image.resize(width: 128, height: 192, method: .bicubic)
                .clipped(low: 0, high: 1)
            
            let concat = Image<RGB, Float>.concatH([resizedNN, resizedBL, resizedBC])
            
            let rgb256 = (concat * 255).typeConverted(to: UInt8.self)
            let nsImage = rgb256.nsImage()
            
            XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
        }
    }
    
    func testResizeUpscale_lena() {
        let path = testResoruceRoot().appendingPathComponent("lena_128.png")
        let lena = Image<RGB, Double>(contentsOf: path)!
        
        var images = [Image<RGB, Double>]()
        
        images.append(lena.resize(width: 768, height: 768, method: .nearestNeighbor))
        images.append(lena.resize(width: 768, height: 768, method: .bilinear))
        images.append(lena.resize(width: 768, height: 768, method: .bicubic))
        
        let image = Image.concatH(images)
        
        let nsImage = doubleToNSImage(Image<RGBA, Double>(image: image, alpha: 1))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testResizeDownscale_lena() {
        let path = testResoruceRoot().appendingPathComponent("lena_512.png")
        let lena = Image<RGB, Double>(contentsOf: path)!
        
        var images = [Image<RGB, Double>]()
        
        images.append(lena.resize(width: 112, height: 112, method: .nearestNeighbor))
        images.append(lena.resize(width: 112, height: 112, method: .bilinear))
        images.append(lena.resize(width: 112, height: 112, method: .bicubic))
        
        let image = Image.concatH(images)
        
        let nsImage = doubleToNSImage(Image<RGBA, Double>(image: image, alpha: 1))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
}
