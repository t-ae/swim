
import XCTest
import Swim

class vImageUtilsTests: XCTestCase {
    
    #if os(macOS) || os(iOS)
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
    #endif
    
}
