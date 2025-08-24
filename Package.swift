// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "formatting-util",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(
            name: "FormattingUtil",
            targets: [
                "FormattingUtil",
            ]
        ),
    ],
    targets: [
        .target(name: "FormattingUtil"),
        .testTarget(
            name: "FormattingUtilTests",
            dependencies: [
                "FormattingUtil"
            ]
        ),
    ]
)
