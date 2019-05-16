import XCTest
import Swim

class ArithmeticPerformanceTests: XCTestCase {
    func testAddScalarUInt8() {
        let image = Image<RGBA, UInt8>(width: 3840, height: 2160, value: 0)
        
        measure {
            _ = image + 1
        }
    }
    
    func testAddScalarFloat() {
        let image = Image<RGBA, Float>(width: 3840, height: 2160, value: 0)
        
        measure {
            _ = image + 1
        }
    }
    
    func testAddScalarDouble() {
        let image = Image<RGBA, Double>(width: 3840, height: 2160, value: 0)
        
        measure {
            _ = image + 1
        }
    }
    
    func testScalarMinusUInt8() {
        let image = Image<RGBA, UInt8>(width: 3840, height: 2160, value: 0)
        
        measure {
            _ = 255 - image
        }
    }
    func testScalarMinusFloat() {
        let image = Image<RGBA, Float>(width: 3840, height: 2160, value: 0)
        
        measure {
            _ = 1 - image
        }
    }
    
    func testScalarMinusDouble() {
        let image = Image<RGBA, Double>(width: 3840, height: 2160, value: 0)
        
        measure {
            _ = 1 - image
        }
    }
    
    func testAddImageUInt8() {
        let image1 = Image<RGBA, UInt8>(width: 3840, height: 2160, value: 0)
        let image2 = Image<RGBA, UInt8>(width: 3840, height: 2160, value: 0)
        
        measure {
            _ = image1 + image2
        }
    }
    
    func testAddImageFloat() {
        let image1 = Image<RGBA, Float>(width: 3840, height: 2160, value: 0)
        let image2 = Image<RGBA, Float>(width: 3840, height: 2160, value: 0)
        
        measure {
            _ = image1 + image2
        }
    }
    
    func testAddImageDouble() {
        let image1 = Image<RGBA, Double>(width: 3840, height: 2160, value: 0)
        let image2 = Image<RGBA, Double>(width: 3840, height: 2160, value: 0)
        
        measure {
            _ = image1 + image2
        }
    }
}
