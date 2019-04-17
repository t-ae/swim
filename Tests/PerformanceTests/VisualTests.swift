import XCTest
import Swim

// Set brakepoints and look NSImages in Xcode debugger

class VisualTests: XCTestCase {
    #if !DEBUG && os(macOS)
    
    func testAlphaBlend() {
        var imageBase = Image<RGB, Double>(width: 500,
                                           height: 500,
                                           value: 1)
        
        let red = Shape.circle(size: 200,
                               lineWidth: 3,
                               lineColor: Pixel(r: 1.0, g: 0.0, b: 0.0, a: 1.0),
                               fillColor: Pixel(r: 1.0, g: 0.0, b: 0.0, a: 0.5))
        let green = Shape.circle(size: 200,
                                 lineWidth: 3,
                                 lineColor: Pixel(r: 0.0, g: 1.0, b: 0.0, a: 1.0),
                                 fillColor: Pixel(r: 0.0, g: 1.0, b: 0.0, a: 0.5))
        let blue = Shape.circle(size: 200,
                                lineWidth: 3,
                                lineColor: Pixel(r: 0.0, g: 0.0, b: 1.0, a: 1.0),
                                fillColor: Pixel(r: 0.0, g: 0.0, b: 1.0, a: 0.5))
        
        
        imageBase[150..<350, 100..<300].alphaBlend(with: red)
        imageBase[100..<300, 200..<400].alphaBlend(with: green)
        imageBase[200..<400, 200..<400].alphaBlend(with: blue)
        
        let rgb256 = (imageBase * 255).typeConverted(to: UInt8.self)
        let nsImage = rgb256.nsImage()
        
        print("break here")
        
        _ = nsImage
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
        _ = nsImageBase
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
            
            _ = [blur1, blur5, blur15]
        }
        do {
            let sobelH = float01ToNSImage(image: imageBase.convoluted(Filter.sobel3x3H))
            let sobelV = float01ToNSImage(image: imageBase.convoluted(Filter.sobel3x3V))
            let laplacian = float01ToNSImage(image: imageBase.convoluted(Filter.laplacian3x3))
            
            print("break here")
            
            _ = [sobelH, sobelV, laplacian]
        }
        do {
            let maximum = float01ToNSImage(image: imageBase.maximumFilter(kernelSize: 5))
            let minimum = float01ToNSImage(image: imageBase.minimumFilter(kernelSize: 5))
            let median = float01ToNSImage(image: imageBase.medianFilter(kernelSize: 5))
            
            print("break here")
            
            _ = [maximum, minimum, median]
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
        
        _ = [nsImage, nsClose, nsOpen, nsCloseOpen, nsBlackhat, nsTopHat]
    }
    
    func testJulia() {
        
        let c = (-0.74543, 0.11301)
        
        let size = 256
        let range: Double = 3.2
        let maxIteration = 256
        
        func getJuliaImage(c: (Double, Double), color: Pixel<RGB, Double>) -> Image<RGBA, Double> {
            let color = Pixel(rgba: color.data + [0])
            var image = Image<RGBA, Double>(width: size,
                                            height: size,
                                            pixel: color)
            
            var iterationMax = 0
            
            for y in 0..<size {
                for x in 0..<size {
                    var z: (Double, Double) = ((Double(x)/Double(size) - 0.5)*range,
                                               (Double(y)/Double(size) - 0.5)*range)
                    
                    for n in 0..<maxIteration*2 {
                        let zr = z.0*z.0 - z.1*z.1 + c.0
                        let zi = 2*z.0*z.1 + c.1
                        z = (zr, zi)
                        if z.0*z.0 + z.1*z.1 > 2*2 {
                            image[x, y, 3] = Double(n)
                            iterationMax = max(iterationMax, n)
                            break
                        }
                    }
                }
            }
            
            image[channel: .alpha] /= Double(iterationMax)
            
            return image
        }
        
        
        let julia1 = getJuliaImage(c: (-0.6180339887498949, 0), color: Pixel(r: 1, g: 0, b: 0))
        let ns1 = (julia1*255).typeConverted(to: UInt8.self).nsImage()

        let julia2 = getJuliaImage(c: (0.285, 0), color: Pixel(r: 0, g: 1, b: 0))
        let ns2 = (julia2*255).typeConverted(to: UInt8.self).nsImage()

        let julia3 = getJuliaImage(c: (0.285, 0.01), color: Pixel(r: 0, g: 0, b: 1))
        let ns3 = (julia3*255).typeConverted(to: UInt8.self).nsImage()

        let julia4 = getJuliaImage(c: (-0.70176, -0.3842), color: Pixel(r: 0.7, g: 0.7, b: 0))
        let ns4 = (julia4*255).typeConverted(to: UInt8.self).nsImage()

        let julia5 = getJuliaImage(c: (-0.835, 0.2321), color: Pixel(r: 1, g: 0, b: 1))
        let ns5 = (julia5*255).typeConverted(to: UInt8.self).nsImage()

        let julia6 = getJuliaImage(c: (-0.8, 0.156), color: Pixel(r: 0, g: 1, b: 1))
        let ns6 = (julia6*255).typeConverted(to: UInt8.self).nsImage()
        
        let julia7 = getJuliaImage(c: (-0.75, 0.13), color: Pixel(r: 0, g: 0.4, b: 0))
        var base = Image<RGB, Double>(width: size, height: size, value: 0.95)
        base.alphaBlend(with: julia7)
        let ns7 = (base*255).typeConverted(to: UInt8.self).nsImage()
        
        print("break here")
        
        _ = [ns1, ns2, ns3, ns4, ns5, ns6, ns7]
    }
    
    public func testLifeGame() {
        
        func next(_ image: Image<Intensity, UInt8>) -> Image<Intensity, UInt8> {
            let (m, n, matrix) = image.im2col(patchWidth: 3, patchHeight: 3, padding: Padding.zero)
            // m == 9
            var sums = [UInt8](repeating: 0, count: n)
            
            for i in 0..<m {
                if i == 4 { continue }  // ignore self
                for j in 0..<n {
                    sums[j] += matrix[i*n+j]
                }
            }
            for j in 0..<n {
                switch (matrix[4*n+j], sums[j]) {
                case (0, 3), (1, 2), (1, 3): // born and survive
                    sums[j] = 1
                default:
                    sums[j] = 0
                }
            }
            return Image(width: image.width, height: image.height, data: sums)
        }
        
        // pentadecathlon
        let b0 = Image(width: 16,
                       height: 16,
                       intensity: [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                   0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0,
                                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                   0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0] as [UInt8])
        
        var b = b0
        
        var steps: [NSImage] = []
        for _ in 0..<20 {
            let ns = (b*255).resizeNN(width: 128, height: 128).toRGB().nsImage()
            steps.append(ns)
            b = next(b)
        }
        print("break here")
        _ = steps
    }
    
    func testWarpAffine() {
        
        var baseImage = Image<RGB, Float>(width: 256, height: 256, value: 0)
        for y in 0..<16 {
            for x in 0..<16 {
                guard (x + y) % 2 == 0 else {
                    continue
                }
                baseImage[x*16..<(x+1)*16, y*16..<(y+1)*16].fill(Pixel(r: 1, g: 1, b: 1))
            }
        }
        
        let src = Image<RGB, Float>(width: 4,
                                    height: 4,
                                    data: (0..<4*4*3).map { _ in Float.random(in: 0..<1) })
        
        let t0 = AffineTransformation<Float>.scale(x: 16, y: 16)
        src.warpAffine(baseImage: &baseImage, transformation: t0, interpolation: .nearestNeighbor)
        
        var t1 = AffineTransformation<Float>.translate(x: 32, y: 32)
        t1 *= AffineTransformation.rotate(angle: Float.pi/4)
        t1 *= AffineTransformation<Float>.scale(x: 30, y: 30)
        src.warpAffine(baseImage: &baseImage, transformation: t1, interpolation: .bicubic)
        
        var t2 = AffineTransformation<Float>.translate(x: 80, y: 32)
        t2 *= AffineTransformation.rotate(angle: Float.pi/8)
        t2 *= AffineTransformation<Float>.scale(x: 10, y: 15)
        src.warpAffine(baseImage: &baseImage, transformation: t2, interpolation: .nearestNeighbor)
        
        var t3 = AffineTransformation<Float>.translate(x: 192, y: 192)
        t3 *= AffineTransformation.rotate(angle: Float.pi/2)
        t3 *= AffineTransformation<Float>.scale(x: 10, y: 10)
        t3 *= AffineTransformation<Float>.translate(x: -1, y: -1)
        src.warpAffine(baseImage: &baseImage, transformation: t3)
        
        let rgb256 = (baseImage * 255).typeConverted(to: UInt8.self)
        let nsImage = rgb256.nsImage()
        
        print("break here")
        _ = nsImage
    }
    
    func testResize() {
        do {
            let image = Image<RGB, Float>(width: 4,
                                          height: 4,
                                          data: (0..<4*4*3).map { _ in Float.random(in: 0..<1) })
            
            let resizedNN = image.resizeNN(width: 128, height: 128)
            let resizedBL = image.resizeBL(width: 128, height: 128)
            let resizedBC = image.resizeBC(width: 128, height: 128)
            
            let concat = Image<RGB, Float>.concatH([resizedNN, resizedBL, resizedBC])
            
            let rgb256 = (concat * 255).typeConverted(to: UInt8.self)
            let nsImage = rgb256.nsImage()
            
            print("break here")
            _ = nsImage
        }
        do {
            let image = Shape.circle(size: 32, lineWidth: 3, lineColor: Pixel(r: 1.0, g: 0, b: 0))
            let resizedNN = image.resizeNN(width: 128, height: 128)
            let resizedBL = image.resizeBL(width: 128, height: 128)
            let resizedBC = image.resizeBC(width: 128, height: 128)
            
            let concat = Image<RGB, Double>.concatH([resizedNN, resizedBL, resizedBC])
            
            let rgb256 = (concat * 255).typeConverted(to: UInt8.self)
            let nsImage = rgb256.nsImage()
            
            print("break here")
            _ = nsImage
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
