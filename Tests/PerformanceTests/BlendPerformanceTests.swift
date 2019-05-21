import XCTest
import Swim

class BlendPerformanceTests: XCTestCase {
    func testAdditiveBlendRGB() {
        let top = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        var bottom = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        measure{
            Blender.additiveBlend(top: top, bottom: &bottom)
        }
    }
    
    func testAdditiveBlendRGBA() {
        let top = Image<RGBA, Double>(width: 3840, height: 2160, value: 0.1)
        var bottom = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        measure{
            Blender.additiveBlend(top: top, bottom: &bottom)
        }
    }
    
    func testMultiplyBlendRGB() {
        let top = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        var bottom = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        measure{
            Blender.multiplyBlend(top: top, bottom: &bottom)
        }
    }
    
    func testMultiplyBlendRGBA() {
        let top = Image<RGBA, Double>(width: 3840, height: 2160, value: 0.1)
        var bottom = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        measure{
            Blender.multiplyBlend(top: top, bottom: &bottom)
        }
    }
    
    func testScreenBlendRGB() {
        let top = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        var bottom = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        measure{
            Blender.screenBlend(top: top, bottom: &bottom)
        }
    }
    
    func testScreenBlendRGBA() {
        let top = Image<RGBA, Double>(width: 3840, height: 2160, value: 0.1)
        var bottom = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        measure{
            Blender.screenBlend(top: top, bottom: &bottom)
        }
    }
    
    func testOverlayBlendRGB() {
        let top = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        var bottom = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        measure{
            Blender.overlayBlend(top: top, bottom: &bottom)
        }
    }
    
    func testOverlayBlendRGBA() {
        let top = Image<RGBA, Double>(width: 3840, height: 2160, value: 0.1)
        var bottom = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        measure{
            Blender.overlayBlend(top: top, bottom: &bottom)
        }
    }
}
