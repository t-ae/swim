import Foundation
import CStbImage

public struct TextImageMetrics {
    public let text: String
    
    public let width: Int
    public let height: Int
    
    public let ascent: Int32
    public let descent: Int32
    public let lineGap: Int32
    
    public let scale: Float
}

public enum TrueTypeFontError: Error {
    case failedToLoad
}

public struct TrueTypeFont {
    let info: stbtt_fontinfo
    let fontSize: Float
    
    /// Create font with font file(ttf/ttc) and fontSize in pixel.
    public init(url: URL, fontSize: Float) throws {
        var info = stbtt_fontinfo()
        let bytes = try Data(contentsOf: url)
        let result = bytes.withUnsafeBytes { p in
            init_font(&info, p.bindMemory(to: UInt8.self).baseAddress!)
        }
        
        guard result != 0 else {
            throw TrueTypeFontError.failedToLoad
        }
        
        self.info = info
        self.fontSize = fontSize
    }
    
    public func getTextImageMetrics(text: String) -> TextImageMetrics {
        var ascent: Int32 = 0
        var descent: Int32 = 0
        var lineGap: Int32 = 0
        
        get_vmetrics(info, &ascent, &descent, &lineGap)
        
        let scale = fontSize / Float(ascent - descent)
        
        let lineHeight = Int(Float(ascent - descent)*scale)
        
        var maxWidth = 0
        var lineNum = 0
        
        text.enumerateLines { line, _ in
            lineNum += 1
            
            var width = 0
            
            let codepoints = line.map { c in
                Int32(c.unicodeScalars.reduce(0) { acc, v in acc << 8 + v.value })
            }
            
            for i in 0..<codepoints.count {
                var advanceWidth: Int32 = 0
                var leftSideBearing: Int32 = 0
                get_hmetrics(self.info, codepoints[i], &advanceWidth, &leftSideBearing)
                
                width += Int(Float(advanceWidth) * scale)
                
                // kerning
                if i < codepoints.count-1 {
                    let kern = get_kern(self.info, codepoints[i], codepoints[i+1])
                    width -= Int(Float(kern) * scale)
                }
            }
            
            maxWidth = max(width, maxWidth)
        }
        
        // FIXME: we don't need lineGap for last line.
        // But some characters, like `q`, are renderd beyond descent.
        // So lineGap is added for last line.
        let height = lineNum * lineHeight + (lineNum-0) * Int(Float(lineGap) * scale)
        
        return TextImageMetrics(text: text, width: maxWidth, height: height,
                                ascent: ascent, descent: descent, lineGap: lineGap, scale: scale)
    }
    
    public func createTextImage(text: String) -> Image<Gray, UInt8> {
        let metrics = getTextImageMetrics(text: text)
        var image = Image<Gray, UInt8>(width: metrics.width, height: metrics.height, value: 0)
        
        let scale = metrics.scale
        
        var y = 0
        text.enumerateLines { line, _ in
            let codepoints = line.map { c in
                Int32(c.unicodeScalars.reduce(0) { acc, v in acc << 8 + v.value })
            }
            
            var x = 0
            
            for i in 0..<codepoints.count {
                var ix0: Int32 = 0
                var iy0: Int32 = 0
                var ix1: Int32 = 0
                var iy1: Int32 = 0
                get_codepoint_bitmap_box(self.info, codepoints[i], scale, &ix0, &iy0, &ix1, &iy1)
                
                var advanceWidth: Int32 = 0
                var leftSideBearing: Int32 = 0
                get_hmetrics(self.info, codepoints[i], &advanceWidth, &leftSideBearing)
                
                let xx = x + Int(Float(leftSideBearing)*scale)
                let yy = y + Int(Float(metrics.ascent)*scale) + Int(iy0)
                let dataOffset = image.dataIndex(x: xx, y: yy)
                let w = ix1-ix0
                let h = iy1-iy0
                image.data.withUnsafeMutableBufferPointer { bp in
                    let p = bp.baseAddress!.advanced(by: dataOffset)
                    make_codepoint_bitmap(self.info, p, w, h, Int32(metrics.width), scale, codepoints[i])
                }
                
                x += Int(Float(advanceWidth)*scale)
                
                // kerning
                if i < codepoints.count-1 {
                    let kern = get_kern(self.info, codepoints[i], codepoints[i+1])
                    x -= Int(Float(kern) * scale)
                }
            }
            
            // advance line
            y += Int(Float(metrics.ascent - metrics.descent) * scale)
            y += Int(Float(metrics.lineGap) * scale)
        }
        
        return image
    }
}

extension Image {
    /// Compute size of bounding box which covers text.
    @inlinable
    public func getTextSize(text: String,
                            font: TrueTypeFont) -> (width: Int, height: Int) {
        let metrics = font.getTextImageMetrics(text: text)
        return (metrics.width, metrics.height)
    }
}

extension Image where P: NoAlpha, T: BinaryFloatingPoint {
    /// Draw text in image.
    ///
    /// If you want to know the size of text area in advance, `use getTextSize`.
    @inlinable
    public mutating func drawText<P2: HasAlpha>(origin: (x: Int, y: Int),
                                                text: String,
                                                font: TrueTypeFont,
                                                pixel: Pixel<P2, T>) where P2.BaseType == P {
        let grayImage = font.createTextImage(text: text)
        
        var colorImage = Image<P2, T>.full(pixel: pixel, like: grayImage)
        
        for y in 0..<grayImage.height {
            for x in 0..<grayImage.width {
                let grayValue = grayImage[x, y, .gray]
                colorImage[x, y, P2.alphaIndex] *= T(grayValue) / 255
            }
        }
        
        drawImage(origin: origin, image: colorImage)
    }
}

extension Image where P: HasAlpha, T: BinaryFloatingPoint {
    /// Draw text in image.
    ///
    /// If you want to know the size of text area in advance, `use getTextSize`.
    @inlinable
    public mutating func drawText(origin: (x: Int, y: Int),
                                  text: String,
                                  font: TrueTypeFont,
                                  pixel: Pixel<P, T>) {
        let grayImage = font.createTextImage(text: text)
        
        var colorImage = Image<P, T>.full(pixel: pixel, like: grayImage)
        
        for y in 0..<grayImage.height {
            for x in 0..<grayImage.width {
                let grayValue = grayImage[x, y, .gray]
                colorImage[x, y, P.alphaIndex] *= T(grayValue) / 255
            }
        }
        
        drawImage(origin: origin, image: colorImage)
    }
}