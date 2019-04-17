import Foundation

func randomArray<T: BinaryFloatingPoint>(count: Int) -> [T] where T.RawSignificand: FixedWidthInteger {
    return (0..<count).map { _ in T.random(in: 0..<1) }
}
