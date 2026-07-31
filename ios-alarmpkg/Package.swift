// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "AlarmApp",
    platforms: [
        .iOS(.v17)
    ],
    targets: [
        .executableTarget(
            name: "AlarmApp",
            dependencies: [],
            path: "AlarmApp",
            resources: [
                .copy("Resources")
            ],
            linkerSettings: [
                .linkedFramework("UIKit"),
                .linkedFramework("SwiftUI"),
                .linkedFramework("UserNotifications")
            ]
        )
    ]
)