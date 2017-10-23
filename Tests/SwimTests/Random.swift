
import Foundation

func randomArray<T: BinaryFloatingPoint>(count: Int) -> [T] {
    var ret = [T](repeating: 0, count: count)
    
    for i in 0..<count {
        ret[i] = T(arc4random_uniform(UInt32.max)) / T(UInt32.max)
    }
    
    return ret
}
