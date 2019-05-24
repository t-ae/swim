import XCTest
import Swim

class FilterVisualTests: XCTestCase {
    
    var imageBase: Image<Gray, Double>!
    
    override func setUp() {
        let size = 128
        imageBase = Image<Gray, Double>(width: size, height: size, value: 1)
        for y in 0..<8 {
            for x in 0..<8 {
                guard (x+y) % 2 == 0 else { continue }
                let startX = x*size/8
                let endX = startX + size/8
                let startY = y*size/8
                let endY = startY + size/8
                let value = Double(y*8+x) / 64
                imageBase.drawRect(startX..<endX, startY..<endY, color: Pixel(gray: value))
            }
        }
    }
}
#if canImport(AppKit)

extension FilterVisualTests {
    func testGaussian() {
        var image = imageBase!
        var nsImages = [NSImage]()
        
        image = image.convoluted(Filter.gaussian3x3)
        nsImages.append(doubleToNSImage(image))
        
        for _ in 0..<4 {
            image = image.convoluted(Filter.gaussian3x3)
        }
        nsImages.append(doubleToNSImage(image))
        
        for _ in 0..<10 {
            image = image.convoluted(Filter.gaussian3x3)
        }
        nsImages.append(doubleToNSImage(image))
        
        for _ in 0..<15 {
            image = image.convoluted(Filter.gaussian3x3)
        }
        nsImages.append(doubleToNSImage(image))
        
        XCTAssertFalse(nsImages.isEmpty, "Break and check nsImages in debugger")
    }
    
    func testGaussian2() {
        var image = imageBase!
        var nsImages = [NSImage]()
        
        let filter = Filter.gaussian(size: 3, sigma2: 1, scaleTo1: true)
        
        image = image.convoluted(filter)
        nsImages.append(doubleToNSImage(image))
        
        for _ in 0..<4 {
            image = image.convoluted(filter)
        }
        nsImages.append(doubleToNSImage(image))
        
        for _ in 0..<10 {
            image = image.convoluted(filter)
        }
        nsImages.append(doubleToNSImage(image))
        
        for _ in 0..<15 {
            image = image.convoluted(filter)
        }
        nsImages.append(doubleToNSImage(image))
        
        XCTAssertFalse(nsImages.isEmpty, "Break and check nsImages in debugger")
    }
    
    func testSobelLaplacian() {
        let sobelH = doubleToNSImage(imageBase.convoluted(Filter.sobel3x3H))
        let sobelV = doubleToNSImage(imageBase.convoluted(Filter.sobel3x3V))
        let laplacian = doubleToNSImage(imageBase.convoluted(Filter.laplacian3x3))
        
        XCTAssertFalse([sobelH, sobelV, laplacian].isEmpty, "Break and check nsImages in debugger")
    }
    
    func testMinMaxMedian() {
        let maximum = doubleToNSImage(imageBase.rankFilter(.maximum, kernelSize: 5))
        let minimum = doubleToNSImage(imageBase.rankFilter(.minimum, kernelSize: 5))
        let median = doubleToNSImage(imageBase.rankFilter(.median, kernelSize: 5))
        
        XCTAssertFalse([maximum, minimum, median].isEmpty, "Break and check nsImages in debugger")
    }
    
    func testBilateral() {
        let path = testResoruceRoot().appendingPathComponent("lena_256.png")
        var image = try! Image<RGB, Double>(contentsOf: path)
        var images: [Image<RGB, Double>] = [image]
        
        image = image.bilateralFilter(kernelSize: 5, sigma2_1: 1, sigma2_2: 0.01)
        images.append(image)
        
        image = image.bilateralFilter(kernelSize: 5, sigma2_1: 1, sigma2_2: 0.01)
        images.append(image)
        
        image = image.bilateralFilter(kernelSize: 5, sigma2_1: 1, sigma2_2: 0.01)
        images.append(image)
        
        let ns = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func testLena() {
        let path = testResoruceRoot().appendingPathComponent("lena_256.png")
        let image = try! Image<RGB, Double>(contentsOf: path)
        
        var images = [Image<RGB, Double>]()
        
        var gaussian = image
        for _ in 0..<10 {
            gaussian = gaussian.convoluted(Filter.gaussian5x5)
        }
        images.append(gaussian)
        
        var mean = image
        for _ in 0..<10 {
            mean = mean.convoluted(Filter.mean5x5)
        }
        images.append(mean)
        
        let emboss = image.toGray().convoluted(Filter.emboss3x3)
        images.append(emboss.toRGB())
        
        let sobelH = image.toGray().convoluted(Filter.sobel3x3H)
        images.append(sobelH.toRGB())
        
        let laplacian = image.toGray().convoluted(Filter.laplacian3x3)
        images.append(laplacian.toRGB())
        
        let nsImage = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages in debugger")
    }
}

#endif
