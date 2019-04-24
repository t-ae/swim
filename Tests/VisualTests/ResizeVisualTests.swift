import XCTest
import Swim

class ResizeVisualTests: XCTestCase {
}

#if canImport(AppKit)

import AppKit

extension ResizeVisualTests {
    func testResize() {
        let image = Image<RGB, Double>(width: 4,
                                       height: 4,
                                       data: (0..<4*4*3).map { _ in Double.random(in: 0..<1) })
        
        let resizedNN = image.resize(width: 128, height: 192, method: .nearestNeighbor)
        let resizedBL = image.resize(width: 128, height: 192, method: .bilinear)
        let resizedBC = image.resize(width: 128, height: 192, method: .bicubic)
            .clipped(low: 0, high: 1)
        
        let concat = Image.concatH([resizedNN, resizedBL, resizedBC])
        
        let nsImage = doubleToNSImage(concat)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testResizeUpscale_lena() {
        let path = testResoruceRoot().appendingPathComponent("lena_128.png")
        let lena = try! Image<RGB, Double>(contentsOf: path)
        
        var images = [Image<RGB, Double>]()
        
        images.append(lena.resize(width: 700, height: 700, method: .nearestNeighbor))
        images.append(lena.resize(width: 700, height: 700, method: .bilinear))
        images.append(lena.resize(width: 700, height: 700, method: .bicubic))
        
        let image = Image.concatH(images)
        
        let nsImage = doubleToNSImage(Image<RGBA, Double>(image: image, alpha: 1))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    func testResizeDownscale_lena() {
        let path = testResoruceRoot().appendingPathComponent("lena_512.png")
        let lena = try! Image<RGB, Double>(contentsOf: path)
        
        var images = [Image<RGB, Double>]()
        
        images.append(lena.resize(width: 300, height: 300, method: .nearestNeighbor))
        images.append(lena.resize(width: 300, height: 300, method: .bilinear))
        images.append(lena.resize(width: 300, height: 300, method: .bicubic))
        
        let image = Image.concatH(images)
        
        let nsImage = doubleToNSImage(Image<RGBA, Double>(image: image, alpha: 1))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
}

#endif
