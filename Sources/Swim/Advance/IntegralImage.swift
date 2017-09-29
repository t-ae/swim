
extension Image where P == Intensity, T: Numeric {
    public func toIntegralImage() -> Image<Intensity, T> {
        var newImage = self
        
        newImage._data.withUnsafeMutableBufferPointer {
            var p = $0.baseAddress! + 1
            
            // First row
            for _ in 1..<width {
                p.pointee += (p-1).pointee
                p += 1
            }
            
            // Rest rows
            var p2 = $0.baseAddress!
            for _ in 1..<height {
                var rowsum: T = 0
                
                for _ in 0..<width {
                    rowsum += p.pointee
                    p.pointee = p2.pointee + rowsum
                    p += 1
                    p2 += 1
                }
            }
        }
        
        return newImage
    }
}
