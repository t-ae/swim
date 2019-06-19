import XCTest
import Swim

class CorrelationPerformanceTests: XCTestCase {

    func testSSD() {
        let image1 = Image<Gray, Double>(width: 1920, height: 1080, value: 0)
        let image2 = Image<Gray, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            for _ in 0..<100 {
                let d = ImageCompare.ssd(image1, image2)
                XCTAssertEqual(d, 0)
            }
        }
    }
    
    func testMaskedSSD() {
        let image1 = Image<Gray, Double>(width: 1920, height: 1080, value: 0)
        let image2 = Image<Gray, Double>(width: 1920, height: 1080, value: 0)
        let mask = Image<Gray, Bool>(width: 1920, height: 1080, value: true)
        
        measure {
            for _ in 0..<100 {
                let d = ImageCompare.ssd(image1, image2, mask: mask)
                XCTAssertEqual(d, 0)
            }
        }
    }

    func testSAD() {
        let image1 = Image<Gray, Double>(width: 1920, height: 1080, value: 0)
        let image2 = Image<Gray, Double>(width: 1920, height: 1080, value: 0)
        
        measure {
            for _ in 0..<100 {
                let d = ImageCompare.sad(image1, image2)
                XCTAssertEqual(d, 0)
            }
        }
    }
    
    func testMaskedSAD() {
        let image1 = Image<Gray, Double>(width: 1920, height: 1080, value: 0)
        let image2 = Image<Gray, Double>(width: 1920, height: 1080, value: 0)
        let mask = Image<Gray, Bool>(width: 1920, height: 1080, value: true)
        
        measure {
            for _ in 0..<100 {
                let d = ImageCompare.sad(image1, image2, mask: mask)
                XCTAssertEqual(d, 0)
            }
        }
    }
    
    func testNCC() {
        let image1 = Image<Gray, Double>(width: 1920, height: 1080, value: 0.01)
        let image2 = Image<Gray, Double>(width: 1920, height: 1080, value: 0.01)
        
        measure {
            for _ in 0..<100 {
                let d = ImageCompare.ncc(image1, image2)
                XCTAssertEqual(d, 1, accuracy: 1e-3)
            }
        }
    }
    
    func testMaskedNCC() {
        let image1 = Image<Gray, Double>(width: 1920, height: 1080, value: 0.01)
        let image2 = Image<Gray, Double>(width: 1920, height: 1080, value: 0.01)
        let mask = Image<Gray, Bool>(width: 1920, height: 1080, value: true)
        
        measure {
            for _ in 0..<100 {
                let d = ImageCompare.ncc(image1, image2, mask: mask)
                XCTAssertEqual(d, 1, accuracy: 1e-3)
            }
        }
    }
    
    func testZNCC() {
        let image1 = Image<Gray, Double>(width: 1920, height: 1080, value: 0.01)
        let image2 = Image<Gray, Double>(width: 1920, height: 1080, value: 0.02)
        
        measure {
            for _ in 0..<100 {
                let d = ImageCompare.zncc(image1, image2)
                XCTAssertEqual(d, 1, accuracy: 1e-3)
            }
        }
    }
    
    func testMaskedZNCC() {
        let image1 = Image<Gray, Double>(width: 1920, height: 1080, value: 0.01)
        let image2 = Image<Gray, Double>(width: 1920, height: 1080, value: 0.02)
        let mask = Image<Gray, Bool>(width: 1920, height: 1080, value: true)
        
        measure {
            for _ in 0..<100 {
                let d = ImageCompare.zncc(image1, image2, mask: mask)
                XCTAssertEqual(d, 1, accuracy: 1e-3)
            }
        }
    }
}
