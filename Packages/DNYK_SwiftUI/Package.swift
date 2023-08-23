// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DNYK_SwiftUI",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DNYK_SwiftUI",
            targets: ["DNYK_SwiftUI"]),
        .library(
            name: "Scene_NewCategory",
            targets: ["Scene_NewCategory"]),
    ],
    dependencies: [
        .package(path: "../DNYK_Core"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DNYK_SwiftUI", dependencies: ["DNYK_Core"]),
        .testTarget(
            name: "DNYK_SwiftUITests",
            dependencies: ["DNYK_SwiftUI", .product(name: "DNYK_TestCore", package: "DNYK_Core")]),
        
        .target(
            name: "Scene_NewCategory",
            dependencies: ["DNYK_SwiftUI"]),
        .testTarget(
            name: "Scene_NewCategoryTests",
            dependencies: ["Scene_NewCategory", .product(name: "DNYK_TestCore", package: "DNYK_Core")]),
    ]
)
