import XCTest
import Swim

class ImageIOTests: XCTestCase {
    
    let srcPath = URL(fileURLWithPath: "/tmp/swim_test_src.png")
    let dstPath = URL(fileURLWithPath: "/tmp/swim_test_dst.png")
    
    var baseImage: Image<RGBA, UInt8>!
    var baseLuminance: Image<Intensity, UInt8>!
    
    override func setUp() {
        self.baseImage = Image(width: 128,
                               height: 128,
                               data: (0..<128*128*4).map { UInt8($0 % Int(UInt8.max)) })
        self.baseLuminance = Image(width: 128,
                                   height: 128,
                                   data: (0..<128*128).map { UInt8($0 % Int(UInt8.max)) })
    }
    
    override func tearDown() {
        try? FileManager.default.removeItem(at: srcPath)
        try? FileManager.default.removeItem(at: dstPath)
    }
    
    func testSaveLoadUInt8() {
        do { // RGBA
            try! self.baseImage.write(to: srcPath, format: .png)
            
            let image = try? Image<RGBA, UInt8>(contentsOf: srcPath)
            
            XCTAssertEqual(image, baseImage)
        }
        do { // Intensity
            try! self.baseLuminance.write(to: srcPath, format: .png)
            
            let image = try? Image<Intensity, UInt8>(contentsOf: srcPath)
            
            XCTAssertEqual(image, baseLuminance)
        }
        do { // read Intensity as IntensityAlpha
            try! self.baseLuminance.write(to: srcPath, format: .png)
            
            let image = try? Image<IntensityAlpha, UInt8>(contentsOf: srcPath)
            
            XCTAssertEqual(image?[channel: .intensity], baseLuminance)
        }
        do { // read Intensity as RGB
            try! self.baseLuminance.write(to: srcPath, format: .png)
            
            let image = try? Image<RGB, UInt8>(contentsOf: srcPath)
            
            XCTAssertEqual(image?[channel: .red], baseLuminance)
        }
        do { // read Intensity as RGBA
            try! self.baseLuminance.write(to: srcPath, format: .png)
            
            let image = try? Image<RGBA, UInt8>(contentsOf: srcPath)
            
            XCTAssertEqual(image?[channel: .red], baseLuminance)
        }
        do { // read RGBA as Intensity
            try! self.baseImage.write(to: srcPath, format: .png)
            
            let image = try? Image<Intensity, UInt8>(contentsOf: srcPath)
            
            XCTAssertNil(image)
        }
    }
    
    func testSaveLoadFloat() {
        do {
            try! self.baseImage.write(to: srcPath, format: .png)
            let image = try! Image<RGBA, Float>(contentsOf: srcPath)
            
            XCTAssertEqual(Image(cast: (image*255).rounded()), baseImage)
            
            try! image.write(to: dstPath, format: .png)
            
            let reloaded = try! Image<RGBA, Float>(contentsOf: dstPath)
            
            XCTAssertEqual(reloaded, image)
        }
        do {
            try! self.baseLuminance.write(to: srcPath, format: .png)
            let image = try! Image<Intensity, Float>(contentsOf: srcPath)
            
            XCTAssertEqual(Image(cast: (image*255).rounded()), baseLuminance)
            
            try! image.write(to: dstPath, format: .png)
            
            let reloaded = try! Image<Intensity, Float>(contentsOf: dstPath)
            
            XCTAssertEqual(reloaded, image)
        }
    }
    
    func testSaveLoadDouble() {
        do {
            try! self.baseImage.write(to: srcPath, format: .png)
            
            let image = try! Image<RGBA, Double>(contentsOf: srcPath)
            
            XCTAssertEqual(Image(cast: (image*255).rounded()), baseImage)
            
            try! image.write(to: dstPath, format: .png)
            
            let reloaded = try! Image<RGBA, Double>(contentsOf: dstPath)
            
            XCTAssertEqual(reloaded, image)
        }
        do {
            try! self.baseLuminance.write(to: srcPath, format: .png)
            
            let image = try! Image<Intensity, Double>(contentsOf: srcPath)
            
            XCTAssertEqual(Image(cast: (image*255).rounded()), baseLuminance)
            
            try! image.write(to: dstPath, format: .png)
            
            let reloaded = try! Image<Intensity, Double>(contentsOf: dstPath)
            
            XCTAssertEqual(reloaded, image)
        }
    }
}
