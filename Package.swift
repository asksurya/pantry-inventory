// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "PantryInventory",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "PantryInventory",
            targets: ["PantryInventory"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "PantryInventory",
            dependencies: [],
            path: "PantryInventory"
        ),
        .testTarget(
            name: "PantryInventoryTests",
            dependencies: ["PantryInventory"],
            path: "PantryInventoryTests",
            resources: [
                .copy("PantryInventory/PantryInventory.xcdatamodeld")
            ]
        ),
    ]
)
