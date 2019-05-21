# Stacking
[![Swift](https://img.shields.io/badge/swift-5.0-orange.svg)](https://developer.apple.com/swift/)
[![CocoaPods](https://img.shields.io/badge/pod-v1.1.0-blue.svg)](https://cocoapods.org/pods/Stacking)

A scrollable UIStackView.

## Requirements

- iOS 9.0+
- Xcode 10.2+
- Swift 5.0+

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. For usage and installation instructions, visit their website. To integrate the library into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
pod 'Stacking', '1.1.0'
```

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for automating the distribution of Swift code and is integrated into the `swift` compiler.

```swift
dependencies: [
    .package(url: "https://github.com/berbschloe/Stacking.git", from: "1.1.0")
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
// StackingView is a subclass of UIScrollView that has a single content view of type UIStackView
let stackingView = StackingView()

// Has the same API as UIStackView, scrolling behavior is handled automatically on axis change
stackingView.axis = .vertical

// Add arranged subviews the same way you would for UIStackView
stackingView.addArrangedSubview(...)

// Even add multiple at once
stackingView.addArrangedSubviews([...])
```
