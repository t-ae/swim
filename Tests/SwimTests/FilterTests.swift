import XCTest
import Swim

class FilterTests: XCTestCase {
    
    func testMaximumFilter() {
        do {
            let image = Image(width: 3, height: 3, intensity: (0..<9).map { Int($0) })
            
            let filtered = image.maximumFilter(kernelSize: 3)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [4, 5, 5, 7, 8, 8, 7, 8, 8]))
        }
        do {
            let image = Image(width: 3, height: 3, intensity: (0..<9).map(Float.init))
            
            let filtered = image.maximumFilter(kernelSize: 3)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [4, 5, 5, 7, 8, 8, 7, 8, 8]))
        }
    }
    
    func testMinimumFilter() {
        do {
            let image = Image(width: 3, height: 3, intensity: (0..<9).map { Int($0) })
            
            let filtered = image.minimumFilter(kernelSize: 3)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [0, 0, 1, 0, 0, 1, 3, 3, 4]))
        }
        do {
            let image = Image(width: 3, height: 3, intensity: (0..<9).map(Float.init))
            
            let filtered = image.minimumFilter(kernelSize: 3)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [0, 0, 1, 0, 0, 1, 3, 3, 4]))
        }
    }
    
    func testMedianFilter() {
        do {
            let image = Image(width: 3, height: 3, intensity: (0..<9).map { Int($0) })
            
            let filtered = image.medianFilter(kernelSize: 3)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [1, 2, 2, 3, 4, 4, 4, 5, 5]))
        }
        do {
            let image = Image(width: 3, height: 3, intensity: (0..<9).map(Float.init))
            
            let filtered = image.medianFilter(kernelSize: 3)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [1, 2, 2, 3, 4, 4, 4, 5, 5]))
        }
    }
}
