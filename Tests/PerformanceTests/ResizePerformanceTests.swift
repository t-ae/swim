import XCTest
import Swim

class ResizePerformanceTests: XCTestCase {
    func testResizeNN_UInt8() {
        let image = Image<Intensity, UInt8>(width: 64, height: 48, value: 0)
        
        measure {
            _ = image.resizeNN(width: 1920, height: 1080)
        }
    }
    
    func testResizeAA() {
        let image = Image<Intensity, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            _ = image.resize(width: 30, height: 30, method: .areaAverage)
        }
    }
    
    func testResizeNN() {
        let image = Image<Intensity, Double>(width: 64, height: 48, value: 0)
        
        measure {
            _ = image.resize(width: 1920, height: 1080, method: .nearestNeighbor)
        }
    }
    
    func testResizeBL() {
        let image = Image<Intensity, Double>(width: 64, height: 48, value: 0)
        
        measure {
            _ = image.resize(width: 1920, height: 1080, method: .bilinear)
        }
    }
    
    func testResizeBC() {
        let image = Image<Intensity, Double>(width: 64, height: 48, value: 0)
        
        measure {
            _ = image.resize(width: 1920, height: 1080, method: .bicubic)
        }
    }
    
    func testResizeLanczos2() {
        let image = Image<Intensity, Double>(width: 64, height: 48, value: 0)
        
        measure {
            _ = image.resize(width: 1920, height: 1080, method: .lanczos2)
        }
    }
    
    func testResizeLanczos3() {
        let image = Image<Intensity, Double>(width: 64, height: 48, value: 0)
        
        measure {
            _ = image.resize(width: 1920, height: 1080, method: .lanczos3)
        }
    }
}
