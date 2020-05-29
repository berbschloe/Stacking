# Stacking
[![Swift](https://img.shields.io/badge/swift-5.0-orange.svg)](https://developer.apple.com/swift/)
[![CocoaPods](https://img.shields.io/badge/pod-v2.0.0-blue.svg)](https://cocoapods.org/pods/Stacking)

A scrollable UIStackView.

## Requirements

- iOS 11.0+
- Xcode 10.2+
- Swift 5.0+

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate the library into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'Stacking', '2.0.0'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

```swift
dependencies: [
    .package(url: "https://github.com/berbschloe/Stacking.git", from: "2.0.0")
]
```

## Usage

Import the library like you would any other.

#### Importing

```swift
// Add this to the top of your file
import Stacking
```

#### Example

```swift

// StackingView is a subclass of UIView that containts a scroll view and a stack view.
// Common UIStackView properties and methods are also included in StackingView.
let stackingView = StackingView()

stackingView.axis = .vertical

// Add an arranged subview the same way you would for UIStackView
stackingView.addArrangedSubview(someView)

// You can even add multiple arranged subviews
stackingView.addArrangedSubviews([someView1, someView2])
```
