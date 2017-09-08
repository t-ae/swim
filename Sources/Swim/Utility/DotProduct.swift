
import Foundation

func dotProduct<T: FloatingPoint>(_ a: [T], _ b: [T]) -> T {
    assert(a.count == b.count)
    
    var result: T = 0
    
    for (a, b) in zip(a, b) {
        result += a*b
    }
    
    return result
}

#if os(macOS) || os(iOS)
    import Accelerate
    
    func dotProduct(_ a: [Float], _ b: [Float]) -> Float {
        assert(a.count == b.count)

        var result: Float = 0
        vDSP_dotpr(a, 1, b, 1, &result, vDSP_Length(a.count))
        
        return result
    }
    
    func dotProduct(_ a: [Double], _ b: [Double]) -> Double {
        assert(a.count == b.count)
        
        var result: Double = 0
        vDSP_dotprD(a, 1, b, 1, &result, vDSP_Length(a.count))
        
        return result
    }
#endif
