import XCTest
import Swim

class BayerTests: XCTestCase {
    
    func testBayered() {
        let image = Image(width: 4, height: 4, rgb: (0..<48).map { UInt8($0) })
        
        do {
            let lumi: Image<Intensity, UInt8> = image.bayered(pattern: .bggr)
            XCTAssertEqual(lumi, Image(width: 4,
                                       height: 4,
                                       data: [2, 4, 8, 10,
                                              13, 15, 19, 21,
                                              26, 28, 32, 34,
                                              37, 39, 43, 45]))
        }
        do {
            let lumi: Image<Intensity, UInt8> = image.bayered(pattern: .gbrg)
            XCTAssertEqual(lumi, Image(width: 4,
                                       height: 4,
                                       data: [1, 5, 7, 11,
                                              12, 16, 18, 22,
                                              25, 29, 31, 35,
                                              36, 40, 42, 46]))
        }
        do {
            let lumi: Image<Intensity, UInt8> = image.bayered(pattern: .grbg)
            XCTAssertEqual(lumi, Image(width: 4,
                                       height: 4,
                                       data: [1, 3, 7, 9,
                                              14, 16, 20, 22,
                                              25, 27, 31, 33,
                                              38, 40, 44, 46]))
        }
        do {
            let lumi: Image<Intensity, UInt8> = image.bayered(pattern: .rggb)
            XCTAssertEqual(lumi, Image(width: 4,
                                       height: 4,
                                       data: [0, 4, 6, 10,
                                              13, 17, 19, 23,
                                              24, 28, 30, 34,
                                              37, 41, 43, 47]))
        }
    }
    
    func testDebayered() {
        let image = Image(width: 4, height: 4, intensity: (0..<16).map { $0 })
        do {
            let rgb: Image<RGB, Int> = image.debayered(pattern: .bggr)
            XCTAssertEqual(rgb, Image(width: 4,
                                      height: 4,
                                      data: [5, 2, 0,  5, 1, 1,  6, 3, 2,  7, 3, 2,
                                             5, 4, 4,  5, 5, 5,  6, 6, 6,  7, 6, 6,
                                             9, 8, 8,  9, 9, 9,  10, 10, 10,  11, 11, 10,
                                             13, 12, 8,  13, 11, 9,  14, 14, 10, 15, 12, 10]))
        }
    }
}
