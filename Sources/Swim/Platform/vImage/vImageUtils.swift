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
    
    public static let noFlags = vImageProcessingFlag(rawValue: 0b0)
    public static let leaveAlphaUnchanged = vImageProcessingFlag(rawValue: 0b1)
    public static let doNotTile = vImageProcessingFlag(rawValue: 0b10000)
    public static let highQualityResampling = vImageProcessingFlag(rawValue: 0b100000)
    public static let getTempBufferSize = vImageProcessingFlag(rawValue: 0b10000000)
    public static let printDiagnosticsToConsole = vImageProcessingFlag(rawValue: 0b100000000)
    public static let noAllocate = vImageProcessingFlag(rawValue: 0b1000000000)
    public static let hdrContent = vImageProcessingFlag(rawValue: 0b10000000000)
    public static let doNotClamp = vImageProcessingFlag(rawValue: 0b100000000000)
    public static let copyInPlace = vImageProcessingFlag(rawValue: 0b10)
    public static let backgroundColorFill = vImageProcessingFlag(rawValue: 0b100)
    public static let edgeExtend = vImageProcessingFlag(rawValue: 0b1000)
    public static let truncateKernel = vImageProcessingFlag(rawValue: 0b1000000)
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
    public static func validateErrorCode(_ errorCode: Int) throws {
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
