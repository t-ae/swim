import XCTest

import PerformanceTests
import SwimTests
import VisualTests

var tests = [XCTestCaseEntry]()
tests += SwimTests.__allTests()

XCTMain(tests)
