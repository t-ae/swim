import XCTest
import Swim

class HistogramsVisualTests: XCTestCase {
}

#if canImport(AppKit)

extension HistogramsVisualTests {
    func createHistogramImage<P: NoAlpha, T: BinaryInteger>(image: Image<P, T>) -> Image<P, T> {
        let bins = Histograms.histogram(of: image)
        let maximum = bins.max()!
        
        var hist = Image<P, T>(width: 256, height: 256, value: 0)
        
        for i in 0..<256 {
            let height = Int(255 * Double(bins[i]) / Double(maximum))
            hist.drawLine(p1: (i, 255 - height), p2: (i, 255), color: Color<P, T>(value: 255))
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
    
    func testHistogramEqualizerColor() {
        let path = testResoruceRoot().appendingPathComponent("lena_512.png")
        var lena = try! Image<RGB, UInt8>(contentsOf: path)
        lena.dataConvert { UInt8(pow(Double($0), 2) / 255) }
        
        // each channel
        var eq1 = lena
        Histograms.equalize(image: &eq1[channel: .red])
        Histograms.equalize(image: &eq1[channel: .green])
        Histograms.equalize(image: &eq1[channel: .blue])
        
        // three color histogram
        var eq2 = lena
        Histograms.equalize(image: &eq2)
        
        let image = Image.concatH([lena, eq1, eq2])
        let ns = image.nsImage()
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
    func testHistogramEqualizerDouble() {
        let path = testResoruceRoot().appendingPathComponent("lena_512_gray.png")
        var lena = try! Image<RGB, Double>(contentsOf: path)
        lena.dataConvert { pow($0, 0.5) }
        
        var eq = lena
        Histograms.equalize(image: &eq, numBins: 100)
        
        let image = Image.concatH([lena, eq])
        let ns = doubleToNSImage(image)
        
        XCTAssertTrue(ns.isValid, "break here")
    }
    
}

#endif
