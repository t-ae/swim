
import XCTest
import Swim

class ResizeTests: XCTestCase {
    #if !SWIFT_PACKAGE && os(macOS)
    func testResized_upscale() {
        let image: Image<RGBA, Float> = Shape.circle(size: 64,
                                                     lineWidth: 3,
                                                     lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
        
        let resized = image.resized(width: 300, height: 300)
        let ns = resized.typeConverted(to: UInt8.self).nsImage()
        print("break here")
        _ = ns
    }
    
    func testResized_downscale() {
        let image: Image<RGBA, Float> = Shape.circle(size: 300,
                                                     lineWidth: 3,
                                                     lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
        
        let resized = image.resized(width: 64, height: 64)
        let ns = resized.typeConverted(to: UInt8.self).nsImage()
        print("break here")
        _ = ns
    }
    
    func testResizenn_upscale() {
        let image: Image<RGBA, Float> = Shape.circle(size: 64,
                                                     lineWidth: 3,
                                                     lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
        
        let resized = image.resizenn(width: 300, height: 300)
        let ns = resized.typeConverted(to: UInt8.self).nsImage()
        print("break here")
        _ = ns
    }
    
    func testResizenn_downscale() {
        let image: Image<RGBA, Float> = Shape.circle(size: 300,
                                                     lineWidth: 3,
                                                     lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
        
        let resized = image.resizenn(width: 64, height: 64)
        let ns = resized.typeConverted(to: UInt8.self).nsImage()
        print("break here")
        _ = ns
    }
    
    func testResizeaa_upscale() {
        let image: Image<RGBA, Float> = Shape.circle(size: 64,
                                                     lineWidth: 3,
                                                     lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
        
        let resized = image.resizeaa(width: 300, height: 300)
        let ns = resized.typeConverted(to: UInt8.self).nsImage()
        print("break here")
        _ = ns
    }
    
    func testResizeaa_downscale() {
        let image: Image<RGBA, Float> = Shape.circle(size: 300,
                                                     lineWidth: 3,
                                                     lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
        
        let resized = image.resizeaa(width: 64, height: 64)
        let ns = resized.typeConverted(to: UInt8.self).nsImage()
        print("break here")
        _ = ns
    }
    
    func testResizeaa_downscale_subtle() {
        let image: Image<RGBA, Float> = Shape.circle(size: 70,
                                                     lineWidth: 3,
                                                     lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
        
        let resized = image.resizeaa(width: 64, height: 64)
        let ns = resized.typeConverted(to: UInt8.self).nsImage()
        print("break here")
        _ = ns
    }
    
    func testResizebn_upscale() {
        let image: Image<RGBA, Float> = Shape.circle(size: 64,
                                                     lineWidth: 3,
                                                     lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
        
        let resized = image.resizebn(width: 300, height: 300)
        let ns = resized.typeConverted(to: UInt8.self).nsImage()
        print("break here")
        _ = ns
    }
    
    func testResizebn_downscale() {
        let image: Image<RGBA, Float> = Shape.circle(size: 300,
                                                     lineWidth: 3,
                                                     lineColor: Pixel(r: 255, g: 0, b: 0, a: 255))
        
        let resized = image.resizebn(width: 64, height: 64)
        let ns = resized.typeConverted(to: UInt8.self).nsImage()
        print("break here")
        _ = ns
    }
    
    func testResizebn_2x2() {
        let data = [255, 255, 255,
                    255, 0, 0,
                    0, 255, 0,
                    0, 0, 255].map { Float($0) }
        let image = Image(width: 2, height: 2, rgb: data)
        let resized = image.resizebn(width: 32, height: 32)
        let ns = resized.typeConverted(to: UInt8.self).nsImage()
        print("break here")
        _ = ns
    }
    #endif
}

