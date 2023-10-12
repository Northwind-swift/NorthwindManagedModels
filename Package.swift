// swift-tools-version: 5.9

import PackageDescription

let package = Package(
  name: "NorthwindManagedModels",
  platforms: [ .macOS(.v12), .iOS(.v15) ],
  products: [
    .library(name: "NorthwindSwiftData", targets:[ "NorthwindSwiftData" ]),
  ],
  dependencies: [
    .package(url: "https://github.com/Data-swift/ManagedModels.git",
             from: "0.8.2")
  ],
  targets: [
    .target(name: "NorthwindSwiftData",
            dependencies: [ "ManagedModels" ],
            resources: [ .copy("Resources/Northwind.store") ]),
    .testTarget(name: "NorthwindSwiftDataTests",
                dependencies: [ "NorthwindSwiftData" ])
  ]
) 
