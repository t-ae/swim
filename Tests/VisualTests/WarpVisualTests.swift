import XCTest
import Swim

class WarpVisualTests: XCTestCase {
    let src = Image<RGB, Double>(width: 3,
                                 height: 3,
                                 data: [1, 0, 0,
                                        0, 1, 0,
                                        0, 0, 1,
                                        1, 1, 0,
                                        1, 0, 1,
                                        0, 1, 1,
                                        1, 1, 1,
                                        0.5, 0.5, 0.5,
                                        0.3, 0.3, 0.3])
    
    let affine = AffineTransformation(scale: (30, 30), rotation: Double.pi/6, translation: (200, 200))
}

#if canImport(AppKit)

extension WarpVisualTests {
    func testWarpNN() {
        guard let font = try? TrueTypeFont(url: URL(fileURLWithPath: "/System/Library/Fonts/Helvetica.ttc"), fontSize: 20) else {
            XCTFail("Font not found.")
            return
        }
        let bg = Color<RGBA, Double>(r: 1, g: 1, b: 1, a: 0.5)
        
        typealias Intpl = NearestNeighborInterpolator<RGB, Double>
        
        var images = [Image<RGB, Double>]()
        
        do {
            let intpl = Intpl()
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.drawText(position: (0, 0), text: "constant0", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .constant(color: Color(r: 1, g: 0, b: 0)))
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.drawText(position: (0, 0), text: "constant red", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .reflect)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.drawText(position: (0, 0), text: "reflect", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .symmetric)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.drawText(position: (0, 0), text: "symmetric", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .edge)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.drawText(position: (0, 0), text: "edge", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .wrap)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.drawText(position: (0, 0), text: "wrap", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        
        let nsImage = Image.concatH(images).nsImage()
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
    
    func testWarpBL() {
        guard let font = try? TrueTypeFont(url: URL(fileURLWithPath: "/System/Library/Fonts/Helvetica.ttc"), fontSize: 20) else {
            XCTFail("Font not found.")
            return
        }
        let bg = Color<RGBA, Double>(r: 1, g: 1, b: 1, a: 0.5)
        
        typealias Intpl = BilinearInterpolator<RGB, Double>
        
        var images = [Image<RGB, Double>]()
        
        do {
            let intpl = Intpl()
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.drawText(position: (0, 0), text: "constant0", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .reflect)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.drawText(position: (0, 0), text: "reflect", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .symmetric)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.drawText(position: (0, 0), text: "symmetric", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .edge)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.drawText(position: (0, 0), text: "edge", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .wrap)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.drawText(position: (0, 0), text: "wrap", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        
        let nsImage = Image.concatH(images).nsImage()
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
    
    func testWarpBC() {
        guard let font = try? TrueTypeFont(url: URL(fileURLWithPath: "/System/Library/Fonts/Helvetica.ttc"), fontSize: 20) else {
            XCTFail("Font not found.")
            return
        }
        let bg = Color<RGBA, Double>(r: 1, g: 1, b: 1, a: 0.5)
        
        typealias Intpl = BicubicInterpolator<RGB, Double>
        
        var images = [Image<RGB, Double>]()
        
        do {
            let intpl = Intpl()
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            result.drawText(position: (0, 0), text: "constant0 a=-0.5", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(a: -0.75)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            result.drawText(position: (0, 0), text: "constant0 a=-0.75", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .reflect)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            result.drawText(position: (0, 0), text: "reflect", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .symmetric)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            result.drawText(position: (0, 0), text: "symmetric", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .edge)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            result.drawText(position: (0, 0), text: "edge", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .wrap)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            result.drawText(position: (0, 0), text: "wrap", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        
        let nsImage = Image.concatH(images).nsImage()
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
    
    func testWarpLanczos2() {
        guard let font = try? TrueTypeFont(url: URL(fileURLWithPath: "/System/Library/Fonts/Helvetica.ttc"), fontSize: 20) else {
            XCTFail("Font not found.")
            return
        }
        let bg = Color<RGBA, Double>(r: 1, g: 1, b: 1, a: 0.5)
        
        typealias Intpl = Lanczos2Interpolator<RGB, Double>
        
        var images = [Image<RGB, Double>]()
        
        do {
            let intpl = Intpl()
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            result.drawText(position: (0, 0), text: "constant0", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .reflect)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            result.drawText(position: (0, 0), text: "reflect", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .symmetric)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            result.drawText(position: (0, 0), text: "symmetric", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .edge)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            result.drawText(position: (0, 0), text: "edge", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .wrap)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            result.drawText(position: (0, 0), text: "wrap", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        
        let nsImage = Image.concatH(images).nsImage()
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
    
    func testWarpLanczos3() {
        guard let font = try? TrueTypeFont(url: URL(fileURLWithPath: "/System/Library/Fonts/Helvetica.ttc"), fontSize: 20) else {
            XCTFail("Font not found.")
            return
        }
        let bg = Color<RGBA, Double>(r: 1, g: 1, b: 1, a: 0.5)
        
        typealias Intpl = Lanczos3Interpolator<RGB, Double>
        
        var images = [Image<RGB, Double>]()
        
        do {
            let intpl = Intpl()
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            result.drawText(position: (0, 0), text: "constant0", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .reflect)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            result.drawText(position: (0, 0), text: "reflect", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .symmetric)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            result.drawText(position: (0, 0), text: "symmetric", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .edge)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            result.drawText(position: (0, 0), text: "edge", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Intpl(edgeMode: .wrap)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            result.drawText(position: (0, 0), text: "wrap", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        
        let nsImage = Image.concatH(images).nsImage()
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages")
    }
    
    func testMatrix() {
        guard let font = try? TrueTypeFont(url: URL(fileURLWithPath: "/System/Library/Fonts/Helvetica.ttc"), fontSize: 20) else {
            XCTFail("Font not found.")
            return
        }
        let bg = Color<RGBA, Double>(r: 1, g: 1, b: 1, a: 0.5)

        let path = testResoruceRoot().appendingPathComponent("lena_128.png")
        let lena = try! Image<RGB, Double>(contentsOf: path)
        
        let size = Double(lena.width)
        let scale: Double = 1.5
        var affine = AffineTransformation.identity
        affine = .scale(x: scale, y: scale) * affine
        affine = .translation(x: -size*scale/2, y: -size*scale/2) * affine
        affine = .rotation(angle: .pi / 6) * affine
        affine = .translation(x: size*scale/2, y: size*scale/2) * affine
        
        var images = [Image<RGB, Double>]()
        do {
            let intpl = NearestNeighborInterpolator<RGB, Double>(edgeMode: .wrap)
            var result = try! lena.warp(transformation: affine, outputSize: (300, 300), interpolator: intpl)
            result.drawText(position: (0, 0), text: "NN\nwrap", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = BilinearInterpolator<RGB, Double>(edgeMode: .zero)
            var result = try! lena.warp(transformation: affine, outputSize: (300, 300), interpolator: intpl)
            result.drawText(position: (0, 0), text: "Bilinear\nconstant-zero", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = BicubicInterpolator<RGB, Double>(edgeMode: .reflect)
            var result = try! lena.warp(transformation: affine, outputSize: (300, 300), interpolator: intpl)
            result.drawText(position: (0, 0), text: "Bicubic\nreflect", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Lanczos2Interpolator<RGB, Double>(edgeMode: .edge)
            var result = try! lena.warp(transformation: affine, outputSize: (300, 300), interpolator: intpl)
            result.drawText(position: (0, 0), text: "Lanczos2\nedge", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        do {
            let intpl = Lanczos3Interpolator<RGB, Double>(edgeMode: .symmetric)
            var result = try! lena.warp(transformation: affine, outputSize: (300, 300), interpolator: intpl)
            result.drawText(position: (0, 0), text: "Lanczos3\nsymmetric", font: font, color: .black, backgroundColor: bg)
            images.append(result)
        }
        
        let nsImage = doubleToNSImage(Image.concatH(images))
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages in debugger.")
    }
    
    func testProjectiveTransformation() {
        let path = testResoruceRoot().appendingPathComponent("lena_128.png")
        let lena = try! Image<RGB, Double>(contentsOf: path)
        
        let proj = try! ProjectiveTransformation(source: ((0.0, 0), (128, 0), (0, 128), (128, 128)),
                                                 target: ((10, 200), (30, -50), (200, 200), (300, 100)))
        
        let intpl = BilinearInterpolator<RGB, Double>(edgeMode: .zero)
        let image = try! lena.warp(transformation: proj, outputSize: (300, 300), interpolator: intpl)
        let nsImage = doubleToNSImage(image)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages in debugger.")
    }
}

#endif
