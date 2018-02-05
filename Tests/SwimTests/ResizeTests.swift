
import XCTest
import Swim

class ResizeTests: XCTestCase {
}

#if !SWIFT_PACKAGE && os(macOS)
extension ResizeTests {
    func testResizenn() {
        do {
            // upscale
            let image: Image<RGBA, Float> = Shape.circle(size: 64,
                                                         lineWidth: 3,
                                                         lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
            
            let resized = image.resizenn(width: 300, height: 300)
            let ns = resized.typeConverted(to: UInt8.self).nsImage()
            print("break here")
            _ = ns
        }
        do {
            //downscale
            let image: Image<RGBA, Float> = Shape.circle(size: 300,
                                                         lineWidth: 3,
                                                         lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
            
            let resized = image.resizenn(width: 64, height: 64)
            let ns = resized.typeConverted(to: UInt8.self).nsImage()
            print("break here")
            _ = ns
        }
    }
    
    func testResizeaa() {
        do {
            // upscale
            let image: Image<RGBA, Float> = Shape.circle(size: 64,
                                                         lineWidth: 3,
                                                         lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
            
            let resized = image.resizeaa(width: 300, height: 300)
            let ns = resized.typeConverted(to: UInt8.self).nsImage()
            print("break here")
            _ = ns
        }
        do {
            //downscale
            let image: Image<RGBA, Float> = Shape.circle(size: 300,
                                                         lineWidth: 3,
                                                         lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
            
            let resized = image.resizeaa(width: 64, height: 64)
            let ns = resized.typeConverted(to: UInt8.self).nsImage()
            print("break here")
            _ = ns
        }
    }
    
    func testResizebn() {
        do {
            // upscale
            let image: Image<RGBA, Float> = Shape.circle(size: 64,
                                                         lineWidth: 3,
                                                         lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
            
            let resized = image.resizebn(width: 300, height: 300)
            let ns = resized.typeConverted(to: UInt8.self).nsImage()
            print("break here")
            _ = ns
        }
        do {
            //downscale
            let image: Image<RGBA, Float> = Shape.circle(size: 300,
                                                         lineWidth: 3,
                                                         lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
            
            let resized = image.resizebn(width: 64, height: 64)
            let ns = resized.typeConverted(to: UInt8.self).nsImage()
            print("break here")
            _ = ns
        }
    }
}
#endif
