import XCTest
import Swim

class ImageIOPerformanceTests: XCTestCase {
    
    let url = URL(fileURLWithPath: "/tmp/image_io_performance.png")
    
    func testRead() throws {
        let image = Image<RGBA, UInt8>(width: 3840, height: 2160, value: 1)
        try image.write(to: url)
        
        measure {
            _ = try! Image<RGBA, UInt8>(contentsOf: url)
        }
        
        try FileManager.default.removeItem(at: url)
    }
    
    func testWrite() throws {
        let image = Image<RGBA, UInt8>(width: 3840, height: 2160, value: 1)
        
        
        measure {
            try! image.write(to: url)
        }
        
        try FileManager.default.removeItem(at: url)
    }
}
