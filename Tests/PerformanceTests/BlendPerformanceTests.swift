import XCTest
import Swim

class BlendPerformanceTests: XCTestCase {
    func testAdditiveBlend() {
        let top = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        var bottom = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        measure{
            bottom.blend(image: top, mode: .additive)
        }
    }
    
    func testMultiplyBlend() {
        let top = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        var bottom = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        measure{
            bottom.blend(image: top, mode: .multiply)
        }
    }
    
    func testScreenBlend() {
        let top = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        var bottom = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        measure{
            bottom.blend(image: top, mode: .screen)
        }
    }
    
    func testOverlayBlend() {
        let top = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        var bottom = Image<RGB, Double>(width: 3840, height: 2160, value: 0.1)
        measure{
            bottom.blend(image: top, mode: .overlay)
        }
    }
}
