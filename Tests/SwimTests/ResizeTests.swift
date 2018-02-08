
import XCTest
import Swim

class ResizeTests: XCTestCase {
    func testResizenn_upscale() {
        let image = Image<Intensity, Float>(width: 2, height: 2, data: [0, 1,
                                                                        2, 3])
        let resized3 = image.resizenn(width: 3, height: 3)
        XCTAssertEqual(resized3, Image(width: 3, height: 3, data: [0, 1, 1,
                                                                  2, 3, 3,
                                                                  2, 3, 3]))
        
        let resized4 = image.resizenn(width: 4, height: 4)
        XCTAssertEqual(resized4, Image(width: 4, height: 4, data: [0, 0, 1, 1,
                                                                  0, 0, 1, 1,
                                                                  2, 2, 3, 3,
                                                                  2, 2, 3, 3]))
    }
    
    func testResizenn_downscale() {
        let image = Image(width: 4, height: 4, intensity: (0..<16).map { Float($0) })
        
        let resized2 = image.resizenn(width: 2, height: 2)
        XCTAssertEqual(resized2, Image(width: 2, height: 2, data: [0, 3,
                                                                   12, 15]))
        
        let resized3 = image.resizenn(width: 3, height: 3)
        XCTAssertEqual(resized3, Image(width: 3, height: 3, data: [0, 2,  3,
                                                                   8, 10, 11,
                                                                   12, 14, 15]))
    }
    
    func testResizeaa_upscale() {
        let image = Image<Intensity, Float>(width: 2, height: 2, data: [0, 1,
                                                                        2, 3])
        let resized3 = image.resizeaa(width: 3, height: 3)
        XCTAssertEqual(resized3, Image(width: 3, height: 3, data: [0, 0.5, 1,
                                                                   1, 1.5, 2,
                                                                   2, 2.5, 3]),
                       accuracy: 1e-3)
        
        let resized4 = image.resizeaa(width: 4, height: 4)
        XCTAssertEqual(resized4, Image(width: 4, height: 4, data: [0, 0, 1, 1,
                                                                   0, 0, 1, 1,
                                                                   2, 2, 3, 3,
                                                                   2, 2, 3, 3]))
    }
    
    func testResizeaa_downscale_separate() {
        let image = Image(width: 4, height: 4, intensity: (0..<16).map { Float($0) })
        
        let resizedX  = image.resizeaa(width: 3, height: 4)
        XCTAssertEqual(resizedX,
                       Image(width: 3, height: 4, intensity: [1, 6, 11,
                                                              17, 22, 27,
                                                              33, 38, 43,
                                                              49, 54, 59].map { Float($0)/4 }),
                       accuracy: 1e-3)
        
        let resizedY  = image.resizeaa(width: 4, height: 3)
        XCTAssertEqual(resizedY,
                       Image(width: 4, height: 3, intensity: [4, 8, 12, 16,
                                                              24, 28, 32, 36,
                                                              44, 48, 52, 56].map { Float($0)/4 }),
                       accuracy: 1e-3)
    }
    
    func testResizeaa_downscale() {
        let image = Image(width: 4, height: 4, intensity: (0..<16).map { Float($0) })
        
        let resized2 = image.resizeaa(width: 2, height: 2)
        XCTAssertEqual(resized2, Image(width: 2, height: 2, data: [2.5, 4.5,
                                                                   10.5, 12.5]))
        
        let resized3 = image.resizeaa(width: 3, height: 3)
        XCTAssertEqual(resized3,
                       Image(width: 3, height: 3, intensity: [20, 40, 60,
                                                              100, 120, 140,
                                                              180, 200, 220].map { Float($0) / 16 }),
                       accuracy: 1e-3)
    }
    
    func testResizeaa_separate() {
        let image = Image(width: 32, height: 32, intensity: (0..<1024).map { Float($0) })
        
        let width = 6
        let height = 7
        
        let resized = image.resizeaa(width: width, height: height)
        let resizedX = image.resizeaa(width: width, height: image.height)
        let resizedY = image.resizeaa(width: image.width, height: height)
        
        XCTAssertEqual(resizedX.resizeaa(width: width, height: height), resized, accuracy: 1e-3)
        XCTAssertEqual(resizedY.resizeaa(width: width, height: height), resized, accuracy: 1e-3)
    }
    
    func testResizebn_upscale() {
        let image = Image<Intensity, Float>(width: 2, height: 2, data: [0, 1,
                                                                        2, 3])
        let resized3 = image.resizebn(width: 3, height: 3)
        XCTAssertEqual(resized3, Image(width: 3, height: 3, data: [0, 0.5, 1,
                                                                   1, 1.5, 2,
                                                                   2, 2.5, 3]))
        
        let resized4 = image.resizebn(width: 4, height: 4)
        XCTAssertEqual(resized4,
                       Image(width: 4, height: 4, data: [0, 1, 2, 3,
                                                         2, 3, 4, 5,
                                                         4, 5, 6, 7,
                                                         6, 7, 8, 9].map { Float($0)/3 }),
                       accuracy: 1e-3)
    }
    
    func testResizebn_downscale() {
        let image = Image(width: 4, height: 4, intensity: (0..<16).map { Float($0) })
        
        let resized2 = image.resizebn(width: 2, height: 2)
        XCTAssertEqual(resized2, Image(width: 2, height: 2, data: [0, 3,
                                                                   12, 15]))
        
        let resized3 = image.resizebn(width: 3, height: 3)
        XCTAssertEqual(resized3,
                       Image(width: 3, height: 3, intensity: [0, 1.5, 3,
                                                              6, 7.5, 9,
                                                              12, 13.5, 15]),
                       accuracy: 1e-3)
    }
}

