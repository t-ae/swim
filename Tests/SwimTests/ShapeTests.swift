
import XCTest
import Swim

class ShapeTests: XCTestCase {
    
    #if !SWIFT_PACKAGE && os(macOS)
    
    func testCircle() {
        let x = Shape.circle(size: 512,
                             lineWidth: 5,
                             lineColor: Pixel(r: 0.0, g: 255.0, b: 255.0, a: 255.0),
                             fillColor: Pixel(r: 255.0, g: 0.0, b: 0.0, a: 128.0))
        
        let ns = x.typeConverted(to: UInt8.self).nsImage()
        print("break here")
        _ = ns
    }
    
    func testRect() {
        let x = Shape.rect(width: 128,
                           height: 64,
                           lineWidth: 5,
                           lineColor: Pixel(r: 0.0, g: 255.0, b: 255.0, a: 255.0),
                           fillColor: Pixel(r: 255.0, g: 0.0, b: 0.0, a: 128.0))
        
        let ns = x.typeConverted(to: UInt8.self).nsImage()
        print("break here")
        _ = ns
    }
    
    #endif
    
}
