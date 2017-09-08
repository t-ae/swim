
#if os(iOS)

    import UIKit
    
    extension Image where P == RGBA, T == UInt8 {
        public init?(uiImage: UIImage) {
            guard let cgImage = uiImage.cgImage else {
                return nil
            }
            self.init(cgImage: cgImage)
        }
        
        public func uiImage() -> UIImage {
            return UIImage(cgImage: cgImage())
        }
    }
    
    
#endif
