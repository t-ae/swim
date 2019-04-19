import XCTest
import Swim

class FilterVisualTests: XCTestCase {
    
    var imageBase: Image<Intensity, Double>!
    
    override func setUp() {
        let size = 128
        imageBase = Image<Intensity, Double>(width: size, height: size, value: 1)
        for y in 0..<8 {
            for x in 0..<8 {
                guard (x+y) % 2 == 0 else { continue }
                let startX = x*size/8
                let endX = startX + size/8
                let startY = y*size/8
                let endY = startY + size/8
                let value = Double(y*8+x) / 64
                imageBase[startX..<endX, startY..<endY].fill(value)
            }
        }
        let nsImageBase = doubleToNSImage(imageBase)
        _ = nsImageBase
    }
    
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
    
    func testSobelLaplacian() {
        let sobelH = doubleToNSImage(imageBase.convoluted(Filter.sobel3x3H))
        let sobelV = doubleToNSImage(imageBase.convoluted(Filter.sobel3x3V))
        let laplacian = doubleToNSImage(imageBase.convoluted(Filter.laplacian3x3))
        
        XCTAssertFalse([sobelH, sobelV, laplacian].isEmpty, "Break and check nsImages in debugger")
    }
    
    func testMinMaxMedian() {
        let maximum = doubleToNSImage(imageBase.maximumFilter(kernelSize: 5))
        let minimum = doubleToNSImage(imageBase.minimumFilter(kernelSize: 5))
        let median = doubleToNSImage(imageBase.medianFilter(kernelSize: 5))
        
        XCTAssertFalse([maximum, minimum, median].isEmpty, "Break and check nsImages in debugger")
    }
}
