import PackageDescription

let package = Package(
    name: "Stacking",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "Stacking", targets: ["Stacking"]),
    ],
    targets: [
        .target(name: "Stacking", path: "Stacking"),
        .testTarget(name: "StackingTests", dependencies: ["Stacking"]),
    ],
    swiftLanguageVersions: [
        .v5
    ]
)
