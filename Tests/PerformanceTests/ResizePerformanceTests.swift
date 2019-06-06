import XCTest
import Swim

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
        return .createWithPixelRef(width: width, height: height) { ref in
            let x = Double(self.width) * Double(ref.x) / Double(width) - 0.5
            let y = Double(self.height) * Double(ref.y) / Double(height) - 0.5
            
            let xmin = Foundation.floor(x)
            let ymin = Foundation.floor(y)
            let x0 = Int(xmin)
            let y0 = Int(ymin)
            let x1 = x0+1
            let y1 = y0+1
            
            let wx0 = T(xmin + 1 - x)
            let wx1 = T(x - xmin)
            let wy0 = T(ymin + 1 - y)
            let wy1 = T(y - ymin)
            
            ref.fill(value: 0)
            
            do {
                let x = min(max(x0, 0), self.width-1)
                let y = min(max(y0, 0), self.height-1)
                
                let start = self.dataIndex(x: x, y: y)
                for i in 0..<P.channels {
                    ref[i] += self[data: start+i] * wx0 * wy0
                }
            }
            do {
                let x = min(max(x1, 0), self.width-1)
                let y = min(max(y0, 0), self.height-1)
                
                let start = self.dataIndex(x: x, y: y)
                for i in 0..<P.channels {
                    ref[i] += self[data: start+i] * wx1 * wy0
                }
            }
            do {
                let x = min(max(x0, 0), self.width-1)
                let y = min(max(y1, 0), self.height-1)
                
                let start = self.dataIndex(x: x, y: y)
                for i in 0..<P.channels {
                    ref[i] += self[data: start+i] * wx0 * wy1
                }
            }
            do {
                let x = min(max(x1, 0), self.width-1)
                let y = min(max(y1, 0), self.height-1)
                
                let start = self.dataIndex(x: x, y: y)
                for i in 0..<P.channels {
                    ref[i] += self[data: start+i] * wx1 * wy1
                }
            }
        }
    }
}
