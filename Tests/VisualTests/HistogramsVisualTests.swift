import XCTest
import Swim

class HistogramsVisualTests: XCTestCase {
}

#if canImport(AppKit)

extension HistogramsVisualTests {
    func createHistogramImage<T: BinaryInteger>(image: Image<Gray, T>) -> Image<Gray, T> {
        let bins = Histograms.histogram(of: image)
        
        let hist = Histograms<Gray, T>.createHistogramImage(bins: bins, color: .white, background: .black)
        
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
        
        let red = Histograms<RGBA, T>.createHistogramImage(bins: bins[0],
                                                           color: Color(r: 255, g: 0, b: 0, a: 128),
                                                           background: .transparent)
        let green = Histograms<RGBA, T>.createHistogramImage(bins: bins[1],
                                                             color: Color(r: 0, g: 255, b: 0, a: 128),
                                                             background: .transparent)
        let blue = Histograms<RGBA, T>.createHistogramImage(bins: bins[2],
                                                            color: Color(r: 0, g: 0, b: 255, a: 128),
                                                            background: .transparent)
        
        let maxHeight = [red.height, green.height, blue.height].max()!
        
        var hist = Image<RGB, T>(width: bins[0].count, height: maxHeight, value: 0)
        
        hist.drawImage(origin: (0, maxHeight - red.height), image: red)
        hist.drawImage(origin: (0, maxHeight - green.height), image: green)
        hist.drawImage(origin: (0, maxHeight - blue.height), image: blue)
        
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
