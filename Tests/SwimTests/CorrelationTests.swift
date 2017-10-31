
import XCTest
import Swim

class CorrelationTests: XCTestCase {
    
    func testSSD() {
        let image1 = Image<Intensity, Float>(width: 3, height: 2, data: [0, 1, 2, 3, 4, 5])
        let image2 = Image<Intensity, Float>(width: 3, height: 2, data: [2, 4, 6, 2, 4, 6])
        
        XCTAssertEqual(Correlation.ssd(image1, image1), 0)
        XCTAssertEqual(Correlation.ssd(image1, image2), 31)
    }
    
    func testSAD() {
        let image1 = Image<Intensity, Float>(width: 3, height: 2, data: [0, 1, 2, 3, 4, 5])
        let image2 = Image<Intensity, Float>(width: 3, height: 2, data: [2, 4, 6, 2, 4, 6])
        
        XCTAssertEqual(Correlation.sad(image1, image1), 0)
        XCTAssertEqual(Correlation.sad(image1, image2), 11)
    }
    
    func testNCC() {
        let image1 = Image<Intensity, Float>(width: 3, height: 2, data: [0, 1, 2, 3, 4, 5])
        let image2 = Image<Intensity, Float>(width: 3, height: 2, data: [2, 4, 6, 2, 4, 6])
        
        let ip = zip(image1.data, image2.data).map { $0*$1 }.reduce(0, +)
        let l1 = zip(image1.data, image1.data).map { $0*$1 }.reduce(0, +)
        let l2 = zip(image2.data, image2.data).map { $0*$1 }.reduce(0, +)
        
        XCTAssertEqual(Correlation.ncc(image1, image1), 1)
        XCTAssertEqual(Correlation.ncc(image1, image2), ip / sqrt(l1 * l2))
    }
    
    func testZNCC() {
        let image1 = Image<Intensity, Float>(width: 3, height: 2, data: [0, 1, 2, 3, 4, 5])
        
        XCTAssertEqual(Correlation.zncc(image1, image1), 1)
        
        let i1 = Image<Intensity, Float>(width: 3, height: 1, data: [0, 1, 0])
        let i2 = Image<Intensity, Float>(width: 3, height: 1, data: [1, 0, 1])
        
        XCTAssertEqual(Correlation.zncc(i1, i2), -1)
    }
}
