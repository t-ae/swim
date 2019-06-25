import XCTest
import Swim

class NearestNeighborInterpolatorTests: XCTestCase {

    func testInterpolate() {
        let intpl = NearestNeighborInterpolator<Gray, Double>(edgeMode: .constant(value: 255))
        
        let image = Image<Gray, Double>(width: 4,
                                        height: 4,
                                        data: (0..<4*4).map { Double($0) })
        
        XCTAssertEqual(image[0, 0, interpolator: intpl], Color(gray: 0))
        XCTAssertEqual(image[1, 1, interpolator: intpl], Color(gray: 5))
        XCTAssertEqual(image[1, 2, interpolator: intpl], Color(gray: 9))
        XCTAssertEqual(image[3, 3, interpolator: intpl], Color(gray: 15))
        
        XCTAssertEqual(image[0.3, 0.3, interpolator: intpl], Color(gray: 0))
        XCTAssertEqual(image[0.7, 0.9, interpolator: intpl], Color(gray: 5))
        XCTAssertEqual(image[1.1, 1.8, interpolator: intpl], Color(gray: 9))
        XCTAssertEqual(image[2.7, 3.3, interpolator: intpl], Color(gray: 15))
    }

    static let allTests = [
        ("testInterpolate", testInterpolate)
    ]
}
