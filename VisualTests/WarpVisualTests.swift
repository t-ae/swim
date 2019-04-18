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
    let trans = AffineTransformation.translate(x: 150, y: 0)
        * AffineTransformation.rotate(angle: Double.pi/6)
        * AffineTransformation.scale(x: 50, y: 50)
    
    func testWarpNN() {
        typealias Intpl = NearestNeighborInterpolator
        
        var nsImages = [String: NSImage]()
        
        do {
            let intpl = Intpl<Double>()
            let result = try! src.warp(transformation: trans, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["constant0"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .reflect)
            let result = try! src.warp(transformation: trans, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["reflect"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .symmetric)
            let result = try! src.warp(transformation: trans, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["symmetric"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .edge)
            let result = try! src.warp(transformation: trans, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["edge"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .wrap)
            let result = try! src.warp(transformation: trans, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["wrap"] = rgb256.nsImage()
        }
        
        print("break here")
        XCTAssertFalse(nsImages.isEmpty)
    }
    
    func testWarpBL() {
        typealias Intpl = BilinearInterpolator
        
        var nsImages = [String: NSImage]()
        
        do {
            let intpl = Intpl<Double>()
            let result = try! src.warp(transformation: trans, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["constant0"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .symmetric)
            let result = try! src.warp(transformation: trans, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["symmetric"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .edge)
            let result = try! src.warp(transformation: trans, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["edge"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .wrap)
            let result = try! src.warp(transformation: trans, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["wrap"] = rgb256.nsImage()
        }
        
        print("break here")
        XCTAssertFalse(nsImages.isEmpty)
    }
    
    func testWarpBC() {
        typealias Intpl = BicubicInterpolator
        
        var nsImages = [String: NSImage]()
        
        do {
            let intpl = Intpl<Double>()
            var result = try! src.warp(transformation: trans, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["constant0"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(a: -0.2)
            var result = try! src.warp(transformation: trans, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["constant0 a-0.2"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .symmetric)
            var result = try! src.warp(transformation: trans, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["symmetric"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .edge)
            var result = try! src.warp(transformation: trans, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["edge"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .wrap)
            var result = try! src.warp(transformation: trans, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["wrap"] = rgb256.nsImage()
        }
        
        print("break here")
        XCTAssertFalse(nsImages.isEmpty)
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
        
        let t1 = AffineTransformation<Float>.translate(x: 32, y: 32)
            * AffineTransformation.rotate(angle: Float.pi/4)
            * AffineTransformation<Float>.scale(x: 30, y: 30)
        src.warpAffine(baseImage: &baseImage, transformation: t1, interpolation: .bicubic)
        
        let t2 = AffineTransformation<Float>.translate(x: 80, y: 32)
            * AffineTransformation.rotate(angle: Float.pi/8)
            * AffineTransformation<Float>.scale(x: 10, y: 15)
        src.warpAffine(baseImage: &baseImage, transformation: t2, interpolation: .nearestNeighbor)
        
        let t3 = AffineTransformation<Float>.translate(x: 192, y: 192)
            * AffineTransformation.rotate(angle: Float.pi/2)
            * AffineTransformation<Float>.scale(x: 10, y: 10)
            * AffineTransformation<Float>.translate(x: -1, y: -1)
        src.warpAffine(baseImage: &baseImage, transformation: t3)
        
        let rgb256 = (baseImage * 255).typeConverted(to: UInt8.self)
        let nsImage = rgb256.nsImage()
        
        print("break here")
        _ = nsImage
    }
}
