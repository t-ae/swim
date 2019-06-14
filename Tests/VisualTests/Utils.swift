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

func rainbowImage256() -> Image<RGB, UInt8> {
    var image = Image<RGB, UInt8>(width: 256, height: 256, value: 0)
    var start = 0
    
    let yRange = 0..<256
    
    image.drawRect(start..<start+32, yRange, color: Color(r: 0, g: 0, b: 0))
    start += 32
    image.drawRect(start..<start+32, yRange, color: Color(r: 255, g: 0, b: 0))
    start += 32
    image.drawRect(start..<start+32, yRange, color: Color(r: 0, g: 255, b: 0))
    start += 32
    image.drawRect(start..<start+32, yRange, color: Color(r: 0, g: 0, b: 255))
    start += 32
    image.drawRect(start..<start+32, yRange, color: Color(r: 255, g: 255, b: 0))
    start += 32
    image.drawRect(start..<start+32, yRange, color: Color(r: 0, g: 255, b: 255))
    start += 32
    image.drawRect(start..<start+32, yRange, color: Color(r: 255, g: 0, b: 255))
    start += 32
    image.drawRect(start..<start+32, yRange, color: Color(r: 255, g: 255, b: 255))
    
    return image
}

func rainbowImage256<T: BinaryFloatingPoint>() -> Image<RGB, T> {
    let uint: Image<RGB, UInt8> = rainbowImage256()
    
    return uint.cast(to: T.self) / 255
}

func gradiationImage256() -> Image<Gray, UInt8> {
    var image = Image<Gray, UInt8>(width: 256, height: 256, value: 0)
    
    image.unsafePixelwiseConvert { ref in
        ref[.gray] = UInt8(ref.y * ref.y / 256)
    }
    
    return image
}

func gradiationImage256<T: BinaryFloatingPoint>() -> Image<Gray, T> {
    let uint: Image<Gray, UInt8> = gradiationImage256()
    
    return uint.cast(to: T.self) / 255
}

#if canImport(AppKit)

import AppKit

func doubleToNSImage<P: ConvertibleToCGImage>(_ image: Image<P, Double>) -> NSImage {
    return image.dataConverted { UInt8(min(max($0, 0), 1)*255) }.nsImage()
}

#endif
