import XCTest
import Swim

class CorrelationTests: XCTestCase {
    
    func testSSD() {
        do {
            let image1 = Image(width: 3, height: 2, gray: [0, 1, 2, 3, 4, 5] as [Float])
            let image2 = Image(width: 3, height: 2, gray: [2, 4, 6, 2, 4, 6] as [Float])
            
            XCTAssertEqual(Correlation.ssd(image1, image1), 0)
            XCTAssertEqual(Correlation.ssd(image1, image2), 31)
        }
        do {
            let image1 = Image(width: 3, height: 2, gray: [0.0, 1, 2, 3, 4, 5])
            let image2 = Image(width: 3, height: 2, gray: [2.0, 4, 6, 2, 4, 6])
            
            XCTAssertEqual(Correlation.ssd(image1, image1), 0)
            XCTAssertEqual(Correlation.ssd(image1, image2), 31)
        }
    }
    
    func testSAD() {
        do {
            let image1 = Image(width: 3, height: 2, gray: [0, 1, 2, 3, 4, 5] as [Float])
            let image2 = Image(width: 3, height: 2, gray: [2, 4, 6, 2, 4, 6] as [Float])
            
            XCTAssertEqual(Correlation.sad(image1, image1), 0)
            XCTAssertEqual(Correlation.sad(image1, image2), 11)
        }
        do {
            let image1 = Image(width: 3, height: 2, gray: [0.0, 1, 2, 3, 4, 5])
            let image2 = Image(width: 3, height: 2, gray: [2.0, 4, 6, 2, 4, 6])
            
            XCTAssertEqual(Correlation.sad(image1, image1), 0)
            XCTAssertEqual(Correlation.sad(image1, image2), 11)
        }
    }
    
    func testNCC() {
        do {
            let data1 = [0, 1, 2, 3, 4, 5] as [Float]
            let data2 = [2, 4, 6, 2, 4, 6] as [Float]
            let image1 = Image(width: 3, height: 2, gray: data1)
            let image2 = Image(width: 3, height: 2, gray: data2)
            
            let ip = zip(data1, data2).map { $0*$1 }.reduce(0, +)
            let l1 = zip(data1, data1).map { $0*$1 }.reduce(0, +)
            let l2 = zip(data2, data2).map { $0*$1 }.reduce(0, +)
            
            XCTAssertEqual(Correlation.ncc(image1, image1), 1)
            XCTAssertEqual(Correlation.ncc(image1, image2), ip / sqrt(l1 * l2))
        }
        do {
            let data1 = [0.0, 1, 2, 3, 4, 5]
            let data2 = [2.0, 4, 6, 2, 4, 6]
            let image1 = Image(width: 3, height: 2, gray: data1)
            let image2 = Image(width: 3, height: 2, gray: data2)
            
            let ip = zip(data1, data2).map { $0*$1 }.reduce(0, +)
            let l1 = zip(data1, data1).map { $0*$1 }.reduce(0, +)
            let l2 = zip(data2, data2).map { $0*$1 }.reduce(0, +)
            
            XCTAssertEqual(Correlation.ncc(image1, image1), 1)
            XCTAssertEqual(Correlation.ncc(image1, image2), ip / sqrt(l1 * l2))
        }
    }
    
    func testZNCC() {
        do {
            let image1 = Image(width: 3, height: 2, gray: [0, 1, 2, 3, 4, 5] as [Float])
            
            XCTAssertEqual(Correlation.zncc(image1, image1), 1)
            
            let i1 = Image(width: 3, height: 1, gray: [0, 1, 0] as [Float])
            let i2 = Image(width: 3, height: 1, gray: [1, 0, 1] as [Float])
            
            XCTAssertEqual(Correlation.zncc(i1, i2), -1)
        }
        do {
            let image1 = Image(width: 3, height: 2, gray: [0.0, 1, 2, 3, 4, 5])
            
            XCTAssertEqual(Correlation.zncc(image1, image1), 1)
            
            let i1 = Image(width: 3, height: 1, gray: [0.0, 1, 0])
            let i2 = Image(width: 3, height: 1, gray: [1.0, 0, 1])
            
            XCTAssertEqual(Correlation.zncc(i1, i2), -1)
        }
    }
    
    func testScale() {
        let image1 = Image(width: 3, height: 2, gray: [0.0, 100, 2, 30, 104, 255])
        let image2 = Image(width: 3, height: 2, gray: [255.0, 0, 10, 102, 30, 4])
        
        XCTAssertEqual(Correlation.ncc(image1, image2),
                       Correlation.ncc(image1/255, image2/255),
                       accuracy: 1e-3)
        XCTAssertEqual(Correlation.zncc(image1, image2),
                       Correlation.zncc(image1/255, image2/255),
                       accuracy: 1e-3)
    }
    
    static let allTests = [
        ("testSSD", testSSD),
        ("testSAD", testSAD),
        ("testNCC", testNCC),
        ("testZNCC", testZNCC),
        ("testScale", testScale)
    ]
}
