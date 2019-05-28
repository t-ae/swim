import XCTest
@testable import Swim

class DrawPerformanceTests: XCTestCase {
    func testDrawLine() {
        var image = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        let color = Color<RGBA, Double>(r: 1, g: 1, b: 1, a: 1)
        
        measure {
            for y in 0..<1080 {
                image.drawLine(p1: (0, y), p2: (1919, y), color: color)
            }
        }
    }
    
    func testDrawHorizontalLine() {
        var image = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        let color = Color<RGBA, Double>(r: 1, g: 1, b: 1, a: 1)
        
        measure {
            for y in 0..<1080 {
                image.drawHorizontalLine(x1: 0, x2: 1019, y: y, color: color)
            }
        }
    }
    
    func testDrawRect() {
        var image = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        let color = Color<RGBA, Double>(r: 1, g: 1, b: 1, a: 1)
        
        measure {
            image.drawRect(origin: (0, 0), size: (1920, 1080), color: color)
        }
    }
    
    func testDrawRectPelimeter() {
        var image = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        let color = Color<RGBA, Double>(r: 1, g: 1, b: 1, a: 1)
        
        measure {
            image.drawRectPelimeter(origin: (0, 0), size: (1920, 1080), color: color)
        }
    }
    
    func testDrawCircle() {
        var image = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        let color = Color<RGBA, Double>(r: 1, g: 1, b: 1, a: 1)
        
        measure {
            image.drawCircle(center: (960, 540), radius: 540, color: color)
        }
    }
    
    func testDrawCirclePelimeter() {
        var image = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        let color = Color<RGBA, Double>(r: 1, g: 1, b: 1, a: 1)
        
        measure {
            image.drawCirclePelimeter(center: (960, 540), radius: 540, color: color)
        }
    }
    
    func testDrawPolygon() {
        var image = Image<RGBA, Double>(width: 1920, height: 1080, value: 0)
        let color = Color<RGBA, Double>(r: 1, g: 1, b: 1, a: 1)
        
        measure {
            image.drawPolygon(points: [(0, 0), (960, 10),
                                       (1919, 0), (1900, 540),
                                       (1919, 1079), (960, 1000),
                                       (0, 1079), (30, 540)], color: color)
        }
    }
    
    func testDrawImage() {
        var image = Image<RGB, Double>(width: 1920, height: 1080, value: 0)
        let draw = Image<RGB, Double>(width: 1000, height: 70, value: 1)
        
        measure {
            image.drawImage(origin: (10, 10), image: draw)
        }
    }
    
    func testDrawImageWithmask() {
        var image = Image<RGB, Double>(width: 1920, height: 1080, value: 0)
        let draw = Image<RGB, Double>(width: 1000, height: 700, value: 1)
        let mask = Image<Gray, Bool>.full(value: true, like: draw)
        
        measure {
            image.drawImage(origin: (10, 10), image: draw, mask: mask)
        }
    }
    
    func testDrawImageAlphaBlend() {
        var image = Image<RGB, Double>(width: 1920, height: 1080, value: 0)
        let draw = Image<RGBA, Double>(width: 1000, height: 700, value: 1)
        
        measure {
            image.drawImage(origin: (10, 10), image: draw)
        }
    }
}
