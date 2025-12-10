# GlideAppClipSDK

## Introduction

`GlideAppClipSDK` is a lightweight SDK for integrating Glide verification UI components into iOS App Clips. This SDK provides pre-built UI components optimized for App Clip experiences with automatic entitlement validation.

## Entitlement Validation

The SDK automatically validates the **com.apple.CommCenter.fine-grained** entitlement by attempting to access the CoreTelephony `CTSubscriber.carrierToken` API. This entitlement is required for accessing subscriber information.

### How It Works

1. On app launch, the SDK attempts to access `CTSubscriber().carrierToken`
2. If the token is accessible (not nil), the entitlement is present
3. If the token is nil, the entitlement is missing or not properly configured
4. The UI displays a status badge (green for valid, red for missing)

### Adding the Entitlement

Add the following to your App Clip's `.entitlements` file:

```xml
<key>com.apple.CommCenter.fine-grained</key>
<array>
    <string>spi</string>
</array>
```

**Note**: This entitlement may require approval from Apple for production use.

## Installation

### Swift Package Manager

Add GlideAppClipSDK to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/amira-glide/glide-ios-appclip-sdk.git")
]
```

Or add it via Xcode:
1. File → Add Package Dependencies
2. Enter the repository URL
3. Select your App Clip target

## Usage

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
    var body: some View {
        GlideVerificationView(
            headerText: "Verify Your Identity",
            headerImage: UIImage(named: "app-icon")
        ) {
            // Handle dismiss
            print("User dismissed")
        }
    }
}
```

### UIKit Integration

```swift
import UIKit
import GlideAppClipSDK

class AppClipViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let glideVC = GlideVerificationViewController(
            headerText: "My App",
            headerImage: UIImage(named: "logo")
        ) {
            // Handle dismiss
            print("User dismissed")
        }
        
        present(glideVC, animated: true)
    }
}
```

### App Clip Integration Example

```swift
import SwiftUI
import GlideAppClipSDK

@main
struct MyAppClip: App {
    var body: some Scene {
        WindowGroup {
            GlideVerificationView(
                headerText: "Quick Access",
                headerImage: UIImage(named: "clip-icon")
            )
        }
    }
}
```

## UI Features

The verification view includes:

- **Loading State**: Shows a spinner while checking entitlements
- **Status Badge**: Displays entitlement status (Valid/Missing) with color-coded indicator
- **Custom Header**: Configurable text and image
- **Error Display**: Shows detailed error messages if entitlement validation fails
- **Close Button**: Navigation bar button to dismiss the view

### Customization Options

- **`headerText`** (String?, optional): Custom text for the header. Defaults to "Glide"
- **`headerImage`** (UIImage?, optional): Custom image for the header. Defaults to shield icon
- **`onDismiss`** (() -> Void, optional): Callback when user taps close button

## Requirements

- iOS 15.0+
- Swift 5.9+
- Xcode 15.0+
- CoreTelephony framework (automatically linked)

## Platform Support

- ✅ iOS Device (with SIM card for full validation)
- ✅ iOS Simulator (validation always passes)
- ❌ macOS (not supported)

## Notes

- Designed specifically for iOS App Clips
- Entitlement validation requires a real device with SIM card for accurate results
- On simulator, entitlement check automatically passes for development
- The CommCenter entitlement may require special approval from Apple

## License

See LICENSE file for details.
