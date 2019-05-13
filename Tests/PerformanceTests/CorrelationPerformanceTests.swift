import XCTest
import Swim

class CorrelationPerformanceTests: XCTestCase {

    func testSSD() {
        let data = [Float](repeating: 0, count: 1920*1080)
        let image1 = Image(width: 1920, height: 1080, intensity: data)
        let image2 = Image(width: 1920, height: 1080, intensity: data)
        
        measure {
            let d = Correlation.ssd(image1, image2)
            XCTAssertEqual(d, 0)
        }
    }

    func testSAD() {
        let data = [Float](repeating: 0, count: 1920*1080)
        let image1 = Image(width: 1920, height: 1080, intensity: data)
        let image2 = Image(width: 1920, height: 1080, intensity: data)
        
        measure {
            let d = Correlation.sad(image1, image2)
            XCTAssertEqual(d, 0)
        }
    }
    
    func testNCC() {
        let data = [Float](repeating: 0.3, count: 1920*1080)
        let image1 = Image(width: 1920, height: 1080, intensity: data)
        let image2 = Image(width: 1920, height: 1080, intensity: data)
        
        measure {
            let d = Correlation.ncc(image1, image2)
            XCTAssertEqual(d, 1)
        }
    }
    
    func testZNCC() {
        let data = (0..<1920*1080).map { (sin(Float($0)) + 1) / 2 }
        let image1 = Image(width: 1920, height: 1080, intensity: data)
        let image2 = Image(width: 1920, height: 1080, intensity: data.map { $0 + 0.01 })
        
        measure {
            let d = Correlation.zncc(image1, image2)
            XCTAssertEqual(d, 1, accuracy: 1e-3)
        }
    }
}
