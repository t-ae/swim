
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
            let yp = min(Int(Foundation.round(Double(y) / scaleY)), self.height - 1)
            
            for x in 0..<width {
                let xp = min(Int(Foundation.round(Double(x) / scaleX)), self.width - 1)
                
                newImage[x, y] = self[xp, yp]
            }
        }
        
        return newImage
    }
}

extension Image where T: BinaryFloatingPoint {
    /// Resize image with Bilinear interpolation.
    public func resizebn(width: Int, height: Int) -> Image<P, T> {
        var newImage = Image<P, T>(width: width, height: height)

        let scaleX = T(width) / T(self.width)
        let scaleY = T(height) / T(self.height)

        for y in 0..<height {
            let yp = T(y) / scaleY
            let yy = Int(Foundation.floor(yp))
            let yy1yp: T = T(yy) + 1 - yp
            let ypyy: T = yp - T(yy)
            
            for x in 0..<width {
                let xp = T(x) / scaleX
                let xx = Int(Foundation.floor(xp))
                let xx1xp: T = T(xx) + 1 - xp
                let xpxx: T = xp - T(xx)

                let plu: Pixel<P, T> = yy1yp * self[xx, yy]
                let pru: Pixel<P, T> = ypyy * self[xx, yy+1]
                let pu: Pixel<P, T> = plu + pru

                let pld: Pixel<P, T> = yy1yp * self[xx+1, yy]
                let prd: Pixel<P, T> = ypyy * self[xx+1, yy+1]
                let pd: Pixel<P, T> = pld + prd

                let px1: Pixel<P, T> = xx1xp * pu
                let px2: Pixel<P, T> = xpxx * pd
                let px: Pixel<P, T> = px1 + px2

                newImage[x, y] = px
            }
        }

        return newImage
    }
}

