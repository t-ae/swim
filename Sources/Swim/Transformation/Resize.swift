
import Foundation
import CStbImage

extension Image where T == UInt8 {
    public func resized(width: Int, height: Int) -> Image<P, T>? {
        var newImage = Image<P, T>(width: width, height: height)
        let in_w = Int32(self.width)
        let in_h = Int32(self.height)
        let out_w = Int32(width)
        let out_h = Int32(height)
        let num_channels = Int32(P.channels)
        let result: Int32 = data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            return newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                return resize_uint8(src, in_w, in_h, dst, out_w, out_h, num_channels)
            }
        }
        
        if result == 1 {
            return newImage
        } else {
            return nil
        }
    }
}

extension Image where T == Float {
    public func resized(width: Int, height: Int) -> Image<P, T>? {
        var newImage = Image<P, T>(width: width, height: height)
        let in_w = Int32(self.width)
        let in_h = Int32(self.height)
        let out_w = Int32(width)
        let out_h = Int32(height)
        let num_channels = Int32(P.channels)
        let result: Int32 = data.withUnsafeBufferPointer {
            let src = $0.baseAddress!
            return newImage.data.withUnsafeMutableBufferPointer {
                let dst = $0.baseAddress!
                return resize_float(src, in_w, in_h, dst, out_w, out_h, num_channels)
            }
        }
        
        if result == 1 {
            return newImage
        } else {
            return nil
        }
    }
}

extension Image {
    /// Resize image with Narest Neighbor algorithm.
    public func resizenn(width: Int, height: Int) -> Image<P, T> {
        var newImage = Image<P, T>(width: width, height: height)
        
        let scaleX = Double(width) / Double(self.width)
        let scaleY = Double(height) / Double(self.height)
        
        for y in 0..<height {
            for x in 0..<width {
                let xp = min(Int(Foundation.round(Double(x) / scaleX)), self.width - 1)
                let yp = min(Int(Foundation.round(Double(y) / scaleY)), self.height - 1)
                
                newImage[x, y] = self[xp, yp]
            }
        }
        
        return newImage
    }
}
