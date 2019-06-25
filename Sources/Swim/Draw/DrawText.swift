import Foundation
import CStbImage

public struct TextImageMetrics {
    public let text: String
    
    // size in pixel
    public let lineWidths: [Int]
    public let height: Int
    
    // Unscaled sizes
    public let ascent: Int32
    public let descent: Int32
    public let lineGap: Int32
    
    // scale = fontSize / (ascent - descent)
    public let scale: Float
    
    public init(text: String, lineWidths: [Int], height: Int,
                ascent: Int32, descent: Int32, lineGap: Int32, scale: Float) {
        self.text = text
        self.lineWidths = lineWidths
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

public enum TextAlignment {
    case left, center, right
}

public enum TextAnchor {
    case leftTop
    case centerTop
    case rightTop
    case leftCenter
    case center
    case rightCenter
    case leftBottom
    case centerBottom
    case rightBottom
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

@usableFromInline
enum DrawTextUtils {
    @inlinable
    static func getCodepoint(char: Character) -> Int32 {
        return Int32(char.unicodeScalars.reduce(0) { acc, v in (acc << 8) | v.value })
    }
    
    @inlinable
    static func calculateOrigin(position: (x: Int, y: Int), size: (width: Int, height: Int), anchor: TextAnchor) -> (x: Int, y: Int) {
        let x: Int
        switch anchor {
        case .leftTop, .leftCenter, .leftBottom:
            x = position.x
        case .centerTop, .center, .centerBottom:
            x = position.x - size.width/2
        case .rightTop, .rightCenter, .rightBottom:
            x = position.x - size.width
        }
        let y: Int
        switch anchor {
        case .leftTop, .centerTop, .rightTop:
            y = position.y
        case .leftCenter, .center, .rightCenter:
            y = position.y - size.height/2
        case .leftBottom, .centerBottom, .rightBottom:
            y = position.y - size.height
        }
        
        return (x, y)
    }
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
        return (metrics.lineWidths.max() ?? 0, metrics.height)
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
        
        var lineNum = 0
        var lineWidths: [Int] = []
        
        var lastLineHeight = 0
        text.enumerateLines { line, _ in
            lineNum += 1
            
            var width = 0
            var actualLineHeight = lineHeight
            
            let codepoints = line.map(DrawTextUtils.getCodepoint)
            
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
            
            lineWidths.append(width)
            lastLineHeight = actualLineHeight
        }
        
        /// Some characters can protrule beyond lineHeight.
        /// All lines but last line has lineGap and below line so protrusion is OK.
        /// Only last line we have to consider its actual height.
        let height = max(lineNum-1, 0) * (lineHeight + Int(Float(lineGap) * scale)) + lastLineHeight
        
        return TextImageMetrics(text: text, lineWidths: lineWidths, height: height,
                                ascent: ascent, descent: descent, lineGap: lineGap, scale: scale)
    }
    
    /// Create image contains specified text.
    ///
    /// - Parameters:
    ///   - lineGap: Gap between lines in pixel. If nil, proper size will be used. Default: nil.
    /// - Returns: Image contains text. If width or height is 0, returns nil.
    @inlinable
    public static func createTextImage(text: String,
                                       font: TrueTypeFont,
                                       alignment: TextAlignment,
                                       lineGap: Int? = nil) -> Image? {
        precondition(lineGap ?? Int.max >= 0, "lineGap must be positive.")
        let metrics = getTextImageMetrics(text: text, font: font, lineGap: lineGap)
        let width = metrics.lineWidths.max() ?? 0
        guard width > 0 && metrics.height > 0 else {
            return nil
        }
        var image = Image<Gray, UInt8>(width: width, height: metrics.height, value: 0)
        
        let scale = metrics.scale
        
        var y = 0
        
        var lineNo = 0
        text.enumerateLines { line, _ in
            let codepoints = line.map(DrawTextUtils.getCodepoint)
            
            var x: Int
            switch alignment {
            case .left:
                x = 0
            case .center:
                x = (width - metrics.lineWidths[lineNo]) / 2
            case .right:
                x = width - metrics.lineWidths[lineNo]
            }
            
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
                    make_codepoint_bitmap(font.info, p, w, h, Int32(width), scale, codepoints[i])
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
            
            lineNo += 1
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
    /// - Returns: Image contains text. If width or height is 0, returns nil.
    @inlinable
    public static func createTextImage(text: String,
                                       font: TrueTypeFont,
                                       alignment: TextAlignment,
                                       lineGap: Int? = nil,
                                       color: Color<P, T>) -> Image? {
        guard let grayImage = Image<Gray, UInt8>.createTextImage(text: text,
                                                                 font: font,
                                                                 alignment: alignment,
                                                                 lineGap: lineGap)
            else {
                return nil
        }
        
        var colorImage = Image<P, T>.zeros(like: grayImage)
        
        colorImage.unsafePixelwiseConvert { ref in
            let grayValue = grayImage[ref.x, ref.y, .gray]
            guard grayValue > 0 else {
                return
            }
            ref.setColor(color: color)
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
    ///   - alignment: Text alignment. Default: .left.
    ///   - lineGap: Gap between lines in pixel. If nil, proper size will be used. Default: nil.
    /// - Returns: Image contains text. If width or height is 0, returns nil.
    @inlinable
    public static func createTextImage(text: String,
                                       font: TrueTypeFont,
                                       alignment: TextAlignment = .left,
                                       lineGap: Int? = nil,
                                       color: Color<P, T>) -> Image? {
        guard let grayImage = Image<Gray, UInt8>.createTextImage(text: text,
                                                                 font: font,
                                                                 alignment: alignment,
                                                                 lineGap: lineGap)
            else {
                return nil
        }
        
        var colorImage = Image<P, T>.zeros(like: grayImage)
        
        colorImage.unsafePixelwiseConvert { ref in
            let grayValue = grayImage[ref.x, ref.y, .gray]
            guard grayValue > 0 else {
                return
            }
            ref.setColor(color: color)
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
    ///
    /// - Parameters:
    ///   - alignment: Text alignment. Default: .left.
    ///   - anchor: Specify where the `position` is in text bounding box. Default: .leftTop.
    ///   - lineGap: Gap between lines in pixel. If nil, proper size will be used. Default: nil.
    @inlinable
    public mutating func drawText<P2: HasAlpha>(position: (x: Int, y: Int),
                                                text: String,
                                                font: TrueTypeFont,
                                                alignment: TextAlignment = .left,
                                                anchor: TextAnchor = .leftTop,
                                                lineGap: Int? = nil,
                                                color: Color<P2, T>,
                                                backgroundColor: Color<P2, T>? = nil) where P2.BaseType == P {
        guard let colorImage = Image<P2, T>.createTextImage(text: text,
                                                            font: font,
                                                            alignment: alignment,
                                                            lineGap: lineGap,
                                                            color: color)
            else {
                return
        }
        let origin = DrawTextUtils.calculateOrigin(position: position, size: colorImage.size, anchor: anchor)
        
        if let backgroundColor = backgroundColor {
            let bg = Image<P2, T>.full(color: backgroundColor, like: colorImage)
            drawImage(origin: origin, image: bg)
        }
        drawImage(origin: origin, image: colorImage)
    }
}

extension Image where P: NoAlpha, T: BinaryFloatingPoint {
    /// Draw text in image.
    ///
    /// If you want to know the size of text area in advance, use `getTextImageSize`.
    ///
    /// - Parameters:
    ///   - alignment: Text alignment. Default: .left.
    ///   - anchor: Specify where the `position` is in text bounding box. Default: .leftTop.
    ///   - lineGap: Gap between lines in pixel. If nil, proper size will be used. Default: nil.
    @inlinable
    public mutating func drawText<P2: HasAlpha>(position: (x: Int, y: Int),
                                                text: String,
                                                font: TrueTypeFont,
                                                alignment: TextAlignment = .left,
                                                anchor: TextAnchor = .leftTop,
                                                lineGap: Int? = nil,
                                                color: Color<P2, T>,
                                                backgroundColor: Color<P2, T>? = nil) where P2.BaseType == P {
        guard let colorImage = Image<P2, T>.createTextImage(text: text,
                                                            font: font,
                                                            alignment: alignment,
                                                            lineGap: lineGap,
                                                            color: color)
            else {
                return
        }
        let origin = DrawTextUtils.calculateOrigin(position: position, size: colorImage.size, anchor: anchor)
        
        if let backgroundColor = backgroundColor {
            let bg = Image<P2, T>.full(color: backgroundColor, like: colorImage)
            drawImage(origin: origin, image: bg)
        }
        drawImage(origin: origin, image: colorImage)
    }
}

extension Image where P: HasAlpha, T: BinaryInteger {
    /// Draw text in image.
    ///
    /// If you want to know the size of text area in advance, use `getTextImageSize`.
    ///
    /// - Parameters:
    ///   - alignment: Text alignment. Default: .left.
    ///   - anchor: Specify where the `position` is in text bounding box. Default: .leftTop.
    ///   - lineGap: Gap between lines in pixel. If nil, proper size will be used. Default: nil.
    @inlinable
    public mutating func drawText(position: (x: Int, y: Int),
                                  text: String,
                                  font: TrueTypeFont,
                                  alignment: TextAlignment = .left,
                                  anchor: TextAnchor = .leftTop,
                                  lineGap: Int? = nil,
                                  color: Color<P, T>,
                                  backgroundColor: Color<P, T>? = nil) {
        guard let colorImage = Image<P, T>.createTextImage(text: text,
                                                           font: font,
                                                           alignment: alignment,
                                                           lineGap: lineGap,
                                                           color: color)
            else {
                return
        }
        let origin = DrawTextUtils.calculateOrigin(position: position, size: colorImage.size, anchor: anchor)
        
        if let backgroundColor = backgroundColor {
            let bg = Image.full(color: backgroundColor, like: colorImage)
            drawImage(origin: origin, image: bg)
        }
        drawImage(origin: origin, image: colorImage)
    }
}


extension Image where P: HasAlpha, T: BinaryFloatingPoint {
    /// Draw text in image.
    ///
    /// If you want to know the size of text area in advance, use `getTextImageSize`.
    ///
    /// - Parameters:
    ///   - alignment: Text alignment. Default: .left.
    ///   - anchor: Specify where the `position` is in text bounding box. Default: .leftTop.
    ///   - lineGap: Gap between lines in pixel. If nil, proper size will be used. Default: nil.
    @inlinable
    public mutating func drawText(position: (x: Int, y: Int),
                                  text: String,
                                  font: TrueTypeFont,
                                  alignment: TextAlignment = .left,
                                  anchor: TextAnchor = .leftTop,
                                  lineGap: Int? = nil,
                                  color: Color<P, T>,
                                  backgroundColor: Color<P, T>? = nil) {
        guard let colorImage = Image<P, T>.createTextImage(text: text,
                                                           font: font,
                                                           alignment: alignment,
                                                           lineGap: lineGap,
                                                           color: color)
            else {
                return
        }
        let origin = DrawTextUtils.calculateOrigin(position: position, size: colorImage.size, anchor: anchor)
        
        if let backgroundColor = backgroundColor {
            let bg = Image.full(color: backgroundColor, like: colorImage)
            drawImage(origin: origin, image: bg)
        }
        drawImage(origin: origin, image: colorImage)
    }
}
