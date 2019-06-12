import XCTest
import Swim

class SubimageSubscriptTests: XCTestCase {
    
    func testSubimageSubscriptGet() {
        let data = (0..<400).map { Double($0) }
        let image = Image(width: 10, height: 10, rgba: data)
        
        do {
            let subimage = image[0..<2, 0..<3]
            
            XCTAssertEqual(subimage,
                           Image(width: 2, height: 3, data: [0, 1, 2, 3,
                                                             4, 5, 6, 7,
                                                             40, 41, 42, 43,
                                                             44, 45, 46, 47,
                                                             80, 81, 82, 83,
                                                             84, 85, 86, 87]))
        }
        
        do {
            let subimage = image[1..<4, 0..<2]
            
            XCTAssertEqual(subimage,
                           Image(width: 3, height: 2, data: [4, 5, 6, 7,
                                                             8, 9, 10, 11,
                                                             12, 13, 14, 15,
                                                             44, 45, 46, 47,
                                                             48, 49, 50, 51,
                                                             52, 53, 54, 55]))
        }
        
        do {
            let subimage = image[1..<3, 1..<3]
            
            XCTAssertEqual(subimage,
                           Image(width: 2, height: 2, data: [44, 45, 46, 47,
                                                             48, 49, 50, 51,
                                                             84, 85, 86, 87,
                                                             88, 89, 90, 91]))
        }
        
        do {
            let subimage = image[rows: 1..<2]
            XCTAssertEqual(subimage, Image(width: 10, height: 1, data: (40..<80).map(Double.init)))
        }
        
        do {
            let subimage = image[cols: 1..<2]
            XCTAssertEqual(subimage,
                           Image(width: 1, height: 10, data: [4, 5, 6, 7,
                                                              44, 45, 46, 47,
                                                              84, 85, 86, 87,
                                                              124, 125, 126, 127,
                                                              164, 165, 166, 167,
                                                              204, 205, 206, 207,
                                                              244, 245, 246, 247,
                                                              284, 285, 286, 287,
                                                              324, 325, 326, 327,
                                                              364, 365, 366, 367]))
        }
    }
    
    func testSubimageSubscriptSet() {
        let data = (0..<27).map { Double($0) }
        var image = Image(width: 3, height: 3, rgb: data)
        
        XCTAssertEqual(image,
                       Image(width: 3, height: 3, data: [0, 1, 2,
                                                         3, 4, 5,
                                                         6, 7, 8,
                                                         9, 10, 11,
                                                         12, 13, 14,
                                                         15, 16, 17,
                                                         18, 19, 20,
                                                         21, 22, 23,
                                                         24, 25, 26]))
        
        image[0..<2, 0..<2] = Image<RGB, Double>(width: 2, height: 2, data: (0..<12).map { -Double($0+1) })
        XCTAssertEqual(image,
                       Image(width: 3, height: 3, data: [-1, -2, -3,
                                                         -4, -5, -6,
                                                         6, 7, 8,
                                                         -7, -8, -9,
                                                         -10, -11, -12,
                                                         15, 16, 17,
                                                         18, 19, 20,
                                                         21, 22, 23,
                                                         24, 25, 26]))
        
        image[rows: 2..<3] = Image<RGB, Double>(width: 3, height: 1, data: [50, 51, 52, 53, 54, 55, 56, 57, 58])
        XCTAssertEqual(image,
                       Image(width: 3, height: 3, data: [-1, -2, -3,
                                                         -4, -5, -6,
                                                         6, 7, 8,
                                                         -7, -8, -9,
                                                         -10, -11, -12,
                                                         15, 16, 17,
                                                         50, 51, 52,
                                                         53, 54, 55,
                                                         56, 57, 58]))
    }
    
    static let allTests = [
        ("testSubimageSubscriptGet", testSubimageSubscriptGet),
        ("testSubimageSubscriptSet", testSubimageSubscriptSet)
    ]
}
