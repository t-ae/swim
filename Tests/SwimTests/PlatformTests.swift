
import XCTest
import Swim

class PlatformTests: XCTestCase {
    
}

#if os(macOS)
    import AppKit
    
    extension PlatformTests {
        #if !SWIFT_PACKAGE
        func testAppkit() {
            
            let imagePath = "/path/to/image.png"
            
            guard FileManager.default.fileExists(atPath: imagePath) else {
                return
            }
            
            let nsImage = NSImage(contentsOf: URL(fileURLWithPath: imagePath))!
            
            let image = Image<RGBA, UInt8>(nsImage: nsImage)
            
            let nsImage2 = image!.nsImage()
            
        }
        #endif
    }
#endif
