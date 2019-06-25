import XCTest
import Swim

class BicubicInterpolationTests: XCTestCase {
    func testInterpolate() {
        let intpl = BicubicInterpolator<Gray, Double>(edgeMode: .zero)
        
        let image = Image<Gray, Double>(width: 4,
                                        height: 4,
                                        data: (0..<4*4).map { Double($0+1) })
        
        XCTAssertEqual(image[0, 0, interpolator: intpl], Color(gray: 1))
        XCTAssertEqual(image[1, 1, interpolator: intpl], Color(gray: 6))
        XCTAssertEqual(image[1, 2, interpolator: intpl], Color(gray: 10))
        XCTAssertEqual(image[3, 3, interpolator: intpl], Color(gray: 16))
        
    }
    
    static let allTests = [
        ("testInterpolate", testInterpolate)
    ]
}
