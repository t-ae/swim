import XCTest
import Swim

class BayerVisualTests: XCTestCase {
    let lenaUInt8 = try! Image<RGB, UInt8>(contentsOf: testResoruceRoot().appendingPathComponent("lena_256.png"))
    let lenaDouble = try! Image<RGB, Double>(contentsOf: testResoruceRoot().appendingPathComponent("lena_256.png"))
}

#if canImport(AppKit)

extension BayerVisualTests {
    func testBGGR() {
        let lena = lenaDouble
        let conv = BayerConverter(pattern: .bggr)
        
        var images: [Image<RGB, Double>] = []
        do {
            images.append(lena)
            let gray = conv.convert(image: lena)
            images.append(gray.toRGB())
            let color = conv.demosaic(image: gray)
            images.append(color)
            
            print("PSNR=\(ImageCompare.psnr(lena, color))")
            print("SSIM=\(ImageCompare.ssim(lena, color, windowSize: 7))")
        }
        
        let nsImage = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
    
    func testGBRG() {
        let lena = lenaDouble
        let conv = BayerConverter(pattern: .gbrg)
        
        var images: [Image<RGB, Double>] = []
        do {
            images.append(lena)
            let gray = conv.convert(image: lena)
            images.append(gray.toRGB())
            let color = conv.demosaic(image: gray)
            images.append(color)
            
            print("PSNR=\(ImageCompare.psnr(lena, color))")
            print("SSIM=\(ImageCompare.ssim(lena, color, windowSize: 7))")
        }
        
        let nsImage = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
    
    func testGRBG() {
        let lena = lenaDouble
        let conv = BayerConverter(pattern: .grbg)
        
        var images: [Image<RGB, Double>] = []
        do {
            images.append(lena)
            let gray = conv.convert(image: lena)
            images.append(gray.toRGB())
            let color = conv.demosaic(image: gray)
            images.append(color)
            
            print("PSNR=\(ImageCompare.psnr(lena, color))")
            print("SSIM=\(ImageCompare.ssim(lena, color, windowSize: 7))")
        }
        
        let nsImage = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
    
    func testRGGB() {
        let lena = lenaDouble
        let conv = BayerConverter(pattern: .rggb)
        
        var images: [Image<RGB, Double>] = []
        do {
            images.append(lena)
            let gray = conv.convert(image: lena)
            images.append(gray.toRGB())
            let color = conv.demosaic(image: gray)
            images.append(color)
            
            print("PSNR=\(ImageCompare.psnr(lena, color))")
            print("SSIM=\(ImageCompare.ssim(lena, color, windowSize: 7))")
        }
        
        let nsImage = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
    
    func testBGGR_UInt8() {
        let lena = lenaUInt8
        let conv = BayerConverter(pattern: .bggr)
        
        var images: [Image<RGB, UInt8>] = []
        do {
            images.append(lena)
            let gray = conv.convert(image: lena)
            images.append(gray.toRGB())
            let color = conv.demosaic(image: gray)
            images.append(color)
        }
        
        let nsImage = Image.concatH(images).nsImage()
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
    
    func testGBRG_UInt8() {
        let lena = lenaUInt8
        let conv = BayerConverter(pattern: .gbrg)
        
        var images: [Image<RGB, UInt8>] = []
        do {
            images.append(lena)
            let gray = conv.convert(image: lena)
            images.append(gray.toRGB())
            let color = conv.demosaic(image: gray)
            images.append(color)
        }
        
        let nsImage = Image.concatH(images).nsImage()
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
    
    func testGRBG_UInt8() {
        let lena = lenaUInt8
        let conv = BayerConverter(pattern: .grbg)
        
        var images: [Image<RGB, UInt8>] = []
        do {
            images.append(lena)
            let gray = conv.convert(image: lena)
            images.append(gray.toRGB())
            let color = conv.demosaic(image: gray)
            images.append(color)
        }
        
        let nsImage = Image.concatH(images).nsImage()
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
    
    func testRGGB_UInt8() {
        let lena = lenaUInt8
        let conv = BayerConverter(pattern: .rggb)
        
        var images: [Image<RGB, UInt8>] = []
        do {
            images.append(lena)
            let gray = conv.convert(image: lena)
            images.append(gray.toRGB())
            let color = conv.demosaic(image: gray)
            images.append(color)
        }
        
        let nsImage = Image.concatH(images).nsImage()
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
}

#endif
