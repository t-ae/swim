
extension Image where P == Intensity, T == Bool {
    public func im2col(patchWidth: Int,
                       patchHeight: Int,
                       padding: Padding<T> = .nearest) -> (m: Int, n: Int, matrix: [T]) {
        return _im2col(patchWidth: patchWidth,
                       patchHeight: patchHeight,
                       padding: padding)
    }
}

extension Image where P == Intensity, T == UInt8 {
    public func im2col(patchWidth: Int,
                       patchHeight: Int,
                       padding: Padding<T> = .nearest) -> (m: Int, n: Int, matrix: [T]) {
        return _im2col(patchWidth: patchWidth,
                       patchHeight: patchHeight,
                       padding: padding)
    }
}

extension Image where P == Intensity, T == Int {
    public func im2col(patchWidth: Int,
                       patchHeight: Int,
                       padding: Padding<T> = .nearest) -> (m: Int, n: Int, matrix: [T]) {
        return _im2col(patchWidth: patchWidth,
                       patchHeight: patchHeight,
                       padding: padding)
    }
}

extension Image where P == Intensity, T == Float {
    public func im2col(patchWidth: Int,
                       patchHeight: Int,
                       padding: Padding<T> = .nearest) -> (m: Int, n: Int, matrix: [T]) {
        return _im2col(patchWidth: patchWidth,
                       patchHeight: patchHeight,
                       padding: padding)
    }
}

extension Image where P == Intensity, T == Double {
    public func im2col(patchWidth: Int,
                       patchHeight: Int,
                       padding: Padding<T> = .nearest) -> (m: Int, n: Int, matrix: [T]) {
        return _im2col(patchWidth: patchWidth,
                       patchHeight: patchHeight,
                       padding: padding)
    }
}

