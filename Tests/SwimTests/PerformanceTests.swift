
import XCTest
import Swim

class PerformanceTests: XCTestCase {
    #if !SWIFT_PACKAGE
    
    func testConvert() {
        let data = [UInt8](repeating: 0, count: 1920*1080*4)
        var image = Image<RGBA, UInt8>(width: 1920, height: 1080, data: data)
        
        measure {
            image.convert { x, y, px in
                px + 1
            }
        }
    }
    
    func testUnsafeConvert() {
        let data = [UInt8](repeating: 0, count: 1920*1080*4)
        var image = Image<RGBA, UInt8>(width: 1920, height: 1080, data: data)
        
        measure {
            _ = image.unsafeConvert { x, y, bp in
                for i in 0..<bp.count {
                    bp[i] += 1
                }
            }
        }
    }
    
    func testConverted() {
        let data = [UInt8](repeating: 0, count: 1920*1080*4)
        let image = Image<RGBA, UInt8>(width: 1920, height: 1080, data: data)
        
        measure {
            _ = image.converted { x, y, px in
                px + 1
            }
        }
    }
    
    func testChannelwiseConverted() {
        let data = [UInt8](repeating: 0, count: 1920*1080*4)
        let image = Image<RGBA, UInt8>(width: 1920, height: 1080, data: data)
        
        measure {
            _ = image.channelwiseConverted { $0 + 1 }
        }
    }
    
    func testBrightness() {
        let data = [Float](repeating: 0, count: 1920*1080*3)
        let image = Image<RGB, Float>(width: 1920, height: 1080, data: data)
        
        measure {
            _ = image.toBrightness()
        }
    }
    
    func testSubimageSubscript() {
        let data = [Float](repeating: 0, count: 1920*1080*3)
        var image = Image<RGB, Float>(width: 1920, height: 1080, data: data)
        
        measure {
            for _ in 0..<100_000 {
                image[0..<16, 0..<16] += 0.01
            }
        }
    }
    
    func testChannelSubscript() {
        let data = [Float](repeating: 0, count: 1920*1080*3)
        var image = Image<RGB, Float>(width: 1920, height: 1080, data: data)
        
        measure {
            for _ in 0..<1 {
                image[channel: .red] += 0.01
            }
        }
    }
    
    func testIntegralImage() {
        let data = [Float](repeating: 0, count: 1920*1080)
        let image = Image<Intensity, Float>(width: 1920, height: 1080, data: data)
        
        measure {
            for _ in 0..<1 {
                _ = image.toIntegralImage()
            }
        }
    }
    #endif
}
