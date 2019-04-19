import XCTest
import Swim

class PlatformTests: XCTestCase {
    
}

#if canImport(AppKit)

import AppKit

extension PlatformTests {
    #if !DEBUG
    func testAppkit() {
        print(testResoruceRoot())
        
        let imagePath = testResoruceRoot().appendingPathComponent("lena.png")
        
        guard FileManager.default.fileExists(atPath: imagePath.path) else {
            XCTFail("Invalid path: \(imagePath)")
            return
        }
        
        let nsImage = NSImage(contentsOf: imagePath)!
        
        let image = Image<RGBA, UInt8>(nsImage: nsImage)
        
        let nsImage2 = image!.nsImage()
        
        print("break here")
        
        _ = nsImage2
    }
    #endif
}

#endif

import Foundation

func testResoruceRoot() -> URL {
    let f = #file
    
    return URL(fileURLWithPath: f)
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .appendingPathComponent("TestResources")
}
