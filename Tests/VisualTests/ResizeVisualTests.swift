import XCTest
import Swim

class ResizeVisualTests: XCTestCase {
}

#if canImport(AppKit)

import AppKit

extension ResizeVisualTests {
    func testResize() {
        let image = Image<RGB, Double>(width: 3,
                                       height: 4,
                                       data: (0..<3*4*3).map { _ in Double.random(in: 0..<1) })
        
        let resizedNN = image.resize(width: 128, height: 192, method: .nearestNeighbor)
        let resizedBL = image.resize(width: 128, height: 192, method: .bilinear)
        let resizedBC = image.resize(width: 128, height: 192, method: .bicubic)
        let resizedAA = image.resize(width: 128, height: 192, method: .areaAverage)
        
        let concat = Image.concatH([resizedNN, resizedBL, resizedBC, resizedAA])
        
        let nsImage = doubleToNSImage(concat)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testResizeUpscale_lena() {
        let path = testResoruceRoot().appendingPathComponent("lena_128.png")
        let lena = try! Image<RGB, Double>(contentsOf: path)
        
        var images = [Image<RGB, Double>]()
        
        let size = 300
        images.append(lena.resize(width: size, height: size, method: .nearestNeighbor))
        images.append(lena.resize(width: size, height: size, method: .bilinear))
        images.append(lena.resize(width: size, height: size, method: .bicubic))
        images.append(lena.resize(width: size, height: size, method: .lanczos2))
        images.append(lena.resize(width: size, height: size, method: .lanczos3))
        images.append(lena.resize(width: size, height: size, method: .areaAverage))
        
        let image = Image.concatH(images)
        
        let nsImage = doubleToNSImage(image.toRGBA(with: 1))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testResizeDownscale_lena() {
        let path = testResoruceRoot().appendingPathComponent("lena_512.png")
        let lena = try! Image<RGB, Double>(contentsOf: path)
        
        var images = [Image<RGB, Double>]()
        
        let size = 100
        images.append(lena.resize(width: size, height: size, method: .nearestNeighbor))
        images.append(lena.resize(width: size, height: size, method: .bilinear))
        images.append(lena.resize(width: size, height: size, method: .bicubic))
        images.append(lena.resize(width: size, height: size, method: .lanczos2))
        images.append(lena.resize(width: size, height: size, method: .lanczos3))
        images.append(lena.resize(width: size, height: size, method: .areaAverage))
        
        let image = Image.concatH(images)
        
        let nsImage = doubleToNSImage(image.toRGBA(with: 1))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
}

#endif
