import XCTest
import Swim

class vImageVisualTests: XCTestCase {
}

#if canImport(Accelerate)

extension vImageVisualTests {
    func testDilate() throws {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        let lena = try! Image<Gray, UInt8>(contentsOf: path)
        
        var images: [Image<Gray, UInt8>] = []
        
        let kernel = Image<Gray, UInt8>(width: 3, height: 3, data: [255, 255, 255,
                                                                    255, 255, 255,
                                                                    255, 255, 255])
        
        var dilated = lena
        for _ in 0..<3 {
            dilated = try vImageUtils.dilate(src: &dilated, kernel: kernel)
            images.append(dilated)
        }
        
        let nsImage = Image.concatH(images).nsImage()
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testErode() throws {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        let lena = try! Image<Gray, UInt8>(contentsOf: path)
        
        var images: [Image<Gray, UInt8>] = [lena]
        
        let kernel = Image<Gray, UInt8>(width: 3, height: 3, data: [255, 255, 255,
                                                                    255, 255, 255,
                                                                    255, 255, 255])
        
        var eroded = lena
        for _ in 0..<3 {
            eroded = try vImageUtils.erode(src: &eroded, kernel: kernel)
            images.append(eroded)
        }
        
        let nsImage = Image.concatH(images).nsImage()
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testAlphaBlend() throws {
        let color: Image<RGB, UInt8> = rainbowImage256()
        var bottom = color.toARGB(with: 255)
        let alpha: Image<Gray, UInt8> = gradiationImage256()
        var top = Image(a: alpha, rgb: color).transposed()
        
        let nsImage = try vImageUtils.alphaBlend(top: &top, bottom: &bottom)
            .toRGBA().nsImage()
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testAlphaBlendFloat() throws {
        let color: Image<RGB, Float> = rainbowImage256()
        var bottom = color.toARGB(with: 1)
        let alpha: Image<Gray, Float> = gradiationImage256()
        var top = Image(a: alpha, rgb: color).transposed()
        
        let nsImage = try vImageUtils.alphaBlend(top: &top, bottom: &bottom)
            .toRGBA().nsImage()
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
}

#endif
