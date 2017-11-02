
import XCTest
import Swim

class ImageIOTests: XCTestCase {
    
    let srcPath = URL(fileURLWithPath: "/tmp/src.png")
    let dstPath = URL(fileURLWithPath: "/tmp/dst.png")
    
    var baseImage: Image<RGBA, UInt8>!
    
    override func setUp() {
        self.baseImage = Image<RGBA, UInt8>(width: 8,
                                            height: 8,
                                            data: (0..<256).map { UInt8($0) })
        try! self.baseImage.write(to: srcPath, type: .png)
    }
    
    override func tearDown() {
        try? FileManager.default.removeItem(at: srcPath)
        try? FileManager.default.removeItem(at: dstPath)
    }
    
    func testSaveLoadUInt8() {
        let image = Image<RGBA, UInt8>(contentsOf: srcPath)!
        
        XCTAssertEqual(image, baseImage)
    }
    
    func testSaveLoadFloat() {
        let image = Image<RGBA, Float>(contentsOf: srcPath)!
        
        XCTAssertEqual((image.clipped(low: 0, high: 1)*255).rounded().typeConverted(), baseImage)
        
        try! image.write(to: dstPath, type: .png)
        
        let reloaded = Image<RGBA, Float>(contentsOf: dstPath)!

        XCTAssertEqual(reloaded, image)
    }
    
    func testSaveLoadDouble() {
        let image = Image<RGBA, Double>(contentsOf: srcPath)!
        
        XCTAssertEqual((image.clipped(low: 0, high: 1)*255).rounded().typeConverted(), baseImage)
        
        try! image.write(to: dstPath, type: .png)
        
        let reloaded = Image<RGBA, Double>(contentsOf: dstPath)!
        
        XCTAssertEqual(reloaded, image)
    }
}
