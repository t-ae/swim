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

func time(f: ()->Void) {
    let start = Date()
    
    f()
    
    print("Elapsed time: ", Date().timeIntervalSince(start), "sec")
}

#if canImport(AppKit)

import AppKit

func doubleToNSImage<P: ConvertibleToCGImage>(_ image: Image<P, Double>) -> NSImage {
    return image.channelwiseConverted { UInt8(min(max($0, 0), 1)*255) }.nsImage()
}

#endif
