import XCTest
import Swim

class ImageArithmeticTests: XCTestCase {
    func testNegate() {
        do {
            let before = (0..<16).map { Int.init($0) }
            let after = before.map { -$0 }
            let image = Image(width: 2, height: 2, rgba: before)
            XCTAssertEqual(-image, Image(width: 2, height: 2, data: after))
        }
        do {
            let before = (0..<16).map { Double.init($0) }
            let after = before.map { -$0 }
            let image = Image(width: 2, height: 2, argb: before)
            XCTAssertEqual(-image, Image(width: 2, height: 2, data: after))
        }
    }
    
    func testAddInt() {
        do { // scalar
            let before = (0..<16).map { Int($0) }
            let after = before.map { $0 + 1 }
            var image = Image(width: 2, height: 2, rgba: before)
            
            XCTAssertEqual(image + 1, Image(width: 2, height: 2, data: after))
            XCTAssertEqual(1 + image, Image(width: 2, height: 2, data: after))
            
            image += 1
            XCTAssertEqual(image, Image(width: 2, height: 2, data: after))
        }
        do { // pixel
            var image = Image(width: 2, height: 2, rgba: [Int](0..<16))
            let pixel = Pixel(r: 4, g: 3, b: 2, a: 1)
            
            let answer = Image(width: 2, height: 2, rgba: [4, 4, 4, 4, 8, 8, 8, 8,
                                                           12, 12, 12,12, 16, 16, 16, 16])
            XCTAssertEqual(image + pixel, answer)
            XCTAssertEqual(pixel + image, answer)
            
            image += pixel
            XCTAssertEqual(image, answer)
        }
        do { // image
            var image = Image(width: 2, height: 2, rgba: [Int](0..<16))
            
            let answer = Image(width: 2, height: 2, rgba: [0, 2, 4, 6, 8, 10, 12, 14,
                                                           16, 18, 20, 22, 24, 26, 28, 30])
            
            XCTAssertEqual(image + image, answer)
            
            image += image
            XCTAssertEqual(image, answer)
        }
    }
    
    func testAddDouble() {
        do { // scalar
            let before = (0..<16).map { Double($0) }
            let after = before.map { $0 + 1 }
            var image = Image(width: 2, height: 2, rgba: before)
            
            XCTAssertEqual(image + 1, Image(width: 2, height: 2, data: after))
            XCTAssertEqual(1 + image, Image(width: 2, height: 2, data: after))
            
            image += 1
            XCTAssertEqual(image, Image(width: 2, height: 2, data: after))
        }
        do { // pixel
            var image = Image(width: 2, height: 2, rgba: (0..<16).map { Double($0) })
            let pixel = Pixel(r: 4.0, g: 3, b: 2, a: 1)
            
            let answer = Image(width: 2, height: 2, rgba: [4.0, 4, 4, 4, 8, 8, 8, 8,
                                                           12, 12, 12,12, 16, 16, 16, 16])
            XCTAssertEqual(image + pixel, answer)
            XCTAssertEqual(pixel + image, answer)
            
            image += pixel
            XCTAssertEqual(image, answer)
        }
        do { // image
            var image = Image(width: 2, height: 2, rgba: (0..<16).map { Double($0) })
            
            let answer = Image(width: 2, height: 2, rgba: [0.0, 2, 4, 6, 8, 10, 12, 14,
                                                           16, 18, 20, 22, 24, 26, 28, 30])
            
            XCTAssertEqual(image + image, answer)
            
            image += image
            XCTAssertEqual(image, answer)
        }
    }
    
    func testSubInt() {
        do { // scalar
            let before = (1..<17).map { Int($0) }
            let after = before.map { $0 - 1 }
            var image = Image(width: 2, height: 2, rgba: before)
            
            let answer = Image(width: 2, height: 2, rgba: after)
            
            XCTAssertEqual(image - 1, answer)
            XCTAssertEqual(1 - image, -answer)
            
            image -= 1
            XCTAssertEqual(image, answer)
        }
        do { // pixel
            var image = Image(width: 2, height: 2, rgba: [Int](0..<16))
            let pixel = Pixel(r: 0, g: 1, b: 2, a: 3)
            
            let answer = Image(width: 2, height: 2, rgba: [0, 0, 0, 0, 4, 4, 4, 4,
                                                           8, 8, 8, 8, 12, 12, 12,12])
            XCTAssertEqual(image - pixel, answer)
            XCTAssertEqual(pixel - image, -answer)
            
            image -= pixel
            XCTAssertEqual(image, answer)
        }
        do { // image
            var image = Image(width: 2, height: 2, rgba: [Int](0..<16))
            let image2 = Image(width: 2, height: 2, rgba: [Int](0..<16).reversed())
            
            let answer = Image(width: 2, height: 2, rgba: [-15, -13, -11, -9, -7, -5, -3, -1,
                                                           1, 3, 5 ,7, 9, 11, 13, 15])
            
            XCTAssertEqual(image - image2, answer)
            XCTAssertEqual(image2 - image, -answer)
            
            image -= image2
            XCTAssertEqual(image, answer)
        }
    }
    
    func testSubDouble() {
        do { // scalar
            let before = (1..<17).map { Double($0) }
            let after = before.map { $0 - 1 }
            var image = Image(width: 2, height: 2, rgba: before)
            
            let answer = Image(width: 2, height: 2, rgba: after)
            
            XCTAssertEqual(image - 1, answer)
            XCTAssertEqual(1 - image, -answer)
            
            image -= 1
            XCTAssertEqual(image, answer)
        }
        do { // pixel
            var image = Image(width: 2, height: 2, rgba: (0..<16).map { Double($0) })
            let pixel = Pixel(r: 0.0, g: 1, b: 2, a: 3)
            
            let answer = Image(width: 2, height: 2, rgba: [0.0, 0, 0, 0, 4, 4, 4, 4,
                                                           8, 8, 8, 8, 12, 12, 12,12])
            XCTAssertEqual(image - pixel, answer)
            XCTAssertEqual(pixel - image, -answer)
            
            image -= pixel
            XCTAssertEqual(image, answer)
        }
        do { // image
            var image = Image(width: 2, height: 2, rgba: (0..<16).map { Double($0) })
            let image2 = Image(width: 2, height: 2, rgba: (0..<16).map { Double($0) }.reversed())
            
            let answer = Image(width: 2, height: 2, rgba: [-15.0, -13, -11, -9, -7, -5, -3, -1,
                                                           1, 3, 5 ,7, 9, 11, 13, 15])
            
            XCTAssertEqual(image - image2, answer)
            XCTAssertEqual(image2 - image, -answer)
            
            image -= image2
            XCTAssertEqual(image, answer)
        }
    }
    
    func testMulInt() {
        typealias T = Int
        do { // scalar
            let before = (1..<17).map { T($0) }
            let after = before.map { $0 * 2 }
            var image = Image(width: 2, height: 2, rgba: before)
            
            let answer = Image(width: 2, height: 2, rgba: after)
            
            XCTAssertEqual(image * 2, answer)
            XCTAssertEqual(2 * image, answer)
            
            image *= 2
            XCTAssertEqual(image, answer)
        }
        do { // pixel
            var image = Image(width: 2, height: 2, rgba: (0..<16).map { T($0) })
            let pixel = Pixel<RGBA ,T>(r: 0, g: 1, b: 2, a: 3)
            
            let answer = Image<RGBA, T>(width: 2, height: 2, rgba: [0, 1, 4, 9, 0, 5, 12, 21,
                                                                    0, 9, 20, 33, 0, 13, 28, 45])
            XCTAssertEqual(image * pixel, answer)
            XCTAssertEqual(pixel * image, answer)
            
            image *= pixel
            XCTAssertEqual(image, answer)
        }
        do { // image
            var image = Image(width: 2, height: 2, rgba: (0..<16).map { T($0) })
            let image2 = Image(width: 2, height: 2, rgba: (0..<16).map { T($0) }.reversed())
            
            let answer = Image<RGBA, T>(width: 2, height: 2, rgba: [0*15, 1*14, 2*13, 3*12,
                                                                    4*11, 5*10, 6*9, 7*8,
                                                                    8*7, 9*6, 10*5, 11*4,
                                                                    12*3, 13*2, 14*1, 15*0])
            
            XCTAssertEqual(image * image2, answer)
            XCTAssertEqual(image2 * image, answer)
            
            image *= image2
            XCTAssertEqual(image, answer)
        }
    }
    
    func testMulDouble() {
        typealias T = Double
        do { // scalar
            let before = (1..<17).map { T($0) }
            let after = before.map { $0 * 2 }
            var image = Image(width: 2, height: 2, rgba: before)
            
            let answer = Image(width: 2, height: 2, rgba: after)
            
            XCTAssertEqual(image * 2, answer)
            XCTAssertEqual(2 * image, answer)
            
            image *= 2
            XCTAssertEqual(image, answer)
        }
        do { // pixel
            var image = Image(width: 2, height: 2, rgba: (0..<16).map { T($0) })
            let pixel = Pixel<RGBA, T>(r: 0, g: 1, b: 2, a: 3)
            
            let answer = Image<RGBA, T>(width: 2, height: 2, rgba: [0, 1, 4, 9, 0, 5, 12, 21,
                                                                    0, 9, 20, 33, 0, 13, 28, 45])
            XCTAssertEqual(image * pixel, answer)
            XCTAssertEqual(pixel * image, answer)
            
            image *= pixel
            XCTAssertEqual(image, answer)
        }
        do { // image
            var image = Image(width: 2, height: 2, rgba: (0..<16).map { T($0) })
            let image2 = Image(width: 2, height: 2, rgba: (0..<16).map { T($0) }.reversed())
            
            let answer = Image<RGBA, T>(width: 2, height: 2, rgba: [0*15, 1*14, 2*13, 3*12,
                                                                    4*11, 5*10, 6*9, 7*8,
                                                                    8*7, 9*6, 10*5, 11*4,
                                                                    12*3, 13*2, 14*1, 15*0].map { T($0) })
            
            XCTAssertEqual(image * image2, answer)
            XCTAssertEqual(image2 * image, answer)
            
            image *= image2
            XCTAssertEqual(image, answer)
        }
    }
    
    func testDivInt() {
        typealias T = Int
        do { // scalar
            let before = (1..<17).map { T($0) }
            var image = Image(width: 2, height: 2, rgba: before)
            
            let answer = Image(width: 2, height: 2, rgba: before.map { $0 / 2 })
            let answer2 = Image(width: 2, height: 2, rgba: before.map { 100 / $0 })
            
            XCTAssertEqual(image / 2, answer)
            XCTAssertEqual(100 / image, answer2)
            
            image /= 2
            XCTAssertEqual(image, answer)
        }
        do { // pixel
            var image = Image(width: 2, height: 2, rgba: (1..<17).map { T($0) })
            let pixel = Pixel<RGBA ,T>(r: 1, g: 2, b: 3, a: 4)
            
            let answer = Image<RGBA, T>(width: 2, height: 2, rgba: [1, 1, 1, 1, 5, 3, 2, 2,
                                                                    9, 5, 3, 3, 13, 7, 5, 4])
            
            let answer2 = Image<RGBA, T>(width: 2, height: 2, rgba: [1, 1, 1, 1, 0, 0, 0, 0,
                                                                     0, 0, 0, 0, 0, 0, 0, 0])
            XCTAssertEqual(image / pixel, answer)
            XCTAssertEqual(pixel / image, answer2)
            
            image /= pixel
            XCTAssertEqual(image, answer)
        }
        do { // image
            var image = Image(width: 2, height: 2, rgba: (1..<17).map { T($0) })
            let image2 = Image(width: 2, height: 2, rgba: [1, 1, 1, 1, 2, 2, 2, 2,
                                                           3, 3, 3, 3, 100, 100, 100, 100])
            
            let answer = Image<RGBA, T>(width: 2, height: 2, rgba: [1, 2, 3, 4, 2, 3, 3, 4,
                                                                    3, 3, 3, 4, 0, 0, 0, 0])
            let answer2 = Image<RGBA, T>(width: 2, height: 2, rgba: [1, 0, 0, 0, 0, 0, 0, 0,
                                                                     0, 0, 0, 0, 100/13, 100/14, 100/15, 100/16])
            
            XCTAssertEqual(image / image2, answer)
            XCTAssertEqual(image2 / image, answer2)
            
            image /= image2
            XCTAssertEqual(image, answer)
        }
    }
    
    func testDivDouble() {
        typealias T = Double
        do { // scalar
            let before = (1..<17).map { T($0) }
            var image = Image(width: 2, height: 2, rgba: before)
            
            let answer = Image(width: 2, height: 2, rgba: before.map { $0 / 2 })
            let answer2 = Image(width: 2, height: 2, rgba: before.map { 100 / $0 })
            
            XCTAssertEqual(image / 2, answer)
            XCTAssertEqual(100 / image, answer2)
            
            image /= 2
            XCTAssertEqual(image, answer)
        }
        do { // pixel
            let imdata = (1..<17).map { T($0) }
            let pxdata = (1..<5).map { T($0) }
            var image = Image(width: 2, height: 2, rgba: imdata)
            let pixel = Pixel<RGBA ,T>(data: pxdata)
            
            var ansdata = imdata
            for i in 0..<4 {
                for j in 0..<4 {
                    ansdata[i*4+j] /= pxdata[j]
                }
            }
            let answer = Image<RGBA, T>(width: 2, height: 2, rgba: ansdata)
            
            var ansdata2 = imdata
            for i in 0..<4 {
                for j in 0..<4 {
                    ansdata2[i*4+j] = pxdata[j] / ansdata2[i*4+j]
                }
            }
            let answer2 = Image<RGBA, T>(width: 2, height: 2, rgba: ansdata2)
            
            XCTAssertEqual(image / pixel, answer)
            XCTAssertEqual(pixel / image, answer2)
            
            image /= pixel
            XCTAssertEqual(image, answer)
        }
        do { // image
            let imdata = (1..<17).map { T($0) }
            let imdata2 = (1..<17).map { T($0) }.reversed() as Array<T>
            
            var image = Image(width: 2, height: 2, rgba: imdata)
            let image2 = Image(width: 2, height: 2, rgba: imdata2)
            
            let ansdata = zip(imdata, imdata2).map { $0 / $1 }
            let answer = Image<RGBA, T>(width: 2, height: 2, rgba: ansdata)
            
            let ansdata2 = zip(imdata2, imdata).map { $0 / $1 }
            let answer2 = Image<RGBA, T>(width: 2, height: 2, rgba: ansdata2)
            
            XCTAssertEqual(image / image2, answer)
            XCTAssertEqual(image2 / image, answer2)
            
            image /= image2
            XCTAssertEqual(image, answer)
        }
    }
    
    static let allTests = [
        ("testNagate", testNegate),
        ("testAddInt", testAddInt),
        ("testAddDouble", testAddDouble),
        ("testSubInt", testSubInt),
        ("testSubDouble", testSubDouble),
        ("testMulInt", testMulInt),
        ("testMulDouble", testMulDouble),
        ("testDivInt", testDivInt),
        ("testDivDouble", testDivDouble),
    ]
}
