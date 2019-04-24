import XCTest
import Swim

class OtherVisualTests: XCTestCase {
}

#if canImport(AppKit)

extension OtherVisualTests {
    func testOpenClose() {
        let size = 100
        var image = Image<Intensity, Double>(width: size, height: size, value: 0)
        
        // base
        image[30..<70, 30..<70].fill(1)
        image[10..<90, 40..<45].fill(1)
        image[10..<90, 55..<60].fill(1)
        // noise
        image[40..<43, 27..<30].fill(1)
        image[40..<43, 67..<70].fill(0)
        image[20..<22, 35..<40].fill(1)
        image[20..<22, 55..<60].fill(0)
        
        let nsImage = doubleToNSImage(image)
        
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
        
        func getJuliaImage(c: (Double, Double), color: Pixel<RGB, Double>) -> Image<RGBA, Double> {
            let color = Pixel(r: color[.red], g: color[.green], b: color[.blue], a: 0)
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
        let ns1 = doubleToNSImage(julia1)

        let julia2 = getJuliaImage(c: (0.285, 0), color: Pixel(r: 0, g: 1, b: 0))
        let ns2 = doubleToNSImage(julia2)

        let julia3 = getJuliaImage(c: (0.285, 0.01), color: Pixel(r: 0, g: 0, b: 1))
        let ns3 = doubleToNSImage(julia3)

        let julia4 = getJuliaImage(c: (-0.70176, -0.3842), color: Pixel(r: 0.7, g: 0.7, b: 0))
        let ns4 = doubleToNSImage(julia4)

        let julia5 = getJuliaImage(c: (-0.835, 0.2321), color: Pixel(r: 1, g: 0, b: 1))
        let ns5 = doubleToNSImage(julia5)

        let julia6 = getJuliaImage(c: (-0.8, 0.156), color: Pixel(r: 0, g: 1, b: 1))
        let ns6 = doubleToNSImage(julia6)
        
        let julia7 = getJuliaImage(c: (-0.75, 0.13), color: Pixel(r: 0, g: 0.4, b: 0))
        var base = Image<RGB, Double>(width: size, height: size, value: 0.95)
        
        Blender.alphaBlend(top: julia7, bottom: &base)
        let ns7 = doubleToNSImage(julia7)
        
        XCTAssertFalse([ns1, ns2, ns3, ns4, ns5, ns6, ns7].isEmpty,
                       "Break and check nsImage in debugger.")
    }
    
    public func testPerlinNoise() {
        func c(_ v: Double) -> Double {
            return (1 - 3*v*v + 2*v*v*abs(v))
        }
        
        func perlin(width: Int, height: Int, fieldSize: Int) -> Image<Intensity, Double> {
            var grad = [[(x: Double, y: Double)]](repeating: [], count: fieldSize+1)
            for i in 0..<fieldSize+1 {
                for j in 0..<fieldSize + 1 {
                    let gx = Double.random(in: -1..<1)
                    let gy = Double.random(in: -1..<1)
                    grad[i].append((gx, gy))
                }
            }
            
            func value(x: Double, y: Double) -> Double {
                let g00 = grad[Int(y)][Int(x)]
                let g01 = grad[Int(y)][Int(x)+1]
                let g10 = grad[Int(y)+1][Int(x)]
                let g11 = grad[Int(y)+1][Int(x)+1]
                
                let u = x - floor(x)
                let v = y - floor(y)
                
                let w00 = c(u) * c(v) * (g00.x * u + g00.y * v)
                let w01 = c(u-1) * c(v) * (g01.x * (u-1) + g01.y * v)
                let w10 = c(u) * c(v-1) * (g10.x * u + g10.y * (v-1))
                let w11 = c(u-1) * c(v-1) * (g11.x * (u-1) + g11.y * (v-1))
                
                let w0 = w00 - u * (w00 - w01)
                let w1 = w10 - u * (w10 - w11)
                
                return w0 - v * (w0 - w1)
            }
            
            var image = Image<Intensity, Double>(width: 512, height: 512, value: 0)
            image.pixelwiseConvert { ref in
                let px = Double(fieldSize) * Double(ref.x) / Double(width)
                let py = Double(fieldSize) * Double(ref.y) / Double(height)
                ref[0] = value(x: px, y: py)
            }
            
            return image
        }
        
        var image = perlin(width: 512, height: 512, fieldSize: 2)
        image += perlin(width: 512, height: 512, fieldSize: 4)
        image += perlin(width: 512, height: 512, fieldSize: 8)
        image += perlin(width: 512, height: 512, fieldSize: 16)
        
        // normalize
        image -= image.withUnsafeMutableBufferPointer { $0.min()! }
        image /= image.withUnsafeMutableBufferPointer { $0.max()! }
        
        let nsImage = doubleToNSImage(image)
        XCTAssertTrue(nsImage.isValid, "Break and check nsImage in debugger.")
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
        var b0 = Image<Intensity, UInt8>(width: 16, height: 16, value: 0)
        b0[3..<13, 8..<9].fill(1)
        
        var b = b0
        
        var steps: [NSImage] = []
        for _ in 0..<20 {
            var bd = Image(cast: b, to: Double.self)
            bd = bd.resize(width: 128, height: 128, method: .nearestNeighbor)
            let ns = doubleToNSImage(bd)
            steps.append(ns)
            b = next(b)
        }
        
        XCTAssertFalse(steps.isEmpty, "Break and check nsImage in debugger.")
    }
}

#endif
