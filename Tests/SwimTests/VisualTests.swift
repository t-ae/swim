
import XCTest
import Swim

// Set brakepoints and look NSImages in Xcode debugger

class VisualTests: XCTestCase {
    #if !SWIFT_PACKAGE && os(macOS)
    
    func testAlphaBlend() {
        var imageBase = Image<RGB, Float>(width: 100, height: 100, data: [Float](repeating: 1, count: 100*100*3))
        imageBase[20..<60, 20..<60].fill(Pixel(r: 1, g: 0, b: 0))
        
        
        var imageAlpha = Image<RGBA, Float>(width: 100, height: 100, data: [Float](repeating: 0, count: 100*100*4))
        imageAlpha[40..<80, 40..<80].fill(Pixel(r: 0, g: 0, b: 1, a: 0.5))
        
        imageBase.alphaBlend(with: imageAlpha)
        
        let rgb256 = (imageBase * 255).typeConverted(to: UInt8.self)
        let nsImage = rgb256.nsImage()
        
        print("break here")
    }
    
    func testFilter() {
        let size = 128
        var imageBase = Image<Intensity, Float>(width: size, height: size, data: [Float](repeating: 1, count: size*size))
        for y in 0..<8 {
            for x in 0..<8 {
                guard (x+y) % 2 == 0 else { continue }
                let startX = x*size/8
                let endX = startX + size/8
                let startY = y*size/8
                let endY = startY + size/8
                imageBase[startX..<endX, startY..<endY].fill(0)
            }
        }
        let nsImageBase = float01ToNSImage(image: imageBase)
        do {
            var image = imageBase
            image = image.convoluted(Filter.gaussian3x3)
            let blur1 = float01ToNSImage(image: image)
            for _ in 0..<4 {
                image = image.convoluted(Filter.gaussian3x3)
            }
            let blur5 = float01ToNSImage(image: image)
            for _ in 0..<10 {
                image = image.convoluted(Filter.gaussian3x3)
            }
            let blur15 = float01ToNSImage(image: image)
            
            print("break here")
        }
        do {
            let sobelH = float01ToNSImage(image: imageBase.convoluted(Filter.sobel3x3H))
            let sobelV = float01ToNSImage(image: imageBase.convoluted(Filter.sobel3x3V))
            let laplacian = float01ToNSImage(image: imageBase.convoluted(Filter.laplacian3x3))
            
            print("break here")
        }
        do {
            let maximum = float01ToNSImage(image: imageBase.maximumFilter(kernelSize: 5))
            let minimum = float01ToNSImage(image: imageBase.minimumFilter(kernelSize: 5))
            let median = float01ToNSImage(image: imageBase.medianFilter(kernelSize: 5))
            
            print("break here")
        }
    }
    
    #endif
}

func float01ToNSImage(image: Image<Intensity, Float>) -> NSImage {
    var image = image
    image.clip(low: 0, high: 1)
    image *= 255
    let uint = image.typeConverted(to: UInt8.self)
    return uint.toRGB().nsImage()
}
