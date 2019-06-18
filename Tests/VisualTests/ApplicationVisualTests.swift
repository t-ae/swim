import XCTest
import Swim

class ApplicationVisualTests: XCTestCase {
}

#if canImport(AppKit)

extension ApplicationVisualTests {
    func testOpenClose() {
        let size = 100
        var image = Image<Gray, Double>(width: size, height: size, value: 0)
        
        // base
        image.drawRect(30..<70, 30..<70, color: Color(gray: 1))
        image.drawRect(10..<90, 40..<45, color: Color(gray: 1))
        image.drawRect(10..<90, 55..<60, color: Color(gray: 1))
        
        // noise
        image.drawRect(40..<43, 27..<30, color: Color(gray: 1))
        image.drawRect(40..<43, 67..<70, color: Color(gray: 0))
        image.drawRect(20..<22, 35..<40, color: Color(gray: 1))
        image.drawRect(20..<22, 55..<60, color: Color(gray: 0))
        
        let nsImage = doubleToNSImage(image)
        
        let close = image.rankFilter(.maximum, windowSize: 3)
            .rankFilter(.maximum, windowSize: 3)
            .rankFilter(.minimum, windowSize: 3)
            .rankFilter(.minimum, windowSize: 3)
        let open = image.rankFilter(.minimum, windowSize: 3)
            .rankFilter(.minimum, windowSize: 3)
            .rankFilter(.maximum, windowSize: 3)
            .rankFilter(.maximum, windowSize: 3)
        let closeOpen = close.rankFilter(.minimum, windowSize: 3)
            .rankFilter(.minimum, windowSize: 3)
            .rankFilter(.maximum, windowSize: 3)
            .rankFilter(.maximum, windowSize: 3)
        
        let nsClose = doubleToNSImage(close)
        let nsOpen = doubleToNSImage(open)
        let nsCloseOpen = doubleToNSImage(closeOpen)
        
        let nsBlackhat = doubleToNSImage(close - image)
        let nsTopHat = doubleToNSImage(image - open)
        
        XCTAssertFalse([nsImage, nsClose, nsOpen, nsCloseOpen, nsBlackhat, nsTopHat].isEmpty,
                       "Break and check nsImage in debugger.")
    }
    
    func testJulia() {
        
        let c = (-0.74543, 0.11301)
        
        let size = 256
        let range: Double = 3.2
        let maxIteration = 256
        
        func getJuliaImage(c: (Double, Double), color: Color<RGB, Double>) -> Image<RGBA, Double> {
            var iterationMax = 0
            let alpha = Image<Gray, Double>.createWithUnsafePixelRef(width: size, height: size) { ref in
                var z: (Double, Double) = ((Double(ref.x)/Double(size) - 0.5)*range,
                                           (Double(ref.y)/Double(size) - 0.5)*range)
                for n in 0..<maxIteration*2 {
                    let zr = z.0*z.0 - z.1*z.1 + c.0
                    let zi = 2*z.0*z.1 + c.1
                    z = (zr, zi)
                    if z.0*z.0 + z.1*z.1 > 2*2 {
                        ref[.gray] = Double(n)
                        iterationMax = max(iterationMax, n)
                        return
                    }
                }
                ref[.gray] = 0
            }
            
            return Image(rgb: Image(width: size, height: size, color: color),
                         a: alpha / Double(iterationMax))
        }
        
        
        let julia1 = getJuliaImage(c: (-0.6180339887498949, 0), color: Color(r: 1, g: 0, b: 0))
        let ns1 = doubleToNSImage(julia1)

        let julia2 = getJuliaImage(c: (0.285, 0), color: Color(r: 0, g: 1, b: 0))
        let ns2 = doubleToNSImage(julia2)

        let julia3 = getJuliaImage(c: (0.285, 0.01), color: Color(r: 0, g: 0, b: 1))
        let ns3 = doubleToNSImage(julia3)

        let julia4 = getJuliaImage(c: (-0.70176, -0.3842), color: Color(r: 0.7, g: 0.7, b: 0))
        let ns4 = doubleToNSImage(julia4)

        let julia5 = getJuliaImage(c: (-0.835, 0.2321), color: Color(r: 1, g: 0, b: 1))
        let ns5 = doubleToNSImage(julia5)

        let julia6 = getJuliaImage(c: (-0.8, 0.156), color: Color(r: 0, g: 1, b: 1))
        let ns6 = doubleToNSImage(julia6)
        
        let julia7 = getJuliaImage(c: (-0.75, 0.13), color: Color(r: 0, g: 0.4, b: 0))
        var base = Image<RGB, Double>(width: size, height: size, value: 0.95)
        
        base.drawImage(origin: (0, 0), image: julia7)
        let ns7 = doubleToNSImage(julia7)
        
        XCTAssertFalse([ns1, ns2, ns3, ns4, ns5, ns6, ns7].isEmpty,
                       "Break and check nsImage in debugger.")
    }
    
    public func testPerlinNoise() {
        func c(_ v: Double) -> Double {
            return (1 - 3*v*v + 2*v*v*abs(v))
        }
        
        func perlin(width: Int, height: Int, fieldSize: Int) -> Image<Gray, Double> {
            // gradX: .gray, gradY: .alpha
            let grads = Image<GrayAlpha, Double>.createWithUnsafeMutableBufferPointer(width: fieldSize, height: fieldSize) { bp in
                for i in 0..<bp.count {
                    bp[i] = .random(in: -1..<1)
                }
            }.withPadding(left: 0, right: 1, top: 0, bottom: 1, edgeMode: .wrap)
            
            func value(x: Double, y: Double) -> Double {
                let gs = grads[Rect(x: Int(x), y: Int(y), width: 2, height: 2)]
                
                let u = x - floor(x)
                let v = y - floor(y)
                
                let uv = Image(width: 2, height: 2, grayAlpha: [u, v, u-1, v,
                                                                u, v-1, u-1, v-1])
                let cs = uv.dataConverted(c) // bell
                let gsuv = gs*uv // line
                
                // wavelet values
                let c = cs[channel: .gray] * cs[channel: .alpha]
                let w = c * (gsuv[channel: .gray] + gsuv[channel: .alpha])
                
                // weight sum
                let coef = (1-uv[channel: .gray])*(1-uv[channel: .alpha])
                return (w * coef).withUnsafeBufferPointer { $0.reduce(0, +) }
            }
            
            return Image<Gray, Double>.createWithUnsafePixelRef(width: width, height: height) { ref in
                let px = Double(fieldSize) * Double(ref.x) / Double(width)
                let py = Double(fieldSize) * Double(ref.y) / Double(height)
                ref[.gray] = value(x: px, y: py)
            }
        }
        
        let size = 256
        var image = perlin(width: size, height: size, fieldSize: 2)
        image += perlin(width: size, height: size, fieldSize: 4) / 2
        image += perlin(width: size, height: size, fieldSize: 8) / 4
        image += perlin(width: size, height: size, fieldSize: 16) / 8
        
        // normalize
        image -= image.withUnsafeMutableBufferPointer { $0.min()! }
        image /= image.withUnsafeMutableBufferPointer { $0.max()! }
        
        // repeat
        image = image.repeated(horizontally: 2, vertically: 2)
        
        
        let nsImage = doubleToNSImage(image)
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
    }
    
    public func testLifeGame() {
        func next(_ image: Image<Gray, UInt8>) -> Image<Gray, UInt8> {
            let padded = image.withPadding(1, edgeMode: .zero)
            let matrix = padded.im2col(patchWidth: 3, patchHeight: 3)
            
            var sums = [UInt8](repeating: 0, count: matrix.cols)
            
            for r in 0..<matrix.rows {
                if r == 4 { continue }  // ignore self
                for c in 0..<matrix.cols {
                    sums[c] += matrix[r, c]
                }
            }
            for c in 0..<matrix.cols {
                switch (matrix[4, c], sums[c]) {
                case (0, 3), (1, 2), (1, 3): // born and survive
                    sums[c] = 1
                default:
                    sums[c] = 0
                }
            }
            return Image(width: image.width, height: image.height, data: sums)
        }
        
        // pentadecathlon
        var b0 = Image<Gray, UInt8>(width: 16, height: 16, value: 0)
        b0.drawRect(3..<13, 8..<9, color: Color(gray: 1))
        
        var b = b0
        
        var steps: [NSImage] = []
        for _ in 0..<20 {
            let ns = (b*UInt8.max).resize(width: 256, height: 256).nsImage()
            steps.append(ns)
            b = next(b)
        }
        
        XCTAssertFalse(steps.isEmpty, "Break and check nsImage in debugger.")
    }
    
    func testCannyEdgeDetection() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        let lena = try! Image<Gray, Double>(contentsOf: path)
        
        var images: [Image<Gray, Double>] = [lena]
        
        // Gaussian Blur
        let smooth = lena.convoluted(Filter.gaussian5x5)
        images.append(smooth)
        
        // Determine the Gray Gradients
        let gradV = smooth.convoluted(Filter.sobel3x3V)
        let gradH = smooth.convoluted(Filter.sobel3x3H)
        images.append(gradV)
        images.append(gradH)
        
        var grad = Image.zeros(like: lena)
        var dir = Image.zeros(like: lena) // 0, 1, 2, 3 for -pi/2, -pi4, 0, pi/4
        
        for y in 0..<lena.width {
            for x in 0..<lena.height {
                grad[x, y, 0] = hypot(gradV[x, y, 0], gradH[x, y, 0])
                var angle = atan2(gradH[x, y, 0], gradV[x, y, 0]) // -pi ... pi
                if angle < 0 { angle += .pi } // 0...pi
                
                if angle < Double.pi/8 {
                    dir[x, y, 0] = 2
                } else if angle < 3 * Double.pi / 8 {
                    dir[x, y, 0] = 3
                } else if angle < 5 * Double.pi / 8 {
                    dir[x, y, 0] = 0
                } else if angle < 7 * Double.pi / 8 {
                    dir[x, y, 0] = 1
                } else {
                    dir[x, y, 0] = 2
                }
            }
        }
        images.append(grad)
        images.append(dir / 3)
        
        // Non Maximum Suppression
        var sharpen = grad
        for y in 1..<lena.width-1 {
            for x in 1..<lena.height-1 {
                switch dir[x, y, 0] {
                case 0: // -pi/2
                    if grad[x, y, 0] < grad[x-1, y, 0] || grad[x, y, 0] < grad[x+1, y, 0] {
                        sharpen[x, y, 0] = 0
                    }
                case 1: // -pi/4
                    if grad[x, y, 0] < grad[x-1, y-1, 0] || grad[x, y, 0] < grad[x+1, y+1, 0] {
                        sharpen[x, y, 0] = 0
                    }
                case 2: // 0
                    if grad[x, y, 0] < grad[x, y-1, 0] || grad[x, y, 0] < grad[x, y+1, 0] {
                        sharpen[x, y, 0] = 0
                    }
                case 3: // pi/4
                    if grad[x, y, 0] < grad[x-1, y+1, 0] || grad[x, y, 0] < grad[x+1, y-1, 0] {
                        sharpen[x, y, 0] = 0
                    }
                default:
                    fatalError()
                }
            }
        }
        sharpen.drawRectPelimeter(origin: (0, 0),
                                  size: (sharpen.width, sharpen.height),
                                  color: Color(gray: 0))
        images.append(sharpen)
        
        // Double Thresholding
        let ht = 0.3
        let lt = 0.2
        let high: Image<Gray, Double> = sharpen.dataConverted { $0 < ht ? 0 : 1 }
        let low: Image<Gray, Double> = sharpen.dataConverted { $0 < lt ? 0 : 1 }
        images.append(high)
        images.append(low)
        
        // Edge Tracking
        var edge = Image.zeros(like: lena)
        func track(x: Int, y: Int) {
            guard 0 <= x && x < edge.width && 0 <= y && y < edge.height else {
                return
            }
            guard low[x, y, 0] == 1 && edge[x, y, 0] == 0 else {
                return
            }
            edge[x, y, 0] = 1
            track(x: x-1, y: y-1)
            track(x: x+0, y: y-1)
            track(x: x+1, y: y-1)
            track(x: x-1, y: y+0)
            track(x: x+1, y: y+0)
            track(x: x-1, y: y+1)
            track(x: x+0, y: y+1)
            track(x: x+1, y: y+1)
        }
        for y in 1..<lena.width-1 {
            for x in 1..<lena.height-1 {
                if high[x, y, 0] == 1 {
                    track(x: x, y: y)
                }
            }
        }
        images.append(edge)
        
        // result
        let ns = doubleToNSImage(Image.concat([Array(images[..<5]), Array(images[5...])]))
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func testTemplateMatching() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        let lena = try! Image<Gray, Double>(contentsOf: path)
        
        let size = 32
        let templatePosition = (x: 127, y: 135)
        var template = lena[Rect(x: templatePosition.x, y: templatePosition.y, width: size, height: size)]
        
        template.applyPow(2)
        
        print("Full search")
        time {
            var maxc = -Double.infinity
            var maxPosition = (x: -1, y: -1)
            for y in 0..<lena.height-size {
                for x in 0..<lena.width-size {
                    let patch = lena[Rect(x: x, y: y, width: size, height: size)]
                    let c = ImageCompare.zncc(patch, template)
                    if c > maxc {
                        maxc = c
                        maxPosition = (x, y)
                    }
                }
            }
            
            XCTAssertEqual(maxPosition.x, templatePosition.x)
            XCTAssertEqual(maxPosition.y, templatePosition.y)
        }
        
        print("Coarse-to-fine search")
        time {
            let minTemplateSize = 8
            func search(image: Image<Gray, Double>,
                        template: Image<Gray, Double>) -> (x: Int, y: Int) {
                let imagePOT = image.width % 2 == 0 && image.height % 2 == 0
                let templatePOT = template.width % 2 == 0 && template.height % 2 == 0
                let shouldDownscale = template.width > minTemplateSize && template.height > minTemplateSize
                
                let searchRangeX: Range<Int>
                let searchRangeY: Range<Int>
                if imagePOT && templatePOT && shouldDownscale {
                    let imageHalf = image.resize(width: image.width/2, height: image.height/2, method: .areaAverage)
                    let templateHalf = template.resize(width: template.width/2, height: template.height/2, method: .areaAverage)
                    
                    let (x, y) = search(image: imageHalf, template: templateHalf)
                    searchRangeX = 2*x-1..<2*x+2
                    searchRangeY = 2*y-1..<2*y+2
                } else {
                    // Full search
                    searchRangeX = 0..<image.width - template.width
                    searchRangeY = 0..<image.height - template.height
                }
                
                var maxc = -Double.infinity
                var maxPosition = (x: -1, y: -1)
                for y in searchRangeY {
                    for x in searchRangeX {
                        let patch = image[Rect(x: x, y: y, width: template.width, height: template.height)]
                        let c = ImageCompare.zncc(patch, template)
                        if c > maxc {
                            maxc = c
                            maxPosition = (x, y)
                        }
                    }
                }
                
                return maxPosition
            }
            
            let maxPosition = search(image: lena, template: template)
            
            XCTAssertEqual(maxPosition.x, templatePosition.x)
            XCTAssertEqual(maxPosition.y, templatePosition.y)
        }
    }
    
    func testDither() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        let lena = try! Image<Gray, Double>(contentsOf: path)
        var images: [Image<Gray, Double>] = [lena]
        
        let randDither = lena.dataConverted { px -> Double in
            (px < .random(in: 0..<1)) ? 0 : 1
        }
        images.append(randDither)
        
        let matrix = Image(width: 4, height: 4, gray: (0..<16).map { (Double($0)+0.5)/16 }.shuffled())
        let matrixDither = lena.channelwiseConverted { x, y, c, value -> Double in
            let v = matrix[x%4, y%4, .gray]
            return value < v ? 0 : 1
        }
        images.append(matrixDither)
        
        var floydSteinbergDither = lena
        for y in 0..<floydSteinbergDither.height {
            for x in 0..<floydSteinbergDither.width {
                let v = floydSteinbergDither[x, y, .gray]
                let nearest = round(v)
                let diff = v - nearest
                
                floydSteinbergDither[x, y, .gray] = nearest
                
                if x+1 < floydSteinbergDither.width {
                    floydSteinbergDither[x+1, y, .gray] += 7/16 * diff
                }
                if y+1 < floydSteinbergDither.height {
                    if x-1 >= 0 {
                        floydSteinbergDither[x-1, y+1, .gray] += 3/16 * diff
                    }
                    floydSteinbergDither[x+0, y+1, .gray] += 5/16 * diff
                    if x+1 < floydSteinbergDither.width {
                        floydSteinbergDither[x+1, y+1, .gray] += 1/16 * diff
                    }
                }
            }
        }
        images.append(floydSteinbergDither)
        
        // result
        let ns = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func testDenoise() {
        let path = testResoruceRoot().appendingPathComponent("lena_256.png")
        let lena = try! Image<RGB, Double>(contentsOf: path)
        
        var noisy = lena
        for _ in 0..<1000 {
            let x = Int.random(in: 0..<lena.width)
            let y = Int.random(in: 0..<lena.height)
            
            noisy[x, y] = Bool.random() ? Color.white : Color.black
        }
        var images: [Image<RGB, Double>] = [noisy]
        
        print("PSNR(noisy): \(ImageCompare.psnr(lena, noisy))")
        
        let gaussian = noisy.convoluted(Filter.gaussian3x3)
        images.append(gaussian)
        
        print("PSNR(gaussian): \(ImageCompare.psnr(lena, gaussian))")
        
        let median = noisy.rankFilter(.median, windowSize: 3)
        images.append(median)
        
        print("PSNR(median): \(ImageCompare.psnr(lena, median))")
        
        // result
        let ns = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func testColorQuantization() {
        let path = testResoruceRoot().appendingPathComponent("lena_512.png")
        let lena = try! Image<RGB, Double>(contentsOf: path)
        var images: [Image<RGB, Double>] = [lena]
        
        var classImage = Image<Gray, Int>.zeros(like: lena)
        
        let k = 10
        let maxIter = 100
        
        func colorDistance2(px1: Pixel<RGB, Double>, px2: Color<RGB, Double>) -> Double {
            let r = px1[.red] - px2[.red]
            let g = px1[.green] - px2[.green]
            let b = px1[.blue] - px2[.blue]
            
            return r*r + g*g + b*b
        }
        
        // k-means
        var centers = (0..<k).map { _ in
            Color<RGB, Double>(r: .random(in: 0..<1),
                               g: .random(in: 0..<1),
                               b: .random(in: 0..<1))
        }
        
        for iter in 0..<maxIter {
            // Check nearest pixels
            var newClassImage = classImage
            for pixel in lena.pixels() {
                var minDist = Double.infinity
                for (i, c) in centers.enumerated() {
                    let d = colorDistance2(px1: pixel, px2: c)
                    if d < minDist {
                        newClassImage[pixel.x, pixel.y, .gray] = i
                        minDist = d
                    }
                }
            }
            
            if newClassImage == classImage {
                print("Break at iter: \(iter)")
                break
            }
            classImage = newClassImage
            
            // Update center
            var newCenters = [Color<RGB, Double>](repeating: Color.zero, count: centers.count)
            var counts = [Int](repeating: 0, count: centers.count)
            
            for pixel in lena.pixels() {
                let cls = classImage[pixel.x, pixel.y, .gray]
                newCenters[cls] += pixel
                counts[cls] += 1
            }
            
            // mean
            for i in 0..<newCenters.count {
                newCenters[i] /= Double(counts[i])
            }
            
            centers = newCenters
        }
        
        // apply reduction
        let reduced = Image<RGB, Double>.createWithUnsafePixelRef(width: lena.width, height: lena.height) { ref in
            let cls = classImage[ref.x, ref.y, .gray]
            ref.setColor(color: centers[cls])
        }
        images.append(reduced)
        
        // result
        let ns = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(ns.isValid, "break here")
    }
}

#endif
