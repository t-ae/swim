
import XCTest
import Swim

class ImageIOTests: XCTestCase {
    
    let srcPath = URL(fileURLWithPath: "/tmp/swim_test_src.png")
    let dstPath = URL(fileURLWithPath: "/tmp/swim_test_dst.png")
    
    var baseImage: Image<RGBA, UInt8>!
    var baseLuminance: Image<Intensity, UInt8>!
    
    override func setUp() {
        self.baseImage = Image(width: 8,
                               height: 8,
                               data: (0..<256).map { UInt8($0) })
        self.baseLuminance = Image(width: 4,
                                   height: 4,
                                   data: (0..<16).map { UInt8($0) })
    }
    
    override func tearDown() {
        try? FileManager.default.removeItem(at: srcPath)
        try? FileManager.default.removeItem(at: dstPath)
    }
    
    func testSaveLoadUInt8() {
        do {
            try! self.baseImage.write(to: srcPath, type: .png)
            
            let image = Image<RGBA, UInt8>(contentsOf: srcPath)!
            
            XCTAssertEqual(image, baseImage)
        }
        do {
            try! self.baseLuminance.write(to: srcPath, type: .png)
            
            let image = Image<Intensity, UInt8>(contentsOf: srcPath)!
            
            XCTAssertEqual(image, baseLuminance)
        }
    }
    
    func testSaveLoadFloat() {
        do {
            try! self.baseImage.write(to: srcPath, type: .png)
            let image = Image<RGBA, Float>(contentsOf: srcPath)!
            
            XCTAssertEqual((image.clipped(low: 0, high: 1)*255).rounded().typeConverted(), baseImage)
            
            try! image.write(to: dstPath, type: .png)
            
            let reloaded = Image<RGBA, Float>(contentsOf: dstPath)!
            
            XCTAssertEqual(reloaded, image)
        }
        do {
            try! self.baseLuminance.write(to: srcPath, type: .png)
            let image = Image<Intensity, Float>(contentsOf: srcPath)!
            
            XCTAssertEqual((image.clipped(low: 0, high: 1)*255).rounded().typeConverted(), baseLuminance)
            
            try! image.write(to: dstPath, type: .png)
            
            let reloaded = Image<Intensity, Float>(contentsOf: dstPath)!
            
            XCTAssertEqual(reloaded, image)
        }
    }
    
    func testSaveLoadDouble() {
        do {
            try! self.baseImage.write(to: srcPath, type: .png)
            
            let image = Image<RGBA, Double>(contentsOf: srcPath)!
            
            XCTAssertEqual((image.clipped(low: 0, high: 1)*255).rounded().typeConverted(), baseImage)
            
            try! image.write(to: dstPath, type: .png)
            
            let reloaded = Image<RGBA, Double>(contentsOf: dstPath)!
            
            XCTAssertEqual(reloaded, image)
        }
        do {
            try! self.baseLuminance.write(to: srcPath, type: .png)
            
            let image = Image<Intensity, Double>(contentsOf: srcPath)!
            
            XCTAssertEqual((image.clipped(low: 0, high: 1)*255).rounded().typeConverted(), baseLuminance)
            
            try! image.write(to: dstPath, type: .png)
            
            let reloaded = Image<Intensity, Double>(contentsOf: dstPath)!
            
            XCTAssertEqual(reloaded, image)
        }
    }
}
