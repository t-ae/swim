import Foundation

func testResoruceRoot() -> URL {
    let f = #file
    
    return URL(fileURLWithPath: f)
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .deletingLastPathComponent()
        .appendingPathComponent("TestResources")
}
