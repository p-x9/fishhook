// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "fishhook",
    products: [
        .library(
            name: "fishhook",
            targets: ["fishhook"]
        ),
        .library(
            name: "fishhookC",
            targets: ["fishhookC"]
        )
    ],
    targets: [
        .target(
            name: "fishhook",
            dependencies: [
                "fishhookC"
            ]
        ),
        .target(
            name: "fishhookC",
            path: "./",
            exclude: [
                "Sources/"
            ],
            publicHeadersPath: "include/",
            cSettings: [
                .define("FISHHOOK_EXPORT")
            ]
        )
    ]
)

