import XCTest
import Swim

class FilterTests: XCTestCase {
    
    func testMaximumFilter() {
        do {
            let image = Image(width: 3, height: 3, gray: (0..<9).map { Int($0) })
            
            let filtered = image.rankFilter(.maximum, kernelSize: 3)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [4, 5, 5, 7, 8, 8, 7, 8, 8]))
        }
        do {
            let image = Image(width: 3, height: 3, gray: (0..<9).reversed().map(Float.init))
            
            let filtered = image.rankFilter(.maximum, kernelSize: 3)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [8, 8, 7, 8, 8, 7, 5, 5, 4]))
        }
    }
    
    func testMinimumFilter() {
        do {
            let image = Image(width: 3, height: 3, gray: (0..<9).map { Int($0) })
            
            let filtered = image.rankFilter(.minimum, kernelSize: 3)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [0, 0, 1, 0, 0, 1, 3, 3, 4]))
        }
        do {
            let image = Image(width: 3, height: 3, gray: (0..<9).reversed().map(Float.init))
            
            let filtered = image.rankFilter(.minimum, kernelSize: 3)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [4, 3, 3, 1, 0, 0, 1, 0, 0]))
        }
    }
    
    func testMedianFilter() {
        do {
            let image = Image(width: 3, height: 3, gray: (0..<9).map { Int($0) })
            
            let filtered = image.rankFilter(.median, kernelSize: 3)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [1, 2, 2, 3, 4, 4, 4, 5, 5]))
        }
        do {
            let image = Image(width: 3, height: 3, gray: (0..<9).reversed().map(Float.init))
            
            let filtered = image.rankFilter(.median, kernelSize: 3)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [5, 5, 4, 4, 4, 3, 2, 2, 1]))
        }
    }
    
    static let allTests = [
        ("testMaximumFilter", testMaximumFilter),
        ("testMinimumFilter", testMinimumFilter),
        ("testMedianFilter", testMedianFilter),
    ]
}
