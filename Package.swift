// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GlideAppClipSDK",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "GlideAppClipSDK",
            targets: ["GlideAppClipSDK"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "GlideAppClipSDK",
            dependencies: []),
    ]
)
