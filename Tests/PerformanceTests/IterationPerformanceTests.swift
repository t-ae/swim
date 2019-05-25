import XCTest
import Swim

class IterationPerformanceTests: XCTestCase {
    
    // This is the slowest.
    // `Image.subscript(x:y:)` creates new `Pixel` instance.
    // `Pixel` has its own buffer so it must be initialized.
    func testIteration1() {
        let image = Image<RGBA, Double>(width: 1920, height: 1080, value: 1)
        var pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 0)
        
        measure {
            for y in 0..<1080 {
                for x in 0..<1920 {
                    pixel += image[x, y]
                }
            }
        }
    }
    
    // This is some slower.
    // `withPixelRef` always calculates the index in data.
    func testIteration2() {
        let image = Image<RGBA, Double>(width: 1920, height: 1080, value: 1)
        var pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 0)
        
        measure {
            for y in 0..<1080 {
                for x in 0..<1920 {
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
        let image = Image<RGBA, Double>(width: 1920, height: 1080, value: 1)
        var pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 0)
        
        measure {
            image.iteratePixels { ref in
                pixel += ref
            }
        }
    }
    
    // This is the slowest.
    // `Image.subscript(x:y:)` creates new `Pixel` instance.
    // `Pixel` has its own buffer so it must be initialized.
    func testMutableIteration1() {
        var image = Image<RGBA, Double>(width: 1920, height: 1080, value: 1)
        let pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 1)
        
        measure {
            for y in 0..<1080 {
                for x in 0..<1920 {
                    image[x, y] += pixel
                }
            }
        }
    }
    
    // This is slower since `withMutablePixelRef` calls `Array.withUnsafeMutableBufferPointer` internally.
    // After closure execution, `withUnsafeMutableBufferPointer` checks if pointer is changed.
    func testMutableIteration2() {
        var image = Image<RGBA, Double>(width: 1920, height: 1080, value: 1)
        let pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 1)
        
        measure {
            for y in 0..<1080 {
                for x in 0..<1920 {
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
        var image = Image<RGBA, Double>(width: 1920, height: 1080, value: 1)
        let pixel = Pixel<RGBA, Double>(r: 0, g: 0, b: 0, a: 1)
        
        measure {
            image.pixelwiseConvert { ref in
                ref += pixel
            }
        }
    }
}
