#if canImport(Accelerate) && !DISABLE_ACCELERATE

import Accelerate

public enum vImageUtils {
}

public struct vImageUtilsError: Error {
    public let vImageErrorCode: Int
    
    @inlinable
    init(vImageErrorCode: Int) {
        self.vImageErrorCode = vImageErrorCode
    }
}

#endif
