import Foundation
import CStbImage

public struct TextImageMetrics {
    public let text: String
    
    // size in pixel
    public let width: Int
    public let height: Int
    
    // Unscaled sizes
    public let ascent: Int32
    public let descent: Int32
    public let lineGap: Int32
    
    // scale = fontSize / (ascent - descent)
    public let scale: Float
    
    public init(text: String, width: Int, height: Int,
                ascent: Int32, descent: Int32, lineGap: Int32, scale: Float) {
        self.text = text
        self.width = width
        self.height = height
        self.ascent = ascent
        self.descent = descent
        self.lineGap = lineGap
        self.scale = scale
    }
}

public enum TrueTypeFontError: Error {
    case failedToLoad
    case fontIndexOutOfRange
}

public struct TrueTypeFont {
    @usableFromInline
    let info: stbtt_fontinfo
    
    public let fontSize: Float
    
    /// Create font with font file(ttf/ttc) and fontSize in pixel.
    /// - Parameters:
    ///   - url: URL of ttf/ttc file.
    ///   - fontIndex: Index of font in ttc file. If file is ttf, set 0. Default: 0.
    ///   - fontSize: Font size in pixel.
    public init(url: URL,
                fontIndex: Int = 0,
                fontSize: Float) throws {
        
        precondition(fontSize > 0, "Font size must be greater than 0.")
        
        var info = stbtt_fontinfo()
        let bytes = try Data(contentsOf: url)
        
        let result = try bytes.withUnsafeBytes { p -> Int32 in
            let uint8p = p.bindMemory(to: UInt8.self)
            
            let numFonts = Int(get_number_of_fonts(uint8p.baseAddress!))
            
            guard 0 <= fontIndex && fontIndex < numFonts else {
                throw TrueTypeFontError.fontIndexOutOfRange
            }
            
            return init_font(&info, uint8p.baseAddress!, Int32(fontIndex))
        }
        
        guard result != 0 else {
            throw TrueTypeFontError.failedToLoad
        }
        
        self.info = info
        self.fontSize = fontSize
    }
}

@inlinable
func getCodepoint(char: Character) -> Int32 {
    return Int32(char.unicodeScalars.reduce(0) { acc, v in (acc << 8) | v.value })
}

extension Image where P == Gray, T == UInt8 {
    /// Compute size of bounding box which covers text.
    ///
    /// - Parameters:
    ///   - lineGap: Gap between lines in pixel. If nil, proper size will be used. Default: nil.
    @inlinable
    public static func getTextImageSize(text: String,
                                        font: TrueTypeFont,
                                        lineGap: Int? = nil) -> (width: Int, height: Int) {
        let metrics = getTextImageMetrics(text: text, font: font)
        return (metrics.width, metrics.height)
    }
    
    /// Get text image metrics
    ///
    /// - Parameters:
    ///   - lineGap: Gap between lines in pixel. If nil, proper size will be used. Default: nil.
    @inlinable
    public static func getTextImageMetrics(text: String,
                                           font: TrueTypeFont,
                                           lineGap: Int? = nil) -> TextImageMetrics {
        precondition(lineGap ?? Int.max >= 0, "lineGap must be positive.")
        var ascent: Int32 = 0
        var descent: Int32 = 0
        var autoLineGap: Int32 = 0
        
        get_vmetrics(font.info, &ascent, &descent, &autoLineGap)
        
        let scale = font.fontSize / Float(ascent - descent)
        
        // unscaled lineGap
        let lineGap: Int32 = lineGap.map { Int32(Float($0) / scale) } ?? autoLineGap
        
        let lineHeight = Int(Float(ascent - descent)*scale)
        
        var maxWidth = 0
        var lineNum = 0
        
        var lastLineHeight = 0
        text.enumerateLines { line, _ in
            lineNum += 1
            
            var width = 0
            var actualLineHeight = lineHeight
            
            let codepoints = line.map(getCodepoint)
            
            for i in 0..<codepoints.count {
                var ix0: Int32 = 0
                var iy0: Int32 = 0
                var ix1: Int32 = 0
                var iy1: Int32 = 0
                get_codepoint_bitmap_box(font.info, codepoints[i], scale, &ix0, &iy0, &ix1, &iy1)
                
                var advanceWidth: Int32 = 0
                var leftSideBearing: Int32 = 0
                get_hmetrics(font.info, codepoints[i], &advanceWidth, &leftSideBearing)
                
                // iy1 is height below baseline
                let charHeight = Int(Float(ascent)*scale) + Int(iy1)
                actualLineHeight = max(charHeight, actualLineHeight)
                
                width += Int(Float(advanceWidth) * scale)
                
                // kerning
                if i < codepoints.count-1 {
                    let kern = get_kern(font.info, codepoints[i], codepoints[i+1])
                    width -= Int(Float(kern) * scale)
                }
            }
            
            maxWidth = max(width, maxWidth)
            lastLineHeight = actualLineHeight
        }
        
        /// Some characters can protrule beyond lineHeight.
        /// All lines but last line has lineGap and below line so protrusion is OK.
        /// Only last line we have to consider its actual height.
        let height = (lineNum-1) * (lineHeight + Int(Float(lineGap) * scale)) + lastLineHeight
        
        return TextImageMetrics(text: text, width: maxWidth, height: height,
                                ascent: ascent, descent: descent, lineGap: lineGap, scale: scale)
    }
    
    /// Create image contains specified text.
    ///
    /// - Parameters:
    ///   - lineGap: Gap between lines in pixel. If nil, proper size will be used. Default: nil.
    @inlinable
    public static func createTextImage(text: String,
                                       font: TrueTypeFont,
                                       lineGap: Int? = nil) -> Image {
        precondition(lineGap ?? Int.max >= 0, "lineGap must be positive.")
        let metrics = getTextImageMetrics(text: text, font: font, lineGap: lineGap)
        var image = Image<Gray, UInt8>(width: metrics.width, height: metrics.height, value: 0)
        
        let scale = metrics.scale
        
        var y = 0
        text.enumerateLines { line, _ in
            let codepoints = line.map(getCodepoint)
            
            var x = 0
            
            for i in 0..<codepoints.count {
                var ix0: Int32 = 0
                var iy0: Int32 = 0
                var ix1: Int32 = 0
                var iy1: Int32 = 0
                get_codepoint_bitmap_box(font.info, codepoints[i], scale, &ix0, &iy0, &ix1, &iy1)
                
                var advanceWidth: Int32 = 0
                var leftSideBearing: Int32 = 0
                get_hmetrics(font.info, codepoints[i], &advanceWidth, &leftSideBearing)
                
                let xx = x + Int(Float(leftSideBearing)*scale)
                let yy = y + Int(Float(metrics.ascent)*scale) + Int(iy0)
                let dataOffset = image.dataIndex(x: xx, y: yy)
                let w = ix1-ix0
                let h = iy1-iy0
                image.data.withUnsafeMutableBufferPointer { bp in
                    let p = bp.baseAddress!.advanced(by: dataOffset)
                    make_codepoint_bitmap(font.info, p, w, h, Int32(metrics.width), scale, codepoints[i])
                }
                
                x += Int(Float(advanceWidth)*scale)
                
                // kerning
                if i < codepoints.count-1 {
                    let kern = get_kern(font.info, codepoints[i], codepoints[i+1])
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

// MARK: - Color image creation
extension Image where P: HasAlpha, T: BinaryInteger {
    /// Create image contains specified text/color.
    ///
    /// - Parameters:
    ///   - lineGap: Gap between lines in pixel. If nil, proper size will be used. Default: nil.
    @inlinable
    public static func createTextImage(text: String,
                                       font: TrueTypeFont,
                                       lineGap: Int? = nil,
                                       color: Pixel<P, T>) -> Image {
        let grayImage = Image<Gray, UInt8>.createTextImage(text: text, font: font, lineGap: lineGap)
        
        var colorImage = Image<P, T>.zeros(like: grayImage)
        
        colorImage.pixelwiseConvert { ref in
            let grayValue = grayImage[ref.x, ref.y, .gray]
            guard grayValue > 0 else {
                return
            }
            ref.setColor(pixel: color)
            let alpha = T(Int(ref[P.alphaIndex]) * Int(grayValue) / 255)
            ref[P.alphaIndex] = alpha
        }
        
        return colorImage
    }
}

extension Image where P: HasAlpha, T: BinaryFloatingPoint {
    /// Create image contains specified text/color.
    ///
    /// - Parameters:
    ///   - lineGap: Gap between lines in pixel. If nil, proper size will be used. Default: nil.
    @inlinable
    public static func createTextImage(text: String,
                                       font: TrueTypeFont,
                                       lineGap: Int? = nil,
                                       color: Pixel<P, T>) -> Image {
        let grayImage = Image<Gray, UInt8>.createTextImage(text: text, font: font, lineGap: lineGap)
        
        var colorImage = Image<P, T>.zeros(like: grayImage)
        
        colorImage.pixelwiseConvert { ref in
            let grayValue = grayImage[ref.x, ref.y, .gray]
            guard grayValue > 0 else {
                return
            }
            ref.setColor(pixel: color)
            ref[P.alphaIndex] *= T(grayValue) / 255
        }
        
        return colorImage
    }
}

// MARK: - Draw method
extension Image where P: NoAlpha, T: BinaryInteger {
    /// Draw text in image.
    ///
    /// If you want to know the size of text area in advance, use `getTextImageSize`.
    @inlinable
    public mutating func drawText<P2: HasAlpha>(origin: (x: Int, y: Int),
                                                text: String,
                                                font: TrueTypeFont,
                                                lineGap: Int? = nil,
                                                color: Pixel<P2, T>) where P2.BaseType == P {
        guard origin.x < width && origin.y < height else {
            // Drawing area is out of image.
            return
        }
        let colorImage = Image<P2, T>.createTextImage(text: text,
                                                      font: font,
                                                      lineGap: lineGap,
                                                      color: color)
        drawImage(origin: origin, image: colorImage)
    }
}

extension Image where P: NoAlpha, T: BinaryFloatingPoint {
    /// Draw text in image.
    ///
    /// If you want to know the size of text area in advance, use `getTextImageSize`.
    @inlinable
    public mutating func drawText<P2: HasAlpha>(origin: (x: Int, y: Int),
                                                text: String,
                                                font: TrueTypeFont,
                                                lineGap: Int? = nil,
                                                color: Pixel<P2, T>) where P2.BaseType == P {
        guard origin.x < width && origin.y < height else {
            // Drawing area is out of image.
            return
        }
        let colorImage = Image<P2, T>.createTextImage(text: text,
                                                      font: font,
                                                      lineGap: lineGap,
                                                      color: color)
        drawImage(origin: origin, image: colorImage)
    }
}

extension Image where P: HasAlpha, T: BinaryInteger {
    /// Draw text in image.
    ///
    /// If you want to know the size of text area in advance, use `getTextImageSize`.
    @inlinable
    public mutating func drawText(origin: (x: Int, y: Int),
                                  text: String,
                                  font: TrueTypeFont,
                                  lineGap: Int? = nil,
                                  color: Pixel<P, T>) {
        guard origin.x < width && origin.y < height else {
            // Drawing area is out of image.
            return
        }
        let colorImage = Image<P, T>.createTextImage(text: text,
                                                     font: font,
                                                     lineGap: lineGap,
                                                     color: color)
        drawImage(origin: origin, image: colorImage)
    }
}


extension Image where P: HasAlpha, T: BinaryFloatingPoint {
    /// Draw text in image.
    ///
    /// If you want to know the size of text area in advance, use `getTextImageSize`.
    @inlinable
    public mutating func drawText(origin: (x: Int, y: Int),
                                  text: String,
                                  font: TrueTypeFont,
                                  lineGap: Int? = nil,
                                  color: Pixel<P, T>) {
        guard origin.x < width && origin.y < height else {
            // Drawing area is out of image.
            return
        }
        let colorImage = Image<P, T>.createTextImage(text: text,
                                                     font: font,
                                                     lineGap: lineGap,
                                                     color: color)
        drawImage(origin: origin, image: colorImage)
    }
}
