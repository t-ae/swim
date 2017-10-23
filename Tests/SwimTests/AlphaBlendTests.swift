
import XCTest
import Swim

class AlphaBlendTests: XCTestCase {

    func testRGBandRGBA() {
        
        let c = 100
        let rgb: [[Float]] = (0..<c).map { _ in randomArray(count: 3) }
        let rgba: [[Float]] = (0..<c).map { _ in randomArray(count: 4) }
        let answer = zip(rgb, rgba).map { rgb, rgba -> [Float] in
            let a = rgba[3]
            return [(1-a)*rgb[0] + a*rgba[0],
                    (1-a)*rgb[1] + a*rgba[1],
                    (1-a)*rgb[2] + a*rgba[2]]
        }
        
        var dst = Image<RGB, Float>(width: c, height: 1, data: rgb.flatMap { $0 })
        let src = Image<RGBA, Float>(width: c, height: 1, data: rgba.flatMap { $0 })
        
        dst.alphaBlend(with: src)
        
        XCTAssertEqual(dst,
                       Image(width: c,
                             height: 1,
                             data: answer.flatMap { $0 }))
    }
    
    func testRGBAandRGBA() {
        
        let c = 100
        let p1: [[Float]] = (0..<c).map { _ in randomArray(count: 4) }
        let p2: [[Float]] = (0..<c).map { _ in randomArray(count: 4) }
        let answer = zip(p1, p2).map { p1, p2 -> [Float] in
            let ar = p2[3] + (1 - p2[3]) * p1[3]
            return [(p2[0]*p2[3] + p1[0]*(1-p2[3])*p1[3]) / ar,
                    (p2[1]*p2[3] + p1[1]*(1-p2[3])*p1[3]) / ar,
                    (p2[2]*p2[3] + p1[2]*(1-p2[3])*p1[3]) / ar,
                    ar]
        }
        
        var dst = Image<RGBA, Float>(width: c, height: 1, data: p1.flatMap { $0 })
        let src = Image<RGBA, Float>(width: c, height: 1, data: p2.flatMap { $0 })
        
        dst.alphaBlend(with: src)
        
        XCTAssertEqual(dst,
                       Image(width: c,
                             height: 1,
                             data: answer.flatMap { $0 }),
                       accuracy: 1e-5)
    }

}