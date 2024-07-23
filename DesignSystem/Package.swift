// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DesignSystem",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DesignSystem",
            resources: [
                .process("Fonts/Inter-Black.ttf"),
                .process("Fonts/Inter-Bold.ttf"),
                .process("Fonts/Inter-ExtraBold.ttf"),
                .process("Fonts/Inter-ExtraLight.ttf"),
                .process("Fonts/Inter-Light.ttf"),
                .process("Fonts/Inter-Medium.ttf"),
                .process("Fonts/Inter-Regular.ttf"),
                .process("Fonts/Inter-SemiBold.ttf"),
                .process("Fonts/Inter-Thin.ttf")
            ]
        ),
        .testTarget(
            name: "DesignSystemTests",
            dependencies: ["DesignSystem"]),
    ]
)
