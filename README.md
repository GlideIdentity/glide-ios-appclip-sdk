# GlideAppClipSDK

## Installation

### Swift Package Manager

```swift
dependencies: [
    .package(url: "https://github.com/amira-glide/glide-ios-appclip-sdk.git")
]
```

## Usage

### SwiftUI

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

### UIKit

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

## Requirements

- iOS 15.0+
- Swift 5.9+

