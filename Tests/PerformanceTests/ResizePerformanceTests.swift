import XCTest
@testable import Swim

class ResizePerformanceTests: XCTestCase {
    func testResizeNN_UInt8() {
        let image = Image<RGBA, UInt8>(width: 64, height: 48, value: 0)
        
        measure {
            _ = image.resize(width: 1920, height: 1080)
        }
    }
    
    func testResizeAA() {
        let image = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            _ = image.resize(width: 30, height: 30, method: .areaAverage)
        }
    }
    
    func testResizeAA_Upscale() {
        let image = Image<RGBA, Double>(width: 64, height: 48, value: 0)
        
        measure {
            _ = image.resize(width: 1920, height: 1080, method: .areaAverage)
        }
    }
    
    func testResizeNN() {
        let image = Image<RGBA, Double>(width: 64, height: 48, value: 0)
        
        measure {
            _ = image.resize(width: 1920, height: 1080, method: .nearestNeighbor)
        }
    }
    
    func testResizeBL() {
        let image = Image<RGBA, Double>(width: 64, height: 48, value: 0)
        
        measure {
            _ = image.resize(width: 1920, height: 1080, method: .bilinear)
        }
    }
    
    func testResizeBLPlain() {
        let image = Image<RGBA, Double>(width: 64, height: 48, value: 0)
        
        measure {
            _ = image.resizeBL(width: 1920, height: 1080)
        }
    }
    
    func testResizeBC() {
        let image = Image<RGBA, Double>(width: 64, height: 48, value: 0)
        
        measure {
            _ = image.resize(width: 1920, height: 1080, method: .bicubic)
        }
    }
    
    func testResizeLanczos2() {
        let image = Image<RGBA, Double>(width: 64, height: 48, value: 0)
        
        measure {
            _ = image.resize(width: 1920, height: 1080, method: .lanczos2)
        }
    }
    
    func testResizeLanczos3() {
        let image = Image<RGBA, Double>(width: 64, height: 48, value: 0)
        
        measure {
            _ = image.resize(width: 1920, height: 1080, method: .lanczos3)
        }
    }
}

extension Image where T: BinaryFloatingPoint {
    /// For checking how much `resize` is slower than plain implementation.
    @inlinable
    public func resizeBL(width: Int, height: Int) -> Image {
        let xc = Double(self.width) / Double(width-1)
        let yc = Double(self.height) / Double(height-1)
        return .createWithUnsafePixelRef(width: width, height: height) { ref in
            let x = xc * Double(ref.x)  - 0.5
            let y = yc * Double(ref.y) - 0.5
            
            let xmin = Foundation.floor(x)
            let ymin = Foundation.floor(y)
            
            let wx0 = T(xmin + 1 - x)
            let wx1 = T(x - xmin)
            let wy0 = T(ymin + 1 - y)
            let wy1 = T(y - ymin)
            
            let xp = Int(xmin)
            let yp = Int(ymin)
            let x0 = min(max(xp+0, 0), self.width-1)
            let x1 = min(max(xp+1, 0), self.width-1)
            let y0 = min(max(yp+0, 0), self.height-1)
            let y1 = min(max(yp+1, 0), self.height-1)
            
            ref.setColor(x: x0, y: y0, in: self, with: wx0*wy0)
            ref.addColor(x: x1, y: y0, in: self, with: wx1*wy0)
            ref.addColor(x: x0, y: y1, in: self, with: wx0*wy1)
            ref.addColor(x: x1, y: y1, in: self, with: wx1*wy1)
        }
    }
}
