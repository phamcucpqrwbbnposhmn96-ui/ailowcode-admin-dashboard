// swift-tools-version:15.0
import PackageDescription

let package = Package(
    name: "AlarmApp",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .executable(name: "AlarmApp", targets: ["AlarmApp"])
    ],
    targets: [
        .executableTarget(
            name: "AlarmApp",
            path: "AlarmApp"
        )
    ]
)
