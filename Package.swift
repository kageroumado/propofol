// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "Propofol",
    platforms: [.macOS("26.0")],
    products: [
        .library(name: "Propofol", targets: ["Propofol"]),
    ],
    targets: [
        .target(name: "Propofol"),
    ],
)
