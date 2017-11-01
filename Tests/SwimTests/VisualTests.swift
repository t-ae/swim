
import XCTest
import Swim

// Set brakepoints and look NSImages in Xcode debugger

class VisualTests: XCTestCase {
    #if !SWIFT_PACKAGE && os(macOS)
    
    func testAlphaBlend() {
        var imageBase = Image<RGB, Float>(width: 100, height: 100, data: [Float](repeating: 1, count: 100*100*3))
        imageBase[20..<60, 20..<60] = Image(width: 40, height: 40, pixel: Pixel<RGB, Float>(r: 1, g: 0, b: 0))
        
        var imageAlpha = Image<RGBA, Float>(width: 100, height: 100, data: [Float](repeating: 0, count: 100*100*4))
        imageAlpha[40..<80, 40..<80] = Image(width: 40, height: 40, pixel: Pixel<RGBA, Float>(r: 0, g: 0, b: 1, a: 0.5))
        
        imageBase.alphaBlend(with: imageAlpha)
        
        let rgb256 = (imageBase * 255).converted(to: UInt8.self)
        let rgba256 = Image<RGBA, UInt8>(image: rgb256, alpha: 255)
        let nsImage = rgba256.nsImage()
        
        _ = nsImage
    }
    
    #endif
}
