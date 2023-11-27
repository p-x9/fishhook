// swift-tools-version:5.7

import PackageDescription

let package = Package(
    name: "fishhook",
    products: [
        .library(
            name: "fishhook",
            targets: ["fishhook"]
        )
    ],
    targets: [
        .target(
            name: "fishhook",
            path: "./",
            publicHeadersPath: "include/",
            cSettings: [
                .define("FISHHOOK_EXPORT")
            ]
        )
    ]
)

