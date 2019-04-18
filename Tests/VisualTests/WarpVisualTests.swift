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
            let result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["constant0"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .reflect)
            let result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["reflect"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .symmetric)
            let result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["symmetric"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .edge)
            let result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["edge"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .wrap)
            let result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["wrap"] = rgb256.nsImage()
        }
        
        XCTAssertFalse(nsImages.isEmpty, "Break and check nsImages in debugger.")
    }
    
    func testWarpBL() {
        typealias Intpl = BilinearInterpolator
        
        var nsImages = [String: NSImage]()
        
        do {
            let intpl = Intpl<Double>()
            let result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["constant0"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .symmetric)
            let result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["symmetric"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .edge)
            let result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["edge"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .wrap)
            let result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["wrap"] = rgb256.nsImage()
        }
        
        XCTAssertFalse(nsImages.isEmpty, "Break and check nsImages in debugger.")
    }
    
    func testWarpBC() {
        typealias Intpl = BicubicInterpolator
        
        var nsImages = [String: NSImage]()
        
        do {
            let intpl = Intpl<Double>()
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["constant0"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(a: -0.2)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["constant0 a-0.2"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .symmetric)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["symmetric"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .edge)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["edge"] = rgb256.nsImage()
        }
        do {
            let intpl = Intpl<Double>(mode: .wrap)
            var result = try! src.warp(transformation: affine, outputSize: (512, 512), interpolator: intpl)
            result.clip(low: 0, high: 1)
            let rgb256 = (result * 255).typeConverted(to: UInt8.self)
            
            nsImages["wrap"] = rgb256.nsImage()
        }
        
        XCTAssertFalse(nsImages.isEmpty, "Break and check nsImages in debugger.")
    }
}
