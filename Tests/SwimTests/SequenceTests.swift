
import XCTest
@testable import Swim

class SequencePerformanceTests: XCTestCase {
    
    func testImageSequence() {
        do {
            let image = Image<Intensity, UInt8>(width: 2, height: 2, data: [0, 1, 2, 3])
            
            var iterator = image.makeIterator()
            
            var x: Int, y: Int, pixel: Pixel<Intensity, UInt8>
            do {
                (x, y, pixel) = iterator.next()!
                
                XCTAssertEqual(x, 0)
                XCTAssertEqual(y, 0)
                XCTAssertEqual(pixel, Pixel(0))
            }
            do {
                (x, y, pixel) = iterator.next()!
                
                XCTAssertEqual(x, 1)
                XCTAssertEqual(y, 0)
                XCTAssertEqual(pixel, Pixel(1))
            }
            do {
                (x, y, pixel) = iterator.next()!
                
                XCTAssertEqual(x, 0)
                XCTAssertEqual(y, 1)
                XCTAssertEqual(pixel, Pixel(2))
            }
            do {
                (x, y, pixel) = iterator.next()!
                
                XCTAssertEqual(x, 1)
                XCTAssertEqual(y, 1)
                XCTAssertEqual(pixel, Pixel(3))
            }
            XCTAssertNil(iterator.next())
        }
        do {
            let image = Image<RGBA, Double>(width: 2, height: 2, data: (0..<16).map(Double.init))
            
            var iterator = image.makeIterator()
            
            var x: Int, y: Int, pixel: Pixel<RGBA, Double>
            do {
                (x, y, pixel) = iterator.next()!
                
                XCTAssertEqual(x, 0)
                XCTAssertEqual(y, 0)
                XCTAssertEqual(pixel, Pixel(r: 0, g: 1, b: 2, a: 3))
            }
            do {
                (x, y, pixel) = iterator.next()!
                
                XCTAssertEqual(x, 1)
                XCTAssertEqual(y, 0)
                XCTAssertEqual(pixel, Pixel(r: 4, g: 5, b: 6, a: 7))
            }
            do {
                (x, y, pixel) = iterator.next()!
                
                XCTAssertEqual(x, 0)
                XCTAssertEqual(y, 1)
                XCTAssertEqual(pixel, Pixel(r: 8, g: 9, b: 10, a: 11))
            }
            do {
                (x, y, pixel) = iterator.next()!
                
                XCTAssertEqual(x, 1)
                XCTAssertEqual(y, 1)
                XCTAssertEqual(pixel, Pixel(r: 12, g: 13, b: 14, a: 15))
            }
            XCTAssertNil(iterator.next())
        }
    }
    
    func testImageSliceSequence() {
        do {
            let image = Image<Intensity, UInt8>(width: 3, height: 3, data: [UInt8](0..<9))
            let slice = image[1..<3, 1..<3]
            var iterator = slice.makeIterator()
            
            var x: Int, y: Int, pixel: Pixel<Intensity, UInt8>
            
            do {
                (x, y, pixel) = iterator.next()!
                
                XCTAssertEqual(x, 0)
                XCTAssertEqual(y, 0)
                XCTAssertEqual(pixel, Pixel(4))
            }
            do {
                (x, y, pixel) = iterator.next()!
                
                XCTAssertEqual(x, 1)
                XCTAssertEqual(y, 0)
                XCTAssertEqual(pixel, Pixel(5))
            }
            do {
                (x, y, pixel) = iterator.next()!
                
                XCTAssertEqual(x, 0)
                XCTAssertEqual(y, 1)
                XCTAssertEqual(pixel, Pixel(7))
            }
            do {
                (x, y, pixel) = iterator.next()!
                
                XCTAssertEqual(x, 1)
                XCTAssertEqual(y, 1)
                XCTAssertEqual(pixel, Pixel(8))
            }
            XCTAssertNil(iterator.next())
        }
    }
}
