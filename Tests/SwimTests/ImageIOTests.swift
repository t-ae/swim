
import XCTest
import Swim

class ImageIOTests: XCTestCase {
    
    let srcPath = "/tmp/src.png"
    let dstPath = "/tmp/dst.png"
    
    var baseImage: Image<RGBA, UInt8>!
    
    override func setUp() {
        self.baseImage = Image<RGBA, UInt8>(width: 8,
                                            height: 8,
                                            data: (0..<256).map { UInt8($0) })
        try! self.baseImage.write(to: srcPath, type: .png)
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
        
        try! image.write(to: dstPath, type: .png)
        
        let reloaded = Image<RGBA, Float>(path: dstPath)!

        XCTAssertEqual(reloaded, image)
    }
    
    func testSaveLoadDouble() {
        
        guard FileManager.default.fileExists(atPath: srcPath) else {
            return
        }
        
        let image = Image<RGBA, Double>(path: srcPath)!
        
        XCTAssertEqual((image.clipped(low: 0, high: 1)*255).rounded().typeConverted(), baseImage)
        
        try! image.write(to: dstPath, type: .png)
        
        let reloaded = Image<RGBA, Double>(path: dstPath)!
        
        XCTAssertEqual(reloaded, image)
    }
}
