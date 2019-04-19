import Foundation
import Swim


func testResoruceRoot() -> URL {
    let f = #file
    
    return URL(fileURLWithPath: f)
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .appendingPathComponent("TestResources")
}

#if canImport(AppKit)

import AppKit

func doubleToNSImage(_ image: Image<RGBA, Double>) -> NSImage {
    var image = image.clipped(low: 0, high: 1)
    image *= 255
    return image.typeConverted(to: UInt8.self).nsImage()
}

#endif
