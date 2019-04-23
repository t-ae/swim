import XCTest
import Swim

class BilinearInterpolationTests: XCTestCase {
    func testInterpolate() {
        let intpl = BilinearInterpolator<Intensity, Double>(edgeMode: .constant(value: 255))
        
        let image = Image<Intensity, Double>(width: 4,
                                             height: 4,
                                             data: (0..<4*4).map { Double($0) })
        
        XCTAssertEqual(intpl.interpolate(x: 0, y: 0, in: image), Pixel(0))
        XCTAssertEqual(intpl.interpolate(x: 1, y: 1, in: image), Pixel(5))
        XCTAssertEqual(intpl.interpolate(x: 1, y: 2, in: image), Pixel(9))
        XCTAssertEqual(intpl.interpolate(x: 3, y: 3, in: image), Pixel(15))
        
        XCTAssertEqual(intpl.interpolate(x: 0.5, y: 0, in: image), Pixel(0.5))
        XCTAssertEqual(intpl.interpolate(x: 0, y: 0.5, in: image), Pixel(2))
        XCTAssertEqual(intpl.interpolate(x: 0.5, y: 0.5, in: image), Pixel(2.5))
    }
}
