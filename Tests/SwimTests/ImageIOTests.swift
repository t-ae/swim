
import XCTest
import Swim

class ImageIOTests: XCTestCase {
    
    func testSaveLoad() {
        
        // specify RGBA png image
        let srcPath = "/path/to/image.png"
        let dstPath = "/path/to/image.png"
        
        guard FileManager.default.fileExists(atPath: srcPath) else {
            return
        }
        
        let image = Image<RGBA, UInt8>(path: srcPath)!
        
        let pixel = image[10, 10]
        print(pixel[.red], pixel[.green], pixel[.blue], pixel[.alpha])
        
        do {
            try? image.write(path: dstPath, type: .png)
            
            let image2 = Image<RGBA, UInt8>(path: dstPath)!
            let pixel2 = image2[300, 300]
            print(pixel2[.red], pixel2[.green], pixel2[.blue], pixel2[.alpha])
            try! FileManager.default.removeItem(atPath: dstPath)
        }
        do {
            try? Image<RGB, UInt8>(image: image).write(path: dstPath, type: .png)
            
            let image2 = Image<RGB, UInt8>(path: dstPath)!
            let pixel2 = image2[300, 300]
            print(pixel2[.red], pixel2[.green], pixel2[.blue])
            try! FileManager.default.removeItem(atPath: dstPath)
        }
    }
    
    func testLoadFloat() {
        let srcPath = "/path/to/image.png"
        
        guard FileManager.default.fileExists(atPath: srcPath) else {
            return
        }
        
        let image = Image<RGBA, Float>(path: srcPath)!
        
        let pixel = image[10, 10]
        print(pixel[.red], pixel[.green], pixel[.blue], pixel[.alpha])
    }
}
