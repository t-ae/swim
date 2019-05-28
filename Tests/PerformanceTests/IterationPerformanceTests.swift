import XCTest
import Swim

class IterationPerformanceTests: XCTestCase {
    
    // This is the slowest.
    // `Image.subscript(x:y:)` creates new `Pixel` instance.
    // `Pixel` has its own buffer so it must be initialized.
    func testIteration1() {
        let image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        var pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 0)
        
        measure {
            for y in 0..<2160 {
                for x in 0..<3840 {
                    pixel += image[x, y]
                }
            }
        }
    }
    
    // This is some slower.
    // `withPixelRef` always calculates the index in data.
    func testIteration2() {
        let image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        var pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 0)
        
        measure {
            for y in 0..<2160 {
                for x in 0..<3840 {
                    image.withPixelRef(x: x, y: y) { ref -> Void in
                        pixel += ref
                    }
                }
            }
        }
    }
    
    // This is the fastest.
    // `iteratePixels`'s index calculation doesn't need many multiplications.
    func testIteration3() {
        let image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        var pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 0)
        
        measure {
            image.iteratePixels { ref in
                pixel += ref
            }
        }
    }
    
    func testIteration4() {
        let image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        var pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 0)
        
        measure {
            for px in image.pixels() {
                pixel += px
            }
        }
    }
}

extension IterationPerformanceTests {
    
    // This is the slowest.
    // `Image.subscript(x:y:)` creates new `Pixel` instance.
    // `Pixel` has its own buffer so it must be initialized.
    func testMutableIteration1() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        let pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 1)
        
        measure {
            for y in 0..<2160 {
                for x in 0..<3840 {
                    image[x, y] += pixel
                }
            }
        }
    }
    
    // This is slower since `withMutablePixelRef` calls `Array.withUnsafeMutableBufferPointer` internally.
    // After closure execution, `withUnsafeMutableBufferPointer` checks if pointer is changed.
    func testMutableIteration2() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        let pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 1)
        
        measure {
            for y in 0..<2160 {
                for x in 0..<3840 {
                    image.withMutablePixelRef(x: x, y: y) { ref -> Void in
                        ref += pixel
                    }
                }
            }
        }
    }
    
    // This is the fastest.
    // `pixelwiseConvert` calls `Array.withUnsafeMutableBufferPointer` only once.
    func testMutableIteration3() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        let pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 1)
        
        measure {
            image.pixelwiseConvert { ref in
                ref += pixel
            }
        }
    }
}

extension IterationPerformanceTests {
    func testIterationPixelValues1() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image.dataConvert { value in
                value + 1
            }
        }
    }
    
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
    func testChannelConvert1() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            _ = image[channel: .red].dataConverted { value in value + 1 }
        }
    }
    
    func testChannelConvert2() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image.channelwiseConvert { x, y, c, value in
                return c == .red ? value+1 : value
            }
        }
    }
    
    func testChannelConvert3() {
        var image = Image<RGBA, Double>(width: 3840, height: 2160, value: 1)
        
        measure {
            image.channelwiseConvert(channel: .red) { x, y, value in
                value + 1
            }
        }
    }
}
