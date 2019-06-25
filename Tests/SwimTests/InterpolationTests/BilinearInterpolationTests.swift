import XCTest
import Swim

class BilinearInterpolationTests: XCTestCase {
    func testInterpolate() {
        let intpl = BilinearInterpolator<Gray, Double>(edgeMode: .constant(value: 255))
        
        let image = Image<Gray, Double>(width: 4,
                                        height: 4,
                                        data: (0..<4*4).map { Double($0) })
        
        XCTAssertEqual(image[0, 0, interpolator: intpl], Color(gray: 0))
        XCTAssertEqual(image[1, 1, interpolator: intpl], Color(gray: 5))
        XCTAssertEqual(image[1, 2, interpolator: intpl], Color(gray: 9))
        XCTAssertEqual(image[3, 3, interpolator: intpl], Color(gray: 15))
        
        XCTAssertEqual(image[0.5, 0, interpolator: intpl], Color(gray: 0.5))
        XCTAssertEqual(image[0, 0.5, interpolator: intpl], Color(gray: 2))
        XCTAssertEqual(image[0.5, 0.5, interpolator: intpl], Color(gray: 2.5))
    }
    
    static let allTests = [
        ("testInterpolate", testInterpolate)
    ]
}
