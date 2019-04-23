import XCTest
@testable import Swim

class MutablePixelRefArithmeticTests: XCTestCase {
    func testAdd() {
        var image = Image(width: 2, height: 2, rgba: (0..<2*2*4).map { UInt8($0) })
        var answer = image
        
        image.withUnsafeMutableBufferPointer { bp in
            let ref = MutablePixelRef<RGBA, UInt8>(_x: 0, _y: 0, pointer: UnsafeMutableBufferPointer(rebasing: bp[0..<4]))
            ref += 1
        }
        
        answer[0, 0] += 1
        
        XCTAssertEqual(image, answer)
    }
}
