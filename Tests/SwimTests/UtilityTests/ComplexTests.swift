import XCTest
import Swim

class ComplexTests: XCTestCase {
    func testInit() {
        let comp1 = Complex<Double>(real: 1, imag: 2)
        XCTAssertEqual(comp1.real, 1)
        XCTAssertEqual(comp1.imag, 2)
        
        let comp2: Complex<Double> = 1
        XCTAssertEqual(comp2.real, 1)
        XCTAssertEqual(comp2.imag, 0)
        
        let comp3: Complex<Double> = 1.5
        XCTAssertEqual(comp3.real, 1.5)
        XCTAssertEqual(comp3.imag, 0)
    }

    func testAdd() {
        var comp1 = Complex<Double>(real: 1, imag: 2)
        let comp2 = Complex<Double>(real: 3, imag: 4)
        
        let answer = Complex(real: 4, imag: 6)
        
        XCTAssertEqual(comp1+comp2, answer)
        
        comp1 += comp2
        XCTAssertEqual(comp1, answer)
    }
    
    func testSub() {
        var comp1 = Complex<Double>(real: 1, imag: 2)
        let comp2 = Complex<Double>(real: 3, imag: 5)
        
        let answer = Complex(real: -2, imag: -3)
        
        XCTAssertEqual(comp1-comp2, answer)
        
        comp1 -= comp2
        XCTAssertEqual(comp1, answer)
    }
    
    func testMul() {
        var comp1 = Complex<Double>(real: 1, imag: 2)
        let comp2 = Complex<Double>(real: 3, imag: 5)
        
        let answer = Complex(real: -7, imag: 11)
        
        XCTAssertEqual(comp1*comp2, answer)
        
        comp1 *= comp2
        XCTAssertEqual(comp1, answer)
    }
    
    func testDiv() {
        var comp1 = Complex<Double>(real: 1, imag: 2)
        let comp2 = Complex<Double>(real: 3, imag: 5)
        
        let answer = Complex(real: 13.0 / 34, imag: 1.0 / 34)
        
        XCTAssertEqual(comp1/comp2, answer)
        
        comp1 /= comp2
        XCTAssertEqual(comp1, answer)
    }
    
    func testNeg() {
        var comp1 = Complex<Double>(real: 1, imag: 2)
        
        let answer = Complex(real: -1, imag: -2)
        
        XCTAssertEqual(-comp1, answer)
        
        comp1.negate()
        XCTAssertEqual(comp1, answer)
    }
    
    static let allTests = [
        ("testInit", testInit),
        ("testAdd", testAdd),
        ("testSub", testSub),
        ("testMul", testMul),
        ("testDiv", testDiv),
        ("testNeg", testNeg)
    ]
}
