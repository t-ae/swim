
import XCTest
import Swim

class DataTypeConversionTests: XCTestCase {
    
    func testCast() {
        do {
            let data = (0..<40).map { UInt8($0) }
            let image = Image<RGBA, UInt8>(width: 2, height: 5, data: data)
            
            let float: Image<RGBA, Float> = image.cast()
            XCTAssertEqual(float.data, data.map { Float($0) })
            
            let double: Image<RGBA, Double> = image.cast()
            XCTAssertEqual(double.data, data.map { Double($0) })
        }
        do {
            let data = (0..<40).map { Float($0) }
            let image = Image<RGBA, Float>(width: 2, height: 5, data: data)
            
            let uint8: Image<RGBA, UInt8> = image.cast()
            XCTAssertEqual(uint8.data, data.map { UInt8($0) })
            
            let double: Image<RGBA, Double> = image.cast()
            XCTAssertEqual(double.data, data.map { Double($0) })
        }
        do {
            let data = (0..<40).map { Double($0) }
            let image = Image<RGBA, Double>(width: 2, height: 5, data: data)
            
            let uint8: Image<RGBA, UInt8> = image.cast()
            XCTAssertEqual(uint8.data, data.map { UInt8($0) })
            
            let float: Image<RGBA, Float> = image.cast()
            XCTAssertEqual(float.data, data.map { Float($0) })
        }
    }
    
}
