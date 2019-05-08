import XCTest
import Swim

class vImageUtilsTests: XCTestCase {
    
}
#if canImport(Accelerate)

import Accelerate

extension vImageUtilsTests {
    func testAlphaBlend() {
        let c = 100
        let p1: [[Float]] = (0..<c).map { _ in randomArray(count: 4) }
        let p2: [[Float]] = (0..<c).map { _ in randomArray(count: 4) }
        let answer = zip(p1, p2).map { p1, p2 -> [Float] in
            let ar = p2[0] + (1 - p2[0]) * p1[0]
            return [ar,
                    (p2[1]*p2[0] + p1[1]*(1-p2[0])*p1[0]) / ar,
                    (p2[2]*p2[0] + p1[2]*(1-p2[0])*p1[0]) / ar,
                    (p2[3]*p2[0] + p1[3]*(1-p2[0])*p1[0]) / ar]
        }
        
        var dst = Image(width: c, height: 1, argb: p1.flatMap { $0 })
        var src = Image(width: c, height: 1, argb: p2.flatMap { $0 })
        
        dst = try! vImageUtils.alphaBlend(top: &src, bottom: &dst)
        
        XCTAssertEqual(dst,
                       Image(width: c,
                             height: 1,
                             data: answer.flatMap { $0 }),
                       accuracy: 1e-5)
    }
    
    func testDilate() {
        do {
            var image = Image(width: 3, height: 3, intensity: (0..<9).map { UInt8($0) })
            let kernel = Image<Intensity, UInt8>(width: 3, height: 3, value: 1)
            
            let filtered = try! vImageUtils.dilate(src: &image, kernel: kernel)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [4, 5, 5, 7, 8, 8, 7, 8, 8]))
        }
        do {
            var image = Image(width: 3, height: 3, intensity: (0..<9).map(Float.init))
            let kernel = Image<Intensity, Float>(width: 3, height: 3, value: 1)
            
            let filtered = try! vImageUtils.dilate(src: &image, kernel: kernel)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [4, 5, 5, 7, 8, 8, 7, 8, 8]))
        }
        
        // roi
        do {
            var image = Image(width: 5, height: 5, intensity: (0..<25).map { UInt8($0) })
            let kernel = Image<Intensity, UInt8>(width: 3, height: 3, value: 1)
            
            let filtered = try! vImageUtils.dilate(src: &image,
                                                   roi: Rect(x: 1, y: 1, width: 3, height: 2),
                                                   kernel: kernel)
            XCTAssertEqual(filtered, Image(width: 3, height: 2, data: [12, 13, 14,
                                                                       17, 18, 19]))
        }
    }
    
    func testErode() {
        do {
            var image = Image(width: 3, height: 3, intensity: (0..<9).map { UInt8($0) })
            let kernel = Image<Intensity, UInt8>(width: 3, height: 3, value: 1)
            
            let filtered = try! vImageUtils.erode(src: &image, kernel: kernel)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [0, 0, 1, 0, 0, 1, 3, 3, 4]))
        }
        do {
            var image = Image(width: 3, height: 3, intensity: (0..<9).map(Float.init))
            let kernel = Image<Intensity, Float>(width: 3, height: 3, value: 1)
            
            let filtered = try! vImageUtils.erode(src: &image, kernel: kernel)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [0, 0, 1, 0, 0, 1, 3, 3, 4]))
        }
        
        // roi
        do {
            var image = Image(width: 5, height: 5, intensity: (0..<25).map { UInt8($0) })
            let kernel = Image<Intensity, UInt8>(width: 3, height: 3, value: 1)
            
            let filtered = try! vImageUtils.erode(src: &image,
                                                  roi: Rect(x: 1, y: 1, width: 3, height: 2),
                                                  kernel: kernel)
            XCTAssertEqual(filtered, Image(width: 3, height: 2, data: [0, 1, 2,
                                                                       5, 6, 7]))
        }
    }
    
    func testMax() {
        do {
            var image = Image(width: 3, height: 3, intensity: (0..<9).map { UInt8($0) })
            
            let filtered = try! vImageUtils.max(src: &image, kernelWidth: 3, kernelHeight: 3)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [4, 5, 5, 7, 8, 8, 7, 8, 8]))
        }
        do {
            var image = Image(width: 3, height: 3, intensity: (0..<9).map(Float.init))
            
            let filtered = try! vImageUtils.max(src: &image, kernelWidth: 3, kernelHeight: 3)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [4, 5, 5, 7, 8, 8, 7, 8, 8]))
        }
    }
    
    func testMin() {
        do {
            var image = Image(width: 3, height: 3, intensity: (0..<9).map { UInt8($0) })
            
            let filtered = try! vImageUtils.min(src: &image, kernelWidth: 3, kernelHeight: 3)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [0, 0, 1, 0, 0, 1, 3, 3, 4]))
        }
        do {
            var image = Image(width: 3, height: 3, intensity: (0..<9).map(Float.init))
            
            let filtered = try! vImageUtils.min(src: &image, kernelWidth: 3, kernelHeight: 3)
            XCTAssertEqual(filtered, Image(width: 3, height: 3, data: [0, 0, 1, 0, 0, 1, 3, 3, 4]))
        }
    }
}

#endif
