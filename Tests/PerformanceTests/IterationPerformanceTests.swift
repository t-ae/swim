import XCTest
import Swim

class IterationPerformanceTests: XCTestCase {
    // Summing up all color in image.
    
    // `image[x, y]` creates `Color` containing `ArraySlice`.
    func testIteration1() {
        let image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        var color = Color<RGBA, Double>(r: 0, g: 0, b: 0, a: 0)
        
        measure {
            for y in 1..<2159 {
                for x in 1..<3839 {
                    color += image[x, y]
                }
            }
        }
    }
    
    // Pixel iteration version.
    func testIteration2() {
        let image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        var color = Color<RGBA, Double>(r: 0, g: 0, b: 0, a: 0)
        
        measure {
            for px in image.pixels(in: 1..<3839, 1..<2159) {
                color += px
            }
        }
    }
}

extension IterationPerformanceTests {
    // Add color for each pixel in image.
    
    // This is the slowest.
    // `Image.subscript(x:y:)` creates new `Color` instance which contains `ArraySlice`.
    // When mutating func, `+=` in this case, is called, `Color` creates its own buffer.
    // That occurs for each pixel so it's slow.
    func testMutableIteration1() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        let color = Color<RGBA, Double>(r: 0, g: 0, b: 0, a: 1)
        
        measure {
            for y in 0..<2160 {
                for x in 0..<3840 {
                    image[x, y] += color
                }
            }
        }
    }
    
    // This is slower since `withPixelRef` calls `Array.withUnsafeMutableBufferPointer` internally.
    // The overhead of that makes this slower.
    func testMutableIteration2() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        let color = Color<RGBA, Double>(r: 0, g: 0, b: 0, a: 1)
        
        measure {
            for y in 0..<2160 {
                for x in 0..<3840 {
                    image.withPixelRef(x: x, y: y) { ref -> Void in
                        ref += color
                    }
                }
            }
        }
    }
    
    // This is the fastest.
    // `pixelwiseConvert` calls `Array.withUnsafeMutableBufferPointer` only once.
    func testMutableIteration3() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        let color = Color<RGBA, Double>(r: 0, g: 0, b: 0, a: 1)
        
        measure {
            image.pixelwiseConvert { ref in
                ref += color
            }
        }
    }
    
    // Separate channel. Slower.
    func testMutableIteration4() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        let color = Color<RGBA, Double>(r: 0, g: 0, b: 0, a: 1)
        
        measure {
            for c in RGBA.allCases {
                image.channelwiseConvert(channel: c) { x, y, value in
                    value + color[c]
                }
            }
        }
    }
}

extension IterationPerformanceTests {
    // Add scalar for each pixel value.
    
    // `dataConvert` simply iterates over `data`.
    func testIterationPixelValues1() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image.dataConvert { value in
                value + 1
            }
        }
    }
    
    // `channelwiseConvert` also iterates over `data`.
    // But it has extra arguments, `x`, `y`, `c`.
    // Computing them makes this a bit slower than `dataConvert`.
    func testIterationPixelValues2() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image.channelwiseConvert { x, y, c, value in
                value + 1
            }
        }
    }
}

extension IterationPerformanceTests {
    // Add scalar for red channel pixel values.
    
    // This approach is done by 3 steps.
    // 1. Extract red channel.
    // 2. Apply `dataConvert`.
    // 3. Write back red channel.
    // So it's slower than `channelwiseConvert` approach.
    func testChannelConvert1() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            _ = image[channel: .red].dataConvert { value in value + 1 }
        }
    }
    
    // Iterate all channels but add only for red channel.
    func testChannelConvert2() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image.channelwiseConvert { x, y, c, value in
                return c == .red ? value+1 : value
            }
        }
    }
    
    // Iterate red channel
    func testChannelConvert3() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image.channelwiseConvert(channel: .red) { x, y, value in
                value + 1
            }
        }
    }
    
    // Iterate pixels and add for red channel.
    func testChannelConvert4() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image.pixelwiseConvert { ref in
                ref[.red] += 1
            }
        }
    }
}
