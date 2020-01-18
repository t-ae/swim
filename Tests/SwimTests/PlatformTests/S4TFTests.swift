import XCTest
import Swim

class S4TFTests: XCTestCase {

}

#if canImport(TensorFlow)
import TensorFlow
extension S4TFTests {
    func testToTensor() {
        do {
            let data: [UInt8] = [0, 1, 2, 3, 4, 5]
            let image = Image<Gray, UInt8>(width: 2, height: 3, data: data)
            let tensor = Tensor(image: image)
            
            XCTAssertEqual(tensor.shape, [3, 2])
            XCTAssertEqual(tensor.scalars, data)
        }
        
        do {
            let data: [Float] = (0..<24).map { Float($0) }
            let image = Image<RGB, Float>(width: 2, height: 4, data: data)
            let tensor = Tensor(image: image)
            
            XCTAssertEqual(tensor.shape, [4, 2, 3])
            XCTAssertEqual(tensor.scalars, data)
        }
    }
    
    func testFromTensor() {
        do {
            let data: [UInt8] = [0, 1, 2, 3, 4, 5]
            let tensor = Tensor(shape: [3, 2], scalars: data)
            let image = Image<Gray, UInt8>(tensor: tensor)
            
            XCTAssertEqual(image.width, 2)
            XCTAssertEqual(image.height, 3)
            XCTAssertEqual(image.getData(), data)
        }
        
        do {
            let data: [Float] = (0..<24).map { Float($0) }
            let tensor = Tensor(shape: [4, 2, 3], scalars: data)
            let image = Image<RGB, Float>(tensor: tensor)
            
            XCTAssertEqual(image.width, 2)
            XCTAssertEqual(image.height, 4)
            XCTAssertEqual(image.getData(), data)
        }
    }
}
#endif
