
import XCTest
import Swim

class ImageIOTests: XCTestCase {
    
    let srcPath = "/tmp/src.png"
    let dstPath = "/tmp/dst.png"
    
    var baseImage: Image<RGBA, UInt8>!
    
    override func setUp() {
        self.baseImage = Image<RGBA, UInt8>(width: 4,
                                            height: 4,
                                            data: [0, 0, 0, 0,
                                                   255, 0, 0, 255,
                                                   0, 255, 0, 255,
                                                   0, 0, 255, 255,
                                                   255, 255, 0, 255,
                                                   255, 0, 255, 255,
                                                   0, 255, 255, 255,
                                                   255, 255, 255, 255,
                                                   1, 2, 3, 4,
                                                   31, 32, 33, 34,
                                                   71, 72, 73, 74,
                                                   131, 132, 133, 134,
                                                   171, 172, 173, 174,
                                                   191, 192, 193, 194,
                                                   231, 232, 233, 234,
                                                   251, 252, 253, 254])
        try! self.baseImage.write(path: srcPath, type: .png)
    }
    
    override func tearDown() {
        try? FileManager.default.removeItem(atPath: srcPath)
        try? FileManager.default.removeItem(atPath: dstPath)
    }
    
    func testSaveLoadUInt8() {
        
        guard FileManager.default.fileExists(atPath: srcPath) else {
            return
        }
        
        let image = Image<RGBA, UInt8>(path: srcPath)!
        
        XCTAssertEqual(image, baseImage)
    }
    
    func testSaveLoadFloat() {
        
        guard FileManager.default.fileExists(atPath: srcPath) else {
            return
        }
        
        let image = Image<RGBA, Float>(path: srcPath)!
        
        XCTAssertEqual((image.clipped(low: 0, high: 1)*255).rounded().typeConverted(), baseImage)
        
        try! image.write(path: dstPath, type: .png)
        
        let reloaded = Image<RGBA, Float>(path: dstPath)!

        XCTAssertEqual(reloaded, image)
    }
    
    func testSaveLoadDouble() {
        
        guard FileManager.default.fileExists(atPath: srcPath) else {
            return
        }
        
        let image = Image<RGBA, Double>(path: srcPath)!
        
        XCTAssertEqual((image.clipped(low: 0, high: 1)*255).rounded().typeConverted(), baseImage)
        
        try! image.write(path: dstPath, type: .png)
        
        let reloaded = Image<RGBA, Double>(path: dstPath)!
        
        XCTAssertEqual(reloaded, image)
    }
}
