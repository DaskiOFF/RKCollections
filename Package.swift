// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "RKCollections",
    platforms: [
        .iOS(.v14),
        .macCatalyst(.v13),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "RKCollections",
            targets: ["RKCollections"]),
    ],
    targets: [
        .target(
            name: "RKCollections",
            dependencies: []),
    ]
)
