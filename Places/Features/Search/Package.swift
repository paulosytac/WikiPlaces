// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Search",
    platforms: [.iOS(.v18)],
    products: [
        .library(
            name: "Search",
            targets: ["Search"]),
    ],
    dependencies: [
        .package(url: "https://github.com/paulosytac/WikiNetwork", branch: "main")
    ],
    targets: [
        .target(
            name: "Search",
            dependencies: [
                .product(name: "Network", package: "WikiNetwork"),
            ]
        ),
        .testTarget(
            name: "SearchTests",
            dependencies: ["Search"]
        ),
    ]
)
