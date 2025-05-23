// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import CompilerPluginSupport
import PackageDescription

let package = Package(
  name: "Normalization",
  platforms: [
    .macOS(.v11),
    .iOS(.v13),
    .tvOS(.v13),
    .watchOS(.v6),
  ],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "Normalization",
      targets: ["Normalization"])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-collections", from: "1.1.0"),
    .package(url: "https://github.com/VergeGroup/TypedComparator", from: "1.0.0"),
    .package(url: "https://github.com/VergeGroup/swift-typed-identifier", from: "2.0.4"),
    .package(url: "https://github.com/apple/swift-syntax.git", from: "600.0.0"),
    .package(url: "https://github.com/pointfreeco/swift-macro-testing.git", from: "0.2.1"),
  ],
  targets: [
    .macro(
      name: "NormalizationMacrosPlugin",
      dependencies: [
        .product(name: "SwiftSyntaxMacros", package: "swift-syntax"),
        .product(name: "SwiftCompilerPlugin", package: "swift-syntax"),
      ]
    ),
    .target(
      name: "Normalization",
      dependencies: [
        "NormalizationMacrosPlugin",
        .product(name: "TypedIdentifier", package: "swift-typed-identifier"),
        .product(name: "TypedComparator", package: "TypedComparator"),
        .product(name: "HashTreeCollections", package: "swift-collections"),
      ]
    ),
    .testTarget(
      name: "NormalizationMacrosTests",
      dependencies: [
        "NormalizationMacrosPlugin",
        .product(name: "SwiftSyntaxMacrosTestSupport", package: "swift-syntax"),
        .product(name: "MacroTesting", package: "swift-macro-testing"),
      ]
    ),
    .testTarget(
      name: "NormalizationTests",
      dependencies: [
        "Normalization"
      ]
    ),
  ],
  swiftLanguageModes: [.v6]
)
