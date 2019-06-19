import XCTest
import Swim

class TransformationPerformanceTests: XCTestCase {
    func testFlipLR() {
        let image = Image<RGBA, Double>(width: 3840, height: 2160, value: 0)
        
        measure {
            _ = image.flipLR()
        }
    }
    
    func testFlipUD() {
        let image = Image<RGBA, Double>(width: 3840, height: 2160, value: 0)
        
        measure {
            _ = image.flipUD()
        }
    }
    
    func testRot90() {
        let image = Image<RGBA, Int>(width: 3840, height: 2160, value: 1)
        
        measure {
            _ = image.rot90()
        }
    }
    
    func testRot180() {
        let image = Image<RGBA, Int>(width: 3840, height: 2160, value: 1)
        
        measure {
            _ = image.rot180()
        }
    }
    
    func testTranspose() {
        let image = Image<RGBA, Int>(width: 3840, height: 2160, value: 1)
        
        measure {
            _ = image.transposed()
        }
    }
    
    func testWarp() {
        let image = Image<RGBA, Double>(width: 3840, height: 2160, value: 0)
        
        let affine = AffineTransformation(scale: (2, 1), translation: (640, 0))
        
        measure {
            _ = try? image.warp(transformation: affine)
        }
    }
    
    func testPadding() {
        let image = Image<RGBA, Double>(width: 3840, height: 2160, value: 0)
        
        measure {
            _ = image.withPadding(3, edgeMode: .edge)
        }
    }
    
    func testShifted() {
        let image = Image<RGBA, Double>(width: 3840, height: 2160, value: 0)
        
        measure {
            _ = image.shifted(x: 1000, y: -1000, edgeMode: .edge)
        }
    }
}
