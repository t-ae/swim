
import XCTest
import Swim

class CorrelationTests: XCTestCase {
    
    func testSSD() {
        do {
            let image1 = Image(width: 3, height: 2, intensity: [0, 1, 2, 3, 4, 5].map { Float($0) })
            let image2 = Image(width: 3, height: 2, intensity: [2, 4, 6, 2, 4, 6].map { Float($0) })
            
            XCTAssertEqual(Correlation.ssd(image1, image1), 0)
            XCTAssertEqual(Correlation.ssd(image1, image2), 31)
        }
        do {
            let image1 = Image(width: 3, height: 2, intensity: [0.0, 1, 2, 3, 4, 5])
            let image2 = Image(width: 3, height: 2, intensity: [2.0, 4, 6, 2, 4, 6])
            
            XCTAssertEqual(Correlation.ssd(image1, image1), 0)
            XCTAssertEqual(Correlation.ssd(image1, image2), 31)
        }
    }
    
    func testSAD() {
        do {
            let image1 = Image(width: 3, height: 2, intensity: [0, 1, 2, 3, 4, 5].map { Float($0) })
            let image2 = Image(width: 3, height: 2, intensity: [2, 4, 6, 2, 4, 6].map { Float($0) })
            
            XCTAssertEqual(Correlation.sad(image1, image1), 0)
            XCTAssertEqual(Correlation.sad(image1, image2), 11)
        }
        do {
            let image1 = Image(width: 3, height: 2, intensity: [0.0, 1, 2, 3, 4, 5])
            let image2 = Image(width: 3, height: 2, intensity: [2.0, 4, 6, 2, 4, 6])
            
            XCTAssertEqual(Correlation.sad(image1, image1), 0)
            XCTAssertEqual(Correlation.sad(image1, image2), 11)
        }
    }
    
    func testNCC() {
        do {
            let image1 = Image(width: 3, height: 2, intensity: [0, 1, 2, 3, 4, 5].map { Float($0) })
            let image2 = Image(width: 3, height: 2, intensity: [2, 4, 6, 2, 4, 6].map { Float($0) })
            
            let ip = zip(image1.data, image2.data).map { $0*$1 }.reduce(0, +)
            let l1 = zip(image1.data, image1.data).map { $0*$1 }.reduce(0, +)
            let l2 = zip(image2.data, image2.data).map { $0*$1 }.reduce(0, +)
            
            XCTAssertEqual(Correlation.ncc(image1, image1), 1)
            XCTAssertEqual(Correlation.ncc(image1, image2), ip / sqrt(l1 * l2))
        }
        do {
            let image1 = Image(width: 3, height: 2, intensity: [0.0, 1, 2, 3, 4, 5])
            let image2 = Image(width: 3, height: 2, intensity: [2.0, 4, 6, 2, 4, 6])
            
            let ip = zip(image1.data, image2.data).map { $0*$1 }.reduce(0, +)
            let l1 = zip(image1.data, image1.data).map { $0*$1 }.reduce(0, +)
            let l2 = zip(image2.data, image2.data).map { $0*$1 }.reduce(0, +)
            
            XCTAssertEqual(Correlation.ncc(image1, image1), 1)
            XCTAssertEqual(Correlation.ncc(image1, image2), ip / sqrt(l1 * l2))
        }
    }
    
    func testZNCC() {
        do {
            let image1 = Image(width: 3, height: 2, intensity: [0, 1, 2, 3, 4, 5].map { Float($0) })
            
            XCTAssertEqual(Correlation.zncc(image1, image1), 1)
            
            let i1 = Image(width: 3, height: 1, intensity: [0, 1, 0].map { Float($0) })
            let i2 = Image(width: 3, height: 1, intensity: [1, 0, 1].map { Float($0) })
            
            XCTAssertEqual(Correlation.zncc(i1, i2), -1)
        }
        do {
            let image1 = Image(width: 3, height: 2, intensity: [0.0, 1, 2, 3, 4, 5])
            
            XCTAssertEqual(Correlation.zncc(image1, image1), 1)
            
            let i1 = Image(width: 3, height: 1, intensity: [0.0, 1, 0])
            let i2 = Image(width: 3, height: 1, intensity: [1.0, 0, 1])
            
            XCTAssertEqual(Correlation.zncc(i1, i2), -1)
        }
    }
    
    func testScale() {
        let image1 = Image(width: 3, height: 2, intensity: [0.0, 100, 2, 30, 104, 255])
        let image2 = Image(width: 3, height: 2, intensity: [255.0, 0, 10, 102, 30, 4])
        
        XCTAssertEqual(Correlation.ncc(image1, image2),
                       Correlation.ncc(image1/255, image2/255),
                       accuracy: 1e-3)
        XCTAssertEqual(Correlation.zncc(image1, image2),
                       Correlation.zncc(image1/255, image2/255),
                       accuracy: 1e-3)
    }
}
