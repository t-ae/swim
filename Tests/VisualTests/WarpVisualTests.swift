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
    
    let affine = AffineTransformation(scale: (50, 50), rotation: Double.pi/6, translation: (150, 0))
    
    func testWarpNN() {
        typealias Intpl = NearestNeighborInterpolator
        
        var nsImages = [String: NSImage]()
        
        do {
            let intpl = Intpl<Double>()
            let result = try! src.transform.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            nsImages["constant0"] = doubleToNSImage(result)
        }
        do {
            let intpl = Intpl<Double>(edgeMode: .reflect)
            let result = try! src.transform.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            nsImages["reflect"] = doubleToNSImage(result)
        }
        do {
            let intpl = Intpl<Double>(edgeMode: .symmetric)
            let result = try! src.transform.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            nsImages["symmetric"] = doubleToNSImage(result)
        }
        do {
            let intpl = Intpl<Double>(edgeMode: .edge)
            let result = try! src.transform.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            nsImages["edge"] = doubleToNSImage(result)
        }
        do {
            let intpl = Intpl<Double>(edgeMode: .wrap)
            let result = try! src.transform.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            nsImages["wrap"] = doubleToNSImage(result)
        }
        
        XCTAssertFalse(nsImages.isEmpty, "Break and check nsImages in debugger.")
    }
    
    func testWarpBL() {
        typealias Intpl = BilinearInterpolator
        
        var nsImages = [String: NSImage]()
        
        do {
            let intpl = Intpl<Double>()
            let result = try! src.transform.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            nsImages["constant0"] = doubleToNSImage(result)
        }
        do {
            let intpl = Intpl<Double>(edgeMode: .symmetric)
            let result = try! src.transform.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            nsImages["symmetric"] = doubleToNSImage(result)
        }
        do {
            let intpl = Intpl<Double>(edgeMode: .edge)
            let result = try! src.transform.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            nsImages["edge"] = doubleToNSImage(result)
        }
        do {
            let intpl = Intpl<Double>(edgeMode: .wrap)
            let result = try! src.transform.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            nsImages["wrap"] = doubleToNSImage(result)
        }
        
        XCTAssertFalse(nsImages.isEmpty, "Break and check nsImages in debugger.")
    }
    
    func testWarpBC() {
        typealias Intpl = BicubicInterpolator
        
        var nsImages = [String: NSImage]()
        
        do {
            let intpl = Intpl<Double>()
            var result = try! src.transform.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            nsImages["constant0"] = doubleToNSImage(result)
        }
        do {
            let intpl = Intpl<Double>(a: -0.2)
            var result = try! src.transform.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            nsImages["constant0 a-0.2"] = doubleToNSImage(result)
        }
        do {
            let intpl = Intpl<Double>(edgeMode: .symmetric)
            var result = try! src.transform.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            nsImages["symmetric"] = doubleToNSImage(result)
        }
        do {
            let intpl = Intpl<Double>(edgeMode: .edge)
            var result = try! src.transform.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            nsImages["edge"] = doubleToNSImage(result)
        }
        do {
            let intpl = Intpl<Double>(edgeMode: .wrap)
            var result = try! src.transform.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            nsImages["wrap"] = doubleToNSImage(result)
        }
        
        XCTAssertFalse(nsImages.isEmpty, "Break and check nsImages in debugger.")
    }
    
    func testMatrix() {
        let path = testResoruceRoot().appendingPathComponent("lena_128.png")
        let lena = Image<RGB, Double>(contentsOf: path)!
        
        let size = Double(lena.width)
        let scale: Double = 2.3
        var affine = AffineTransformation<Double>.identity
        affine = AffineTransformation.scale(x: scale, y: scale) * affine
        affine = AffineTransformation.translation(x: scale/2, y: scale/2) * affine
        affine = AffineTransformation.translation(x: -size*scale/2, y: -size*scale/2) * affine
        affine = AffineTransformation.rotation(angle: .pi / 4) * affine
        affine = AffineTransformation.translation(x: size*scale/2, y: size*scale/2) * affine
        
        let intpl = NearestNeighborInterpolator<Double>(edgeMode: .reflect)
        let result = try! lena.transform.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
        let nsImage = doubleToNSImage(result)
        
        XCTAssertTrue(nsImage.isValid, "Break and check nsImages in debugger.")
    }
}
