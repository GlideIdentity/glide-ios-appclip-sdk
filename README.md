# GlideAppClipSDK

## Introduction

`GlideAppClipSDK` is our SDK for integrating Glide verification UI components into iOS App Clips and lightweight authentication flows. This SDK provides pre-built UI components optimized for App Clip experiences.

## Installation

### Swift Package Manager

The [Swift Package Manager](https://swift.org/package-manager/) is a tool for managing the distribution of Swift code. To use GlideAppClipSDK with Swift Package Manager, add it to `dependencies` in your `Package.swift`

```swift
dependencies: [
    .package(url: "https://github.com/amira-glide/glide-ios-appclip-sdk.git")
]
```

## Usage

Firstly, import `GlideAppClipSDK`.

```swift
import GlideAppClipSDK
```

The SDK provides a ready-to-use verification view that displays a customizable header with image and text. This is ideal for App Clips where you want a quick, streamlined authentication experience.

### SwiftUI Integration

#### Basic Usage

```swift
import SwiftUI
import GlideAppClipSDK

struct ContentView: View {
    var body: some View {
        GlideVerificationView()
    }
}
```

#### Custom Header

You can customize the header with your own text and image:

```swift
import SwiftUI
import GlideAppClipSDK

struct ContentView: View {
    var body: some View {
        GlideVerificationView(
            headerText: "My App",
            headerImage: UIImage(named: "logo")
        )
    }
}
```

#### With Dismiss Handler

```swift
import SwiftUI
import GlideAppClipSDK

struct ContentView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GlideVerificationView(
            headerText: "Verify Your Identity",
            headerImage: UIImage(named: "app-icon")
        ) {
            // Handle dismiss
            dismiss()
        }
    }
}
```

### UIKit Integration

For UIKit-based apps or App Clips, use `GlideVerificationViewController`:

```swift
import UIKit
import GlideAppClipSDK

class AppClipViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let glideVC = GlideVerificationViewController(
            headerText: "My App",
            headerImage: UIImage(named: "logo")
        )
        
        present(glideVC, animated: true)
    }
}
```

### App Clip Integration

To use GlideAppClipSDK in your App Clip:

1. Add the package dependency to your App Clip target in Xcode
2. Import and use the verification view in your App Clip's entry point:

```swift
import SwiftUI
import GlideAppClipSDK

@main
struct MyAppClip: App {
    var body: some Scene {
        WindowGroup {
            GlideVerificationView(
                headerText: "Quick Verification",
                headerImage: UIImage(named: "clip-icon")
            )
        }
    }
}
```

### Customization

The `GlideVerificationView` accepts the following parameters:

- **`headerText`** (optional): Custom text to display in the header. Defaults to "Glide" if not provided.
- **`headerImage`** (optional): Custom image to display in the header. Defaults to a shield icon if not provided.
- **`onDismiss`** (optional): Closure called when the user taps the close button.

### Example: App Clip with Custom Branding

```swift
import SwiftUI
import GlideAppClipSDK

@main
struct RestaurantAppClip: App {
    var body: some Scene {
        WindowGroup {
            GlideVerificationView(
                headerText: "Restaurant Reservations",
                headerImage: UIImage(named: "restaurant-logo")
            ) {
                // User dismissed the view
                print("User closed verification")
            }
        }
    }
}
```

## Requirements

- iOS 15.0+
- Swift 5.9+
- Xcode 15.0+

## Notes

- This SDK is designed specifically for App Clips and lightweight verification flows
- The UI is optimized for quick authentication without complex phone number input
- For full-featured authentication in main apps, consider using `GlideSwiftSDK`

## License

See LICENSE file for details.
