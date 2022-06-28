# ActivUtils iOS
_TODO:_ **Add badges**
    
## Installation

### Swift Package Manager (Recommended)
Option 1:
Go to Xcode->Swift Packages->Add Package Dependency and add [](https://github.com/ActivBody/activ5-utils-ios
)
The versions are available [here](https://github.com/ActivBody/activ5-utils-ios
/releases), but it is recommended to use `master` branch.

Option 2:
In `Package.swift` :
```swift
dependencies: [
    // Dependencies declare other packages that this package depends on.
    .package(url: "https://github.com/ActivBody/activ5-utils-ios
", .branch("master")), //using branch
    .package(url: "https://github.com/ActivBody/activ5-utils-ios
", from: "1.0.0"), //using exact version
    .package(url: "https://github.com/ActivBody/activ5-utils-ios
", .upToNextMajor("1.0.0")) //using up to next major version
],
```

## Running Unit Tests
### Swift package manager
1. Clone the framework 
2. Open the framework directory using Xcode
3. Select Product->Test

# Use of framework
_TODO:_ **Add guide how to use the framework**

## Authors
_TODO:_ **Write authors**

## License
_TODO:_ **Specify license**
