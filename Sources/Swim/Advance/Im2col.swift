extension Image where P == Gray {
    /// im2col.
    ///
    /// - Returns:
    ///   - matrix: Each column is patch.
    ///
    /// - Note: This method doesn't support padding.
    /// If you need padding, use `withPadding` beforehand.
    @inlinable
    public func im2col(patchWidth: Int,
                       patchHeight: Int) -> Matrix<T> {
        
        let numPatchX = width-patchWidth+1
        let numPatchY = height-patchHeight+1
        
        let rows = patchWidth*patchHeight
        let cols = numPatchX * numPatchY
        
        let matrix = [T](unsafeUninitializedCapacity: rows*cols) { bp, initializedCount in
            for patchY in 0..<numPatchY {
                for patchX in 0..<numPatchX {
                    let patchIndex = patchY*numPatchX + patchX
                    
                    for y in 0..<patchHeight {
                        for x in 0..<patchWidth {
                            let valueIndex = y * patchWidth + x
                            bp[valueIndex*cols + patchIndex] = self[x+patchX, y+patchY, 0]
                        }
                    }
                }
            }
            initializedCount = bp.count
        }
        
        return Matrix(rows: rows, cols: cols, data: matrix)
    }
    
    /// im2row.
    ///
    /// - Returns:
    ///   - matrix: Each row is patch.
    ///
    /// - Note: This method doesn't support padding.
    /// If you need padding, use `withPadding` beforehand.
    @inlinable
    public func im2row(patchWidth: Int,
                       patchHeight: Int) -> Matrix<T> {
        
        let numPatchX = width-patchWidth+1
        let numPatchY = height-patchHeight+1
        
        let rows = numPatchX * numPatchY
        let cols = patchWidth*patchHeight
        
        let matrix = [T](unsafeUninitializedCapacity: rows*cols) { bp, initializedCount in
            for patchY in 0..<numPatchY {
                for patchX in 0..<numPatchX {
                    let patchIndex = patchY*numPatchX + patchX
                    
                    for y in 0..<patchHeight {
                        for x in 0..<patchWidth {
                            let valueIndex = y * patchWidth + x
                            bp[patchIndex*cols + valueIndex] = self[x+patchX, y+patchY, 0]
                        }
                    }
                }
            }
            initializedCount = bp.count
        }
        
        return Matrix(rows: rows, cols: cols, data: matrix)
    }
}
