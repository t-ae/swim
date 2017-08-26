
import XCTest
import Swim

class ImageSliceTests: XCTestCase {
    
    func testSlice() {
        let data = (0..<400).map { Double($0) }
        let image = Image<RGBA, Double>(width: 10, height: 10, data: data)
        
        do {
            let slice = image[0..<2, 0..<3]
            let result = Image(slice)
            
            XCTAssertEqual(result.data, [0, 1, 2, 3,
                                                 4, 5, 6, 7,
                                                 40, 41, 42, 43,
                                                 44, 45, 46, 47,
                                                 80, 81, 82, 83,
                                                 84, 85, 86, 87])
        }
        
        do {
            let slice = image[1..<4, 0..<2]
            let result = Image(slice)
            
            XCTAssertEqual(result.data, [4, 5, 6, 7,
                                                 8, 9, 10, 11,
                                                 12, 13, 14, 15,
                                                 44, 45, 46, 47,
                                                 48, 49, 50, 51,
                                                 52, 53, 54, 55])
        }
        
        do {
            let slice = image[1..<3, 1..<3]
            let result = Image(slice)
            
            XCTAssertEqual(result.data, [44, 45, 46, 47,
                                                 48, 49, 50, 51,
                                                 84, 85, 86, 87,
                                                 88, 89, 90, 91])
        }
        
        do {
            let slice = image[rows: 1..<2]
            let result = Image(slice)
            XCTAssertEqual(result.data, (40..<80).map(Double.init))
        }
        
        do {
            let slice = image[cols: 1..<2]
            let result = Image(slice)
            XCTAssertEqual(result.data, [4, 5, 6, 7,
                                                 44, 45, 46, 47,
                                                 84, 85, 86, 87,
                                                 124, 125, 126, 127,
                                                 164, 165, 166, 167,
                                                 204, 205, 206, 207,
                                                 244, 245, 246, 247,
                                                 284, 285, 286, 287,
                                                 324, 325, 326, 327,
                                                 364, 365, 366, 367])
        }
    }
    
}
