import XCTest
import Swim

class DataTypeConversionTests: XCTestCase {
    func testCast() {
        do {
            let data = (0..<40).map { UInt8($0) }
            let image = Image(width: 2, height: 5, rgba: data)
            
            let float = image.cast(to: Float.self)
            XCTAssertEqual(float.withUnsafeBufferPointer { [Float]($0) },
                           data.map { Float($0) })
            
            let double = image.cast(to: Double.self)
            XCTAssertEqual(double, Image(width: 2, height: 5, data: data.map { Double($0) }))
        }
        do {
            let data = (0..<40).map { Float($0) }
            let image = Image(width: 2, height: 5, rgba: data)
            
            let uint8 = image.cast(to: UInt8.self)
            XCTAssertEqual(uint8, Image(width: 2, height: 5, data: data.map { UInt8($0) }))
            
            let double = image.cast(to: Double.self)
            XCTAssertEqual(double, Image(width: 2, height: 5, data: data.map { Double($0) }))
        }
        do {
            let data = (0..<40).map { Double($0) }
            let image = Image(width: 2, height: 5, rgba: data)
            
            let uint8 = image.cast(to: UInt8.self)
            XCTAssertEqual(uint8, Image(width: 2, height: 5, data: data.map { UInt8($0) }))
            
            let float = image.cast(to: Float.self)
            XCTAssertEqual(float, Image(width: 2, height: 5, data: data.map { Float($0) }))
        }
    }
    
    func testRounding() {
        let image = Image<Intensity, Double>(width: 4, height: 1, data: [-1, -1.3, -1.6, -1.9])
        
        XCTAssertEqual(image.cast(to: Int.self), Image.full(value: -1, like: image))
    }
}
