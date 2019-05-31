import XCTest
import Swim

class HistogramsVisualTests: XCTestCase {
}

#if canImport(AppKit)

extension HistogramsVisualTests {
    func createHistogramImage<T: BinaryInteger>(image: Image<Gray, T>) -> Image<Gray, T> {
        let bins = Histograms.histogram(of: image)
        let maximum = bins.max()!
        
        var hist = Image<Gray, T>(width: 256, height: 256, value: 0)
        
        for i in 0..<256 {
            let height = Int(255 * Double(bins[i]) / Double(maximum))
            hist.drawLine(p1: (i, 255 - height), p2: (i, 255), color: .white)
        }
        
        return hist.resize(width: image.width, height: image.height)
    }
    
    func testHistogramEqualizer() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        var lena = try! Image<Gray, UInt8>(contentsOf: path)
        lena.dataConvert { UInt8(pow(Double($0), 2) / 255) }
        
        var images = [Image<Gray, UInt8>]()
        images.append(lena)
        images.append(createHistogramImage(image: lena))
        
        var eq = lena
        Histograms.equalize(image: &eq)
        images.append(eq)
        images.append(createHistogramImage(image: eq))
        
        let image = Image.concatH(images)
        let ns = image.nsImage()
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func testHistogramEqualizerInt() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        var lena_uint8 = try! Image<Gray, UInt8>(contentsOf: path)
        lena_uint8.dataConvert { UInt8(pow(Double($0), 2) / 255) }
        let lena = lena_uint8.cast(to: Int.self)
        
        var images = [Image<Gray, Int>]()
        images.append(lena)
        images.append(createHistogramImage(image: lena))
        
        var eq = lena
        Histograms.equalize(image: &eq)
        images.append(eq)
        images.append(createHistogramImage(image: eq))
        
        let image = Image.concatH(images)
        let ns = image.cast(to: UInt8.self).nsImage()
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func createColorHistogramImage<T: BinaryInteger>(image: Image<RGB, T>) -> Image<RGB, T> {
        let bins = (0..<RGB.channels).map { Histograms.histogram(of: image[channel: $0]) }
        let maximum = bins.map { $0.max()! }.max()!
        
        var hist = Image<RGB, T>(width: 256, height: 256, value: 0)
        
        for c in 0..<RGB.channels {
            let bins = bins[c]
            var ch = Image<RGBA, T>.zeros(like: hist)
            var color = Color<RGBA, T>(data: [0, 0, 0, 128])
            color[c] = 255
            
            for i in 0..<256 {
                let height = Int(255 * Double(bins[i]) / Double(maximum))
                ch.drawLine(p1: (i, 255 - height), p2: (i, 255), color: color)
            }
            
            hist.drawImage(origin: (0, 0), image: ch)
        }
        
        return hist.resize(width: image.width, height: image.height)
    }
    
    func testHistogramEqualizerColor() {
        let path = testResoruceRoot().appendingPathComponent("lena_512.png")
        var lena = try! Image<RGB, UInt8>(contentsOf: path)
        lena.dataConvert { UInt8(pow(Double($0), 2) / 255) }
        
        var images = [Image<RGB, UInt8>]()
        images.append(lena)
        images.append(createColorHistogramImage(image: lena))
        
        // each channel
        var eq1 = lena
        Histograms.equalize(image: &eq1[channel: .red])
        Histograms.equalize(image: &eq1[channel: .green])
        Histograms.equalize(image: &eq1[channel: .blue])
        images.append(eq1)
        images.append(createColorHistogramImage(image: eq1))
        
        // three color histogram
        var eq2 = lena
        Histograms.equalize(image: &eq2)
        images.append(eq2)
        images.append(createColorHistogramImage(image: eq2))
        
        let image = Image.concatH(images)
        let ns = image.nsImage()
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func testHistogramEqualizerDouble() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        var lena = try! Image<RGB, Double>(contentsOf: path)
        lena.applyPow(0.5)
        
        var eq = lena
        Histograms.equalize(image: &eq, numBins: 100)
        
        let image = Image.concatH([lena, eq])
        let ns = doubleToNSImage(image)
        
        XCTAssertTrue(ns.isValid, "break here")
    }
}

#endif
