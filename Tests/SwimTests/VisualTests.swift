
import XCTest
import Swim

// Set brakepoints and look NSImages in Xcode debugger

class VisualTests: XCTestCase {
    #if !SWIFT_PACKAGE && os(macOS)
    
    func testAlphaBlend() {
        var imageBase = Image<RGB, Float>(width: 100,
                                          height: 100,
                                          value: 1)
        imageBase[30..<70, 20..<60].fill(Pixel(r: 1, g: 0, b: 0))
        
        var imageGreen = Image<RGBA, Float>(width: 100,
                                            height: 100,
                                            value: 0)
        imageGreen[20..<60, 40..<80].fill(Pixel(r: 0, g: 1, b: 0, a: 0.5))
        
        var imageBlue = Image<RGBA, Float>(width: 100, height: 100, value: 0)
        imageBlue[40..<80, 40..<80].fill(Pixel(r: 0, g: 0, b: 1, a: 0.5))
        
        imageBase.alphaBlend(with: imageGreen)
        imageBase.alphaBlend(with: imageBlue)
        
        let rgb256 = (imageBase * 255).typeConverted(to: UInt8.self)
        let nsImage = rgb256.nsImage()
        
        print("break here")
    }
    
    func testFilter() {
        let size = 128
        var imageBase = Image<Intensity, Float>(width: size, height: size, value: 1)
        for y in 0..<8 {
            for x in 0..<8 {
                guard (x+y) % 2 == 0 else { continue }
                let startX = x*size/8
                let endX = startX + size/8
                let startY = y*size/8
                let endY = startY + size/8
                let value = Float(y*8+x) / 64
                imageBase[startX..<endX, startY..<endY].fill(value)
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
    
    func testOpenClose() {
        let size = 100
        var image = Image<Intensity, Float>(width: size, height: size, value: 0)
        
        // base
        image[30..<70, 30..<70].fill(1)
        image[10..<90, 40..<45].fill(1)
        image[10..<90, 55..<60].fill(1)
        // noise
        image[40..<43, 27..<30].fill(1)
        image[40..<43, 67..<70].fill(0)
        image[20..<22, 35..<40].fill(1)
        image[20..<22, 55..<60].fill(0)
        
        let nsImage = float01ToNSImage(image: image)
        
        let close = image.maximumFilter(kernelSize: 3)
            .maximumFilter(kernelSize: 3)
            .minimumFilter(kernelSize: 3)
            .minimumFilter(kernelSize: 3)
        let open = image.minimumFilter(kernelSize: 3)
            .minimumFilter(kernelSize: 3)
            .maximumFilter(kernelSize: 3)
            .maximumFilter(kernelSize: 3)
        let closeOpen = close.minimumFilter(kernelSize: 3)
            .minimumFilter(kernelSize: 3)
            .maximumFilter(kernelSize: 3)
            .maximumFilter(kernelSize: 3)
        
        let nsClose = float01ToNSImage(image: close)
        let nsOpen = float01ToNSImage(image: open)
        let nsCloseOpen = float01ToNSImage(image: closeOpen)
        
        let nsBlackhat = float01ToNSImage(image: close - image)
        let nsTopHat = float01ToNSImage(image: image - open)
        
        print("break here")
    }
    
    func testJulia() {
        
        let c = (-0.74543, 0.11301)
        
        let size = 256
        let range: Double = 2.5
        let maxIteration = 256
        
        func getJuliaImage(c: (Double, Double), color: Pixel<RGBA, Double>) -> Image<RGBA, Double> {
            var image = Image<RGBA, Double>(width: size,
                                            height: size,
                                            pixel: color)
            
            var iterationMax = 0
            
            for y in 0..<size {
                for x in 0..<size {
                    var z: (Double, Double) = ((Double(x)/Double(size) - 0.5)*range,
                                               (Double(y)/Double(size) - 0.5)*range)
                    
                    for n in 0..<maxIteration {
                        let zr = z.0*z.0 - z.1*z.1 + c.0
                        let zi = 2*z.0*z.1 + c.1
                        z = (zr, zi)
                        if z.0*z.0 + z.1*z.1 > 2*2 {
                            image[x, y, 3] = Double(n)
                            iterationMax = max(iterationMax, n)
                            break
                        }
                        if n == maxIteration - 1 {
                            image[x, y, 3] = 0
                        }
                    }
                }
            }
            
            image[channel: .alpha] /= Double(iterationMax)
            
            return image
        }
        
        
        let julia1 = getJuliaImage(c: (-0.6180339887498949, 0), color: Pixel(r: 1, g: 0, b: 0, a: 0))
        let ns1 = (julia1*255).typeConverted(to: UInt8.self).nsImage()
        
        let julia2 = getJuliaImage(c: (0.285, 0), color: Pixel(r: 0, g: 1, b: 0, a: 0))
        let ns2 = (julia2*255).typeConverted(to: UInt8.self).nsImage()
        
        let julia3 = getJuliaImage(c: (0.285, 0.01), color: Pixel(r: 0, g: 0, b: 1, a: 0))
        let ns3 = (julia3*255).typeConverted(to: UInt8.self).nsImage()
        
        let julia4 = getJuliaImage(c: (-0.70176, -0.3842), color: Pixel(r: 0.7, g: 0.7, b: 0, a: 0))
        let ns4 = (julia4*255).typeConverted(to: UInt8.self).nsImage()
        
        let julia5 = getJuliaImage(c: (-0.835, 0.2321), color: Pixel(r: 1, g: 0, b: 1, a: 0))
        let ns5 = (julia5*255).typeConverted(to: UInt8.self).nsImage()
        
        let julia6 = getJuliaImage(c: (-0.8, 0.156), color: Pixel(r: 0, g: 1, b: 1, a: 0))
        let ns6 = (julia6*255).typeConverted(to: UInt8.self).nsImage()
        
        print("break here")
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
