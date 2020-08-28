public enum ImageReadError: Error {
    case fileNotFound
    case failedToReadImage
    case pixelTypeMismatch(detectedChannels: Int)
}

public enum ImageWriteError: Error {
    case failedToWrite
    case qualityOutOfRange
}
