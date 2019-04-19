import XCTest
import Swim

class DataTypeConversionTests: XCTestCase {
    func testCast() {
        do {
            let data = (0..<40).map { UInt8($0) }
            let image = Image(width: 2, height: 5, rgba: data)
            
            let float = image.dataTypeConverter.cast(to: Float.self)
            XCTAssertEqual(float.data, data.map { Float($0) })
            
            let double: Image<RGBA, Double> = image.dataTypeConverter.cast()
            XCTAssertEqual(double, Image(width: 2, height: 5, data: data.map { Double($0) }))
        }
        do {
            let data = (0..<40).map { Float($0) }
            let image = Image(width: 2, height: 5, rgba: data)
            
            let uint8 = image.dataTypeConverter.cast(to: UInt8.self)
            XCTAssertEqual(uint8, Image(width: 2, height: 5, data: data.map { UInt8($0) }))
            
            let double: Image<RGBA, Double> = image.dataTypeConverter.cast()
            XCTAssertEqual(double, Image(width: 2, height: 5, data: data.map { Double($0) }))
        }
        do {
            let data = (0..<40).map { Double($0) }
            let image = Image(width: 2, height: 5, rgba: data)
            
            let uint8 = image.dataTypeConverter.cast(to: UInt8.self)
            XCTAssertEqual(uint8, Image(width: 2, height: 5, data: data.map { UInt8($0) }))
            
            let float: Image<RGBA, Float> = image.dataTypeConverter.cast()
            XCTAssertEqual(float, Image(width: 2, height: 5, data: data.map { Float($0) }))
        }
    }
}
