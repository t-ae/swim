import XCTest
import Swim

class InterpolatorPerformanceTests: XCTestCase {

    func testNN() {
        let image = Image<RGBA, Double>(width: 640, height: 480, value: 1)
        var target = Image<RGBA, Double>(width: 1, height: 1, value: 1)
        
        let intpl = NearestNeighborInterpolator<RGBA, Double>(edgeMode: .edge)
        
        measure {
            target.withPixelRef(x: 0, y: 0) { ref in
                for _ in 0..<3840*2160 {
                    intpl.interpolate(x: 10.5, y: 10.5, in: image, into: ref)
                }
            }
        }
    }

    func testBL() {
        let image = Image<RGBA, Double>(width: 640, height: 480, value: 1)
        var target = Image<RGBA, Double>(width: 1, height: 1, value: 1)
        
        let intpl = BilinearInterpolator<RGBA, Double>(edgeMode: .edge)
        
        measure {
            target.withPixelRef(x: 0, y: 0) { ref in
                for _ in 0..<3840*2160 {
                    intpl.interpolate(x: 10.5, y: 10.5, in: image, into: ref)
                }
            }
        }
    }
    
    func testBC() {
        let image = Image<RGBA, Double>(width: 640, height: 480, value: 1)
        var target = Image<RGBA, Double>(width: 1, height: 1, value: 1)
        
        let intpl = BicubicInterpolator<RGBA, Double>(edgeMode: .edge)
        
        measure {
            target.withPixelRef(x: 0, y: 0) { ref in
                for _ in 0..<3840*2160 {
                    intpl.interpolate(x: 10.5, y: 10.5, in: image, into: ref)
                }
            }
        }
    }
}
