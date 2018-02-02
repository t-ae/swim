
import Foundation

public enum Shape {}

extension Shape {
    public static func circle<P, T>(size: Int,
                                    lineWidth: Double,
                                    lineColor: Pixel<P, T>,
                                    fillColor: Pixel<P, T>? = nil) -> Image<P, T> {
        
        var image = Image<P, T>(width: size, height: size)
        
        let radius = Double(size-1) / 2
        let outer2 = pow(radius, 2)
        let inner2 = pow(radius - lineWidth, 2)
        
        for y in 0..<size {
            for x in 0..<size {
                let x2 = pow(Double(x)-radius, 2)
                let y2 = pow(Double(y)-radius, 2)
                let d2 = x2 + y2
                
                if d2 <= outer2 {
                    if d2 <= inner2 {
                        if let fillColor = fillColor {
                            image[x, y] = fillColor
                        }
                    } else {
                        image[x, y] = lineColor
                    }
                }
            }
        }
        
        return image
    }
    
    public static func rect<P, T>(width: Int,
                                  height: Int,
                                  lineWidth: Int,
                                  lineColor: Pixel<P, T>,
                                  fillColor: Pixel<P, T>? = nil) -> Image<P, T> {
        var image = Image<P, T>(width: width, height: height)
        
        // line
        image[rows: 0..<lineWidth].fill(lineColor)
        image[rows: height-lineWidth..<height].fill(lineColor)
        image[cols: 0..<lineWidth].fill(lineColor)
        image[cols: width-lineWidth..<width].fill(lineColor)
        
        // inner
        if let fillColor = fillColor {
            image[lineWidth..<width-lineWidth, lineWidth..<height-lineWidth].fill(fillColor)
        }
        
        return image
    }
}
