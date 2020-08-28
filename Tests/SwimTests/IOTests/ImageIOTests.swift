import XCTest
import Swim

class ImageIOTests: XCTestCase {
    
    let srcPath = URL(fileURLWithPath: "/tmp/swim_test_src.png")
    let dstPath = URL(fileURLWithPath: "/tmp/swim_test_dst.png")
    
    var baseImage: Image<RGBA, UInt8>!
    var baseLuminance: Image<Gray, UInt8>!
    
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
            try! self.baseImage.write(to: srcPath)
            
            let image = try? Image<RGBA, UInt8>(contentsOf: srcPath)
            
            XCTAssertEqual(image, baseImage)
        }
        do { // Gray
            try! self.baseLuminance.write(to: srcPath, format: .png)
            
            let image = try? Image<Gray, UInt8>(contentsOf: srcPath)
            
            XCTAssertEqual(image, baseLuminance)
        }
        do { // read Gray as GrayAlpha
            try! self.baseLuminance.write(to: srcPath, format: .png)
            
            let image = try? Image<GrayAlpha, UInt8>(contentsOf: srcPath)
            
            XCTAssertEqual(image?[channel: .gray], baseLuminance)
            
            try? image?.write(to: dstPath)
            
            let image2 = try? Image<GrayAlpha, UInt8>(contentsOf: dstPath)
            
            XCTAssertEqual(image, image2)
        }
        do { // read Gray as RGB
            try! self.baseLuminance.write(to: srcPath, format: .png)
            
            let image = try? Image<RGB, UInt8>(contentsOf: srcPath)
            
            XCTAssertEqual(image?[channel: .red], baseLuminance)
            
            try? image?.write(to: dstPath)
            
            let image2 = try? Image<RGB, UInt8>(contentsOf: dstPath)
            
            XCTAssertEqual(image, image2)
        }
        do { // read Gray as RGBA
            try! self.baseLuminance.write(to: srcPath, format: .png)
            
            let image = try? Image<RGBA, UInt8>(contentsOf: srcPath)
            
            XCTAssertEqual(image?[channel: .red], baseLuminance)
            
            try? image?.write(to: dstPath)
            
            let image2 = try? Image<RGBA, UInt8>(contentsOf: dstPath)
            
            XCTAssertEqual(image, image2)
        }
        do { // read RGBA as Gray
            try! self.baseImage.write(to: srcPath)
            
            let image = try? Image<Gray, UInt8>(contentsOf: srcPath)
            
            XCTAssertNil(image)
        }
    }
    
    func testSaveLoadFloat() {
        do {
            try! self.baseImage.write(to: srcPath)
            let image = try! Image<RGBA, Float>(contentsOf: srcPath)
            
            XCTAssertEqual((image*255).round().cast(), baseImage)
            
            try! image.write(to: dstPath)
            
            let reloaded = try! Image<RGBA, Float>(contentsOf: dstPath)
            
            XCTAssertEqual(reloaded, image)
        }
        do {
            try! self.baseLuminance.write(to: srcPath, format: .png)
            let image = try! Image<Gray, Float>(contentsOf: srcPath)
            
            XCTAssertEqual((image*255).round().cast(), baseLuminance)
            
            try! image.write(to: dstPath, format: .png)
            
            let reloaded = try! Image<Gray, Float>(contentsOf: dstPath)
            
            XCTAssertEqual(reloaded, image)
        }
    }
    
    func testSaveLoadDouble() {
        do {
            try! self.baseImage.write(to: srcPath)
            
            let image = try! Image<RGBA, Double>(contentsOf: srcPath)
            
            XCTAssertEqual((image*255).round().cast(), baseImage)
            
            try! image.write(to: dstPath)
            
            let reloaded = try! Image<RGBA, Double>(contentsOf: dstPath)
            
            XCTAssertEqual(reloaded, image)
        }
        do {
            try! self.baseLuminance.write(to: srcPath, format: .png)
            
            let image = try! Image<Gray, Double>(contentsOf: srcPath)
            
            XCTAssertEqual((image*255).round().cast(), baseLuminance)
            
            try! image.write(to: dstPath, format: .png)
            
            let reloaded = try! Image<Gray, Double>(contentsOf: dstPath)
            
            XCTAssertEqual(reloaded, image)
        }
    }
    
    func testReadDataUInt8() throws {
        typealias DataType = UInt8
        do { // RGBA
            try baseImage.write(to: srcPath)
            let fromFile = try Image<RGBA, DataType>(contentsOf: srcPath)
            let fromMemory = try Image<RGBA, DataType>(fileData: Data(contentsOf: srcPath))
            XCTAssertEqual(fromMemory, fromFile)
        }
        do { // Gray
            try baseLuminance.write(to: srcPath)
            let fromFile = try Image<Gray, DataType>(contentsOf: srcPath)
            let fromMemory = try Image<Gray, DataType>(fileData: Data(contentsOf: srcPath))
            XCTAssertEqual(fromMemory, fromFile)
        }
        do { // Gray as GrayAlpha
            try baseLuminance.write(to: srcPath)
            let fromFile = try Image<GrayAlpha, DataType>(contentsOf: srcPath)
            let fromMemory = try Image<GrayAlpha, DataType>(fileData: Data(contentsOf: srcPath))
            XCTAssertEqual(fromMemory, fromFile)
        }
        do { // Gray as RGB
            try baseLuminance.write(to: srcPath)
            let fromFile = try Image<RGB, DataType>(contentsOf: srcPath)
            let fromMemory = try Image<RGB, DataType>(fileData: Data(contentsOf: srcPath))
            XCTAssertEqual(fromMemory, fromFile)
        }
        do { // Gray as RGBA
            try baseLuminance.write(to: srcPath)
            let fromFile = try Image<RGBA, DataType>(contentsOf: srcPath)
            let fromMemory = try Image<RGBA, DataType>(fileData: Data(contentsOf: srcPath))
            XCTAssertEqual(fromMemory, fromFile)
        }
    }
    
    func testReadDataFloat() throws {
        typealias DataType = Float
        do { // RGBA
            try baseImage.write(to: srcPath)
            let fromFile = try Image<RGBA, DataType>(contentsOf: srcPath)
            let fromMemory = try Image<RGBA, DataType>(fileData: Data(contentsOf: srcPath))
            XCTAssertEqual(fromMemory, fromFile)
        }
        do { // Gray
            try baseLuminance.write(to: srcPath)
            let fromFile = try Image<Gray, DataType>(contentsOf: srcPath)
            let fromMemory = try Image<Gray, DataType>(fileData: Data(contentsOf: srcPath))
            XCTAssertEqual(fromMemory, fromFile)
        }
        do { // Gray as GrayAlpha
            try baseLuminance.write(to: srcPath)
            let fromFile = try Image<GrayAlpha, DataType>(contentsOf: srcPath)
            let fromMemory = try Image<GrayAlpha, DataType>(fileData: Data(contentsOf: srcPath))
            XCTAssertEqual(fromMemory, fromFile)
        }
        do { // Gray as RGB
            try baseLuminance.write(to: srcPath)
            let fromFile = try Image<RGB, DataType>(contentsOf: srcPath)
            let fromMemory = try Image<RGB, DataType>(fileData: Data(contentsOf: srcPath))
            XCTAssertEqual(fromMemory, fromFile)
        }
        do { // Gray as RGBA
            try baseLuminance.write(to: srcPath)
            let fromFile = try Image<RGBA, DataType>(contentsOf: srcPath)
            let fromMemory = try Image<RGBA, DataType>(fileData: Data(contentsOf: srcPath))
            XCTAssertEqual(fromMemory, fromFile)
        }
    }
    
    func testReadDataDouble() throws {
        typealias DataType = Double
        do { // RGBA
            try baseImage.write(to: srcPath)
            let fromFile = try Image<RGBA, DataType>(contentsOf: srcPath)
            let fromMemory = try Image<RGBA, DataType>(fileData: Data(contentsOf: srcPath))
            XCTAssertEqual(fromMemory, fromFile)
        }
        do { // Gray
            try baseLuminance.write(to: srcPath)
            let fromFile = try Image<Gray, DataType>(contentsOf: srcPath)
            let fromMemory = try Image<Gray, DataType>(fileData: Data(contentsOf: srcPath))
            XCTAssertEqual(fromMemory, fromFile)
        }
        do { // Gray as GrayAlpha
            try baseLuminance.write(to: srcPath)
            let fromFile = try Image<GrayAlpha, DataType>(contentsOf: srcPath)
            let fromMemory = try Image<GrayAlpha, DataType>(fileData: Data(contentsOf: srcPath))
            XCTAssertEqual(fromMemory, fromFile)
        }
        do { // Gray as RGB
            try baseLuminance.write(to: srcPath)
            let fromFile = try Image<RGB, DataType>(contentsOf: srcPath)
            let fromMemory = try Image<RGB, DataType>(fileData: Data(contentsOf: srcPath))
            XCTAssertEqual(fromMemory, fromFile)
        }
        do { // Gray as RGBA
            try baseLuminance.write(to: srcPath)
            let fromFile = try Image<RGBA, DataType>(contentsOf: srcPath)
            let fromMemory = try Image<RGBA, DataType>(fileData: Data(contentsOf: srcPath))
            XCTAssertEqual(fromMemory, fromFile)
        }
    }
    
    func testWriteDataUInt8() {
        do { // RGBA
            let image = self.baseImage!
            
            try! image.write(to: srcPath)

            let data = try! image.fileData()
            
            XCTAssertEqual(data, try! Data(contentsOf: srcPath))
        }
        do { // RGB
            let image = self.baseImage.toRGB()
            
            for format in WriteFormat.all {
                try! image.write(to: srcPath, format: format)

                let data = try! image.fileData(format: format)

                XCTAssertEqual(data, try! Data(contentsOf: srcPath))
            }
        }
        do { // Grey
            let image = self.baseLuminance!

            for format in WriteFormat.all {
                try! image.write(to: srcPath, format: format)

                let data = try! image.fileData(format: format)

                XCTAssertEqual(data, try! Data(contentsOf: srcPath))
            }
        }
    }
    
    func testWriteDataFloat() {
        do { // RGBA
            let image = (self.baseImage / UInt8.max).cast(to: Float.self)
            
            try! image.write(to: srcPath)

            let data = try! image.fileData()
            
            XCTAssertEqual(data, try! Data(contentsOf: srcPath))
        }
        do { // RGB
            let image = (self.baseImage.toRGB() / UInt8.max).cast(to: Float.self)
            
            for format in WriteFormat.all {
                try! image.write(to: srcPath, format: format)

                let data = try! image.fileData(format: format)

                XCTAssertEqual(data, try! Data(contentsOf: srcPath))
            }
        }
        do { // Grey
            let image = (self.baseLuminance / UInt8.max).cast(to: Float.self)

            for format in WriteFormat.all {
                try! image.write(to: srcPath, format: format)

                let data = try! image.fileData(format: format)

                XCTAssertEqual(data, try! Data(contentsOf: srcPath))
            }
        }
    }
    
    func testWriteDataDouble() {
        do { // RGBA
            let image = (self.baseImage / UInt8.max).cast(to: Double.self)
            
            try! image.write(to: srcPath)

            let data = try! image.fileData()
            
            XCTAssertEqual(data, try! Data(contentsOf: srcPath))
        }
        do { // RGB
            let image = (self.baseImage.toRGB() / UInt8.max).cast(to: Double.self)
            
            for format in WriteFormat.all {
                try! image.write(to: srcPath, format: format)

                let data = try! image.fileData(format: format)

                XCTAssertEqual(data, try! Data(contentsOf: srcPath))
            }
        }
        do { // Grey
            let image = (self.baseLuminance / UInt8.max).cast(to: Double.self)

            for format in WriteFormat.all {
                try! image.write(to: srcPath, format: format)

                let data = try! image.fileData(format: format)

                XCTAssertEqual(data, try! Data(contentsOf: srcPath))
            }
        }
    }
    
    static let allTests = [
        ("testSaveLoadUInt8", testSaveLoadUInt8),
        ("testSaveLoadFloat", testSaveLoadFloat),
        ("testSaveLoadDouble", testSaveLoadDouble),
        ("testReadDataUInt8", testReadDataUInt8),
        ("testReadDataFloat", testReadDataFloat),
        ("testReadDataDouble", testReadDataDouble),
        ("testWriteDataUInt8", testWriteDataUInt8),
        ("testWriteDataFloat", testWriteDataFloat),
        ("testWriteDataDouble", testWriteDataDouble)
    ]
}

fileprivate extension WriteFormat {
    static let all: [WriteFormat] = [.bitmap, .jpeg(quality: 90), .png]
}
