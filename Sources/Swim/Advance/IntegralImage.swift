


extension Image where P == Intensity, T: CompoundArithmetics&ExpressibleByIntegerLiteral {
    public func toIntegralImage() -> Image<Intensity, T> {
        var newImage = self
        
        newImage.data.withUnsafeMutableBufferPointer {
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
                // left end
                rowsum += p.pointee
                p.pointee = p2.pointee
                p.pointee += rowsum
                p += 1
                p2 += 1
                
                for _ in 1..<width {
                    rowsum += p.pointee
                    p.pointee = p2.pointee
                    p.pointee += rowsum
                    p += 1
                    p2 += 1
                }
            }
        }
        
        return newImage
    }
}
