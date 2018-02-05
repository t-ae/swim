
import XCTest
import Swim

class ResizeTests: XCTestCase {
    func testDownscale() {
        let image = Image(width: 4,
                          height: 4,
                          rgba: [0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                                 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                                 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3,
                                 2, 2, 2, 2, 2, 2, 2, 2, 3, 3, 3, 3, 3, 3, 3, 3].map { UInt8($0) })
        let resized = image.resized(width: 2, height: 2)
        XCTAssertEqual(resized, Image(width: 2, height: 2, data: [0, 0, 0, 0, 1, 1, 1, 1,
                                                                  2, 2, 2, 2, 3, 3, 3, 3]))
    }
}

#if !SWIFT_PACKAGE && os(macOS)
extension ResizeTests {
    func testResized() {
        // UInt8
        do {
            // upscale
            let image: Image<RGBA, UInt8> = Shape.circle(size: 64,
                                                         lineWidth: 3,
                                                         lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
            
            let resized = image.resized(width: 300, height: 300)!
            let ns = resized.nsImage()
            print("break here")
            _ = ns
        }
        do {
            //downscale
            let image: Image<RGBA, UInt8> = Shape.circle(size: 300,
                                                         lineWidth: 3,
                                                         lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
            
            let resized = image.resized(width: 64, height: 64)!
            let ns = resized.nsImage()
            print("break here")
            _ = ns
        }
        // Float
        do {
            // upscale
            let image: Image<RGBA, Float> = Shape.circle(size: 64,
                                                         lineWidth: 3,
                                                         lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
            
            let resized = image.resized(width: 300, height: 300)!
            let ns = resized.typeConverted(to: UInt8.self).nsImage()
            print("break here")
            _ = ns
        }
        do {
            //downscale
            let image: Image<RGBA, Float> = Shape.circle(size: 300,
                                                         lineWidth: 3,
                                                         lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
            
            let resized = image.resized(width: 64, height: 64)!
            let ns = resized.typeConverted(to: UInt8.self).nsImage()
            print("break here")
            _ = ns
        }
    }
    
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
