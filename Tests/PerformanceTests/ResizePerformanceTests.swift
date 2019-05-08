import XCTest
import Swim

class ResizePerformanceTests: XCTestCase {
    func testResizeNN_UInt8() {
        let data = [UInt8](repeating: 0, count: 64*48)
        let image = Image(width: 64, height: 48, intensity: data)
        
        measure {
            _ = image.resizeNN(width: 1920, height: 1080)
        }
    }
    
    func testResizeAA() {
        let data = [Float](repeating: 0, count: 1920*1080)
        let image = Image(width: 1920, height: 1080, intensity: data)
        
        measure {
            _ = image.resize(width: 30, height: 30, method: .areaAverage)
        }
    }
    
    func testResizeNN() {
        let data = [Float](repeating: 0, count: 64*48)
        let image = Image(width: 64, height: 48, intensity: data)
        
        measure {
            _ = image.resize(width: 1920, height: 1080, method: .nearestNeighbor)
        }
    }
    
    func testResizeBL() {
        let data = [Float](repeating: 0, count: 64*48)
        let image = Image(width: 64, height: 48, intensity: data)
        
        measure {
            _ = image.resize(width: 1920, height: 1080, method: .bilinear)
        }
    }
    
    func testResizeBC() {
        let data = [Float](repeating: 0, count: 64*48)
        let image = Image(width: 64, height: 48, intensity: data)
        
        measure {
            _ = image.resize(width: 1920, height: 1080, method: .bicubic)
        }
    }
    
    func testResizeLanczos2() {
        let data = [Float](repeating: 0, count: 64*48)
        let image = Image(width: 64, height: 48, intensity: data)
        
        measure {
            _ = image.resize(width: 1920, height: 1080, method: .lanczos2)
        }
    }
    
    func testResizeLanczos3() {
        let data = [Float](repeating: 0, count: 64*48)
        let image = Image(width: 64, height: 48, intensity: data)
        
        measure {
            _ = image.resize(width: 1920, height: 1080, method: .lanczos3)
        }
    }
}
