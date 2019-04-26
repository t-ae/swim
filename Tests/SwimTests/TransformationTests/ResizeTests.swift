import XCTest
import Swim

class ResizeTests: XCTestCase {
    func testResizeAA_upscale() {
        let image = Image<Intensity, Float>(width: 2, height: 2, data: [0, 1,
                                                                        2, 3])
        let resized3 = image.resize(width: 3, height: 3, method: .areaAverage)
        XCTAssertEqual(resized3, Image(width: 3, height: 3, data: [0, 0.5, 1,
                                                                   1, 1.5, 2,
                                                                   2, 2.5, 3]),
                       accuracy: 1e-3)
        
        let resized4 = image.resize(width: 4, height: 4, method: .areaAverage)
        XCTAssertEqual(resized4, Image(width: 4, height: 4, data: [0, 0, 1, 1,
                                                                   0, 0, 1, 1,
                                                                   2, 2, 3, 3,
                                                                   2, 2, 3, 3]))
    }
    
    func testResizeAA_downscale_separate() {
        let image = Image(width: 4, height: 4, intensity: (0..<16).map { Float($0) })
        
        let resizedX  = image.resize(width: 3, height: 4, method: .areaAverage)
        XCTAssertEqual(resizedX,
                       Image(width: 3, height: 4, intensity: [1, 6, 11,
                                                              17, 22, 27,
                                                              33, 38, 43,
                                                              49, 54, 59].map { Float($0)/4 }),
                       accuracy: 1e-3)
        
        let resizedY  = image.resize(width: 4, height: 3, method: .areaAverage)
        XCTAssertEqual(resizedY,
                       Image(width: 4, height: 3, intensity: [4, 8, 12, 16,
                                                              24, 28, 32, 36,
                                                              44, 48, 52, 56].map { Float($0)/4 }),
                       accuracy: 1e-3)
    }
    
    func testResizeAA_downscale() {
        let image = Image(width: 4, height: 4, intensity: (0..<16).map { Float($0) })
        
        let resized2 = image.resize(width: 2, height: 2, method: .areaAverage)
        XCTAssertEqual(resized2, Image(width: 2, height: 2, data: [2.5, 4.5,
                                                                   10.5, 12.5]))
        
        let resized3 = image.resize(width: 3, height: 3, method: .areaAverage)
        XCTAssertEqual(resized3,
                       Image(width: 3, height: 3, intensity: [20, 40, 60,
                                                              100, 120, 140,
                                                              180, 200, 220].map { Float($0) / 16 }),
                       accuracy: 1e-3)
    }
    
    func testResizeAA_separate() {
        let image = Image(width: 32, height: 32, intensity: (0..<1024).map { Float($0) })
        
        let width = 6
        let height = 7
        
        let resized = image.resize(width: width, height: height, method: .areaAverage)
        let resizedX = image.resize(width: width, height: image.height, method: .areaAverage)
        let resizedY = image.resize(width: image.width, height: height, method: .areaAverage)
        
        XCTAssertEqual(resizedX.resize(width: width, height: height, method: .areaAverage),
                       resized, accuracy: 1e-3)
        XCTAssertEqual(resizedY.resize(width: width, height: height, method: .areaAverage),
                       resized, accuracy: 1e-3)
    }
}

