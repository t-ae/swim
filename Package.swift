// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "Swim",
    targets: [
        Target(name: "Swim", dependencies: ["CStbImage"])
    ]
)
