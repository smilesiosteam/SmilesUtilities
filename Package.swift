// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SmilesUtilities",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SmilesUtilities",
            targets: ["SmilesUtilities"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/smilesiosteam/SmilesLanguageManager.git", branch: "main"),
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", .upToNextMinor(from: "1.7.1")),
        .package(url: "https://github.com/Juanpe/SkeletonView.git", from: "1.7.0"),
        .package(url: "https://github.com/SDWebImage/SDWebImage.git", from: "5.1.0"),
        .package(url: "https://github.com/smilesiosteam/SmilesFontsManager.git", branch: "main"),
        .package(url: "https://github.com/smilesiosteam/SmilesLoader.git", .upToNextMinor(from: "1.0.0")),
        .package(url: "https://github.com/smilesiosteam/SmilesAnalytics.git", branch: "develop"),
        .package(url: "https://github.com/wxxsw/SwiftTheme.git", .upToNextMajor(from: "0.6.4")),
        .package(url: "https://github.com/ngochiencse/HPParallaxHeader", .upToNextMajor(from: "1.1.8"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SmilesUtilities",
            dependencies: [
                .product(name: "SmilesLanguageManager", package: "SmilesLanguageManager"),
                .product(name: "CryptoSwift", package: "CryptoSwift"),
                .product(name: "SkeletonView", package: "SkeletonView"),
                .product(name: "SDWebImage", package: "SDWebImage"),
                .product(name: "SmilesFontsManager", package: "SmilesFontsManager"),
                .product(name: "SmilesLoader", package: "SmilesLoader"),
                .product(name: "AnalyticsSmiles", package: "SmilesAnalytics"),
                .product(name: "SwiftTheme", package: "SwiftTheme"),
                .product(name: "HPParallaxHeader", package: "HPParallaxHeader")
            ]),
    ]
)
