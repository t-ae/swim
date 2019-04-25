import XCTest
import Swim

class ArithmeticPerformanceTests: XCTestCase {
    func testAddScalarUInt8() {
        let data = [UInt8](repeating: 0, count: 3840*2160*4)
        let image = Image(width: 3840, height: 2160, rgba: data)
        
        measure {
            _ = image + 1
        }
    }
    
    func testAddScalarFloat() {
        let data = [Float](repeating: 0, count: 3840*2160*4)
        let image = Image(width: 3840, height: 2160, rgba: data)
        
        measure {
            _ = image + 1
        }
    }
    
    func testAddScalarDouble() {
        let data = [Double](repeating: 0, count: 3840*2160*4)
        let image = Image(width: 3840, height: 2160, rgba: data)
        
        measure {
            _ = image + 1
        }
    }
    
    func testScalarMinusUInt8() {
        let data = [UInt8](repeating: 0, count: 3840*2160*4)
        let image = Image(width: 3840, height: 2160, rgba: data)
        
        measure {
            _ = 255 - image
        }
    }
    func testScalarMinusFloat() {
        let data = [Float](repeating: 0, count: 3840*2160*4)
        let image = Image(width: 3840, height: 2160, rgba: data)
        
        measure {
            _ = 1 - image
        }
    }
    
    func testScalarMinusDouble() {
        let data = [Double](repeating: 0, count: 3840*2160*4)
        let image = Image(width: 3840, height: 2160, rgba: data)
        
        measure {
            _ = 1 - image
        }
    }
    
    func testAddImageUInt8() {
        let data = [UInt8](repeating: 0, count: 3840*2160*4)
        let image1 = Image(width: 3840, height: 2160, rgba: data)
        let image2 = Image(width: 3840, height: 2160, rgba: data)
        
        measure {
            _ = image1 + image2
        }
    }
    
    func testAddImageFloat() {
        let data = [Float](repeating: 0, count: 3840*2160*4)
        let image1 = Image(width: 3840, height: 2160, rgba: data)
        let image2 = Image(width: 3840, height: 2160, rgba: data)
        
        measure {
            _ = image1 + image2
        }
    }
    
    func testAddImageDouble() {
        let data = [Double](repeating: 0, count: 3840*2160*4)
        let image1 = Image(width: 3840, height: 2160, rgba: data)
        let image2 = Image(width: 3840, height: 2160, rgba: data)
        
        measure {
            _ = image1 + image2
        }
    }
}
