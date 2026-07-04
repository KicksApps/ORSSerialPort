// swift-tools-version:5.9
// swift-tools-version 5.3+ is required for platform-conditioned target dependencies.

import PackageDescription

let package = Package(
    name: "ORSSerialPort",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v13),
        .macCatalyst(.v13)
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "ORSSerial",
            targets: ["ORSSerial"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
    ],
    targets: [
        // The real implementation — only actually compiled for macOS and Mac Catalyst.
        .target(
            name: "ORSSerialImpl",
            path: "Sources/ORSSerialImpl",
            exclude: ["ORSSerialBuffer.h", "../Resources/Info.plist"],
            cSettings: [.define("SWIFTPM")]
        ),
        // Thin umbrella target that the app links against. On iOS it pulls in nothing.
        .target(
            name: "ORSSerial",
            dependencies: [
                .target(name: "ORSSerialImpl",
                        condition: .when(platforms: [.macOS, .macCatalyst]))
            ],
            path: "Sources/ORSSerial",
        )
    ]
)
