// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FillUpNow",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "FillUpNow",
            targets: ["FillUpNow"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent.git", from: "4.0.0"),
        .package(url: "https://github.com/vapor/fluent-mysql-driver.git", from: "4.0.0-beta"),
    ],
    
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "FillUpNow",
            dependencies: [
                        .product(name: "Vapor", package: "vapor"),
                        .product(name: "Fluent", package: "fluent"),
                        .product(name: "FluentMySQLDriver", package: "fluent-mysql-driver"),
                    ]
        ),
        .testTarget(
            name: "FillUpNowTests",
            dependencies: ["FillUpNow"]),
    ]
)
