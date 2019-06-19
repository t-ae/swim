#if canImport(Accelerate)

import Accelerate

public enum vImageUtils {
}

// MARK: - Processing Flags
public struct vImageProcessingFlag: OptionSet {
    public let rawValue: Int
    
    public init(rawValue: Int) {
        self.rawValue = rawValue
    }
    
    public var vImage_Flags: vImage_Flags {
        return Accelerate.vImage_Flags(rawValue)
    }
    
    public static let noFlags = vImageProcessingFlag(rawValue: kvImageNoFlags)
    public static let leaveAlphaUnchanged = vImageProcessingFlag(rawValue: kvImageLeaveAlphaUnchanged)
    public static let doNotTile = vImageProcessingFlag(rawValue: kvImageDoNotTile)
    public static let highQualityResampling = vImageProcessingFlag(rawValue: kvImageHighQualityResampling)
    public static let getTempBufferSize = vImageProcessingFlag(rawValue: kvImageGetTempBufferSize)
    public static let printDiagnosticsToConsole = vImageProcessingFlag(rawValue: kvImagePrintDiagnosticsToConsole)
    public static let noAllocate = vImageProcessingFlag(rawValue: kvImageNoAllocate)
    public static let doNotClamp = vImageProcessingFlag(rawValue: kvImageDoNotTile)
    public static let copyInPlace = vImageProcessingFlag(rawValue: kvImageCopyInPlace)
    public static let backgroundColorFill = vImageProcessingFlag(rawValue: kvImageBackgroundColorFill)
    public static let edgeExtend = vImageProcessingFlag(rawValue: kvImageEdgeExtend)
    public static let truncateKernel = vImageProcessingFlag(rawValue: kvImageTruncateKernel)
    
    @available(iOS 9.0, *)
    @available(OSX 10.11, *)
    public static let hdrContent = vImageProcessingFlag(rawValue: kvImageHDRContent)
}

// MARK: - Error
public enum vImageError: Error {
    case roiLargerThanInputBuffer
    case invalidKernelSize
    case invalidEdgeStyle
    case invalidOffsetX
    case invalidOffsetY
    case memoryAllocationError
    case nullPointerArgument
    case invalidParameter
    case bufferSizeMismatch
    case unknownFlagBit
    case colorSyncIsAbsent
    case coreVideoIsAbsent
    case internalError
    case invalidCVImageFormat
    case invalidImageFormat
    case invalidImageObject
    case invalidRowBytes
    case outOfPlaceOperationRequired
    case unsupportedConversion
    case other(errorCode: Int)
}

extension vImageUtils {
    /// Check `vImage_Error` which vImage operations returned.
    ///
    /// If `errorCode` is `kvImageNoError`, this does nothing.
    /// Otherwise, corresponding `vImageError` is thrown.
    public static func validateErrorCode(_ errorCode: vImage_Error) throws {
        switch errorCode {
        case kvImageNoError:
            return
        case kvImageRoiLargerThanInputBuffer:
            throw vImageError.roiLargerThanInputBuffer
        case kvImageInvalidKernelSize:
            throw vImageError.invalidKernelSize
        case kvImageInvalidEdgeStyle:
            throw vImageError.invalidEdgeStyle
        case kvImageInvalidOffset_X:
            throw vImageError.invalidOffsetX
        case kvImageInvalidOffset_Y:
            throw vImageError.invalidOffsetY
        case kvImageMemoryAllocationError:
            throw vImageError.memoryAllocationError
        case kvImageNullPointerArgument:
            throw vImageError.nullPointerArgument
        case kvImageInvalidParameter:
            throw vImageError.invalidParameter
        case kvImageBufferSizeMismatch:
            throw vImageError.bufferSizeMismatch
        case kvImageUnknownFlagsBit:
            throw vImageError.unknownFlagBit
        case kvImageColorSyncIsAbsent:
            throw vImageError.colorSyncIsAbsent
        case kvImageCoreVideoIsAbsent:
            throw vImageError.coreVideoIsAbsent
        case kvImageInternalError:
            throw vImageError.internalError
        case kvImageInvalidCVImageFormat:
            throw vImageError.invalidCVImageFormat
        case kvImageInvalidImageFormat:
            throw vImageError.invalidImageFormat
        case kvImageInvalidImageObject:
            throw vImageError.invalidImageObject
        case kvImageInvalidRowBytes:
            throw vImageError.invalidRowBytes
        case kvImageOutOfPlaceOperationRequired:
            throw vImageError.outOfPlaceOperationRequired
        case kvImageUnsupportedConversion:
            throw vImageError.unsupportedConversion
        default:
            throw vImageError.other(errorCode: errorCode)
        }
    }
}

#endif
