import Foundation
import CStbImage

// MARK: Utilities
@usableFromInline
struct STBImageData {
    @usableFromInline var width: Int
    @usableFromInline var height: Int
    @usableFromInline var bpp: Int
    @usableFromInline var data: [UInt8]
    
    @inlinable
    init(width: Int, height: Int, bpp: Int, data: [UInt8]) {
        self.width = width
        self.height = height
        self.bpp = bpp
        self.data = data
    }
}

// MARK: - UInt8

extension Image where P == Gray, T == UInt8 {
    @inlinable
    init(stbImageData: STBImageData) throws {
        guard stbImageData.bpp == 1 else {
            throw ImageReadError.pixelTypeMismatch(detectedChannels: stbImageData.bpp)
        }
        
        self.init(width: stbImageData.width, height: stbImageData.height, data: stbImageData.data)
    }
}

extension Image where P == GrayAlpha, T == UInt8 {
    @inlinable
    init(stbImageData: STBImageData) throws {
        switch stbImageData.bpp {
        case 1:
            let gray = Image<Gray, UInt8>(width: stbImageData.width,
                                          height: stbImageData.height,
                                          data: stbImageData.data)
            self = gray.toGrayAlpha(with: UInt8.max)
        case 2:
            self.init(width: stbImageData.width, height: stbImageData.height, data: stbImageData.data)
        default:
            throw ImageReadError.pixelTypeMismatch(detectedChannels: stbImageData.bpp)
        }
    }
}

extension Image where P == RGB, T == UInt8 {
    @inlinable
    init(stbImageData: STBImageData) throws {
        switch stbImageData.bpp {
        case 1:
            let gray = Image<Gray, UInt8>(width: stbImageData.width,
                                          height: stbImageData.height,
                                          data: stbImageData.data)
            self = gray.toRGB()
        case 3:
            self.init(width: stbImageData.width, height: stbImageData.height, data: stbImageData.data)
        default:
            throw ImageReadError.pixelTypeMismatch(detectedChannels: stbImageData.bpp)
        }
    }
}

extension Image where P == RGBA, T == UInt8 {
    @inlinable
    init(stbImageData: STBImageData) throws {
        switch stbImageData.bpp {
        case 1:
            let gray = Image<Gray, UInt8>(width: stbImageData.width,
                                          height: stbImageData.height,
                                          data: stbImageData.data)
            self = gray.toRGBA(with: UInt8.max)
        case 2:
            let ia = Image<GrayAlpha, UInt8>(width: stbImageData.width,
                                                  height: stbImageData.height,
                                                  data: stbImageData.data)
            self.init(r: ia[channel: .gray],
                      g: ia[channel: .gray],
                      b: ia[channel: .gray],
                      a: ia[channel: .alpha])
        case 3:
            let rgb = Image<RGB, UInt8>(width: stbImageData.width,
                                        height: stbImageData.height,
                                        data: stbImageData.data)
            self = rgb.toRGBA(with: UInt8.max)
        case 4:
            self.init(width: stbImageData.width, height: stbImageData.height, data: stbImageData.data)
        default:
            throw ImageReadError.pixelTypeMismatch(detectedChannels: stbImageData.bpp)
        }
    }
}
