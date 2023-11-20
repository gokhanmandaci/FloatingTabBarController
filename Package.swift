// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FloatingTabBarController",
    platforms: [
        .iOS(.v12)
    ],
    products: [
        .library(
            name: "FloatingTabBarController",
            targets: ["FloatingTabBarController"]),
    ],
    targets: [
        .target(
            name: "FloatingTabBarController"),
        .testTarget(
            name: "FloatingTabBarControllerTests",
            dependencies: ["FloatingTabBarController"]),
    ]
)
