
import XCTest
import Swim

class PerformanceTests: XCTestCase {
    #if !SWIFT_PACKAGE
    func testConvertedPerformance() {
        let data = [UInt8](repeating: 0, count: 1920*1024*4)
        let image = Image<RGBA, UInt8>(width: 1920, height: 1024, data: data)
        
        measure {
            _ = image.converted { x, y, px in
                px
            }
        }
    }
    
    func testChannelwiseConverted() {
        let data = [UInt8](repeating: 0, count: 1920*1024*4)
        let image = Image<RGBA, UInt8>(width: 1920, height: 1024, data: data)
        
        measure {
            _ = image.channelwiseConverted { $0 }
        }
    }
    
    func testBrightness() {
        let data = [Float](repeating: 0, count: 1920*1024*3)
        let image = Image<RGB, Float>(width: 1920, height: 1024, data: data)
        
        measure {
            _ = image.toBrightness()
        }
    }
    #endif
}
