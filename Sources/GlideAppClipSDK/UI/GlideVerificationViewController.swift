//
//  GlideVerificationViewController.swift
//  GlideSwiftSDK
//
//  Created by amir avisar on 01/12/2025.
//

#if canImport(UIKit) && canImport(SwiftUI)
import UIKit
import SwiftUI

// MARK: - UIKit ViewController
public class GlideVerificationViewController: UIViewController {
    
    private let headerText: String?
    private let headerImage: UIImage?
    private let onDismiss: (() -> Void)?
    
    public init(
        headerText: String? = nil,
        headerImage: UIImage? = nil,
        onDismiss: (() -> Void)? = nil
    ) {
        self.headerText = headerText
        self.headerImage = headerImage
        self.onDismiss = onDismiss
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        embedSwiftUIView()
    }
    
    private func embedSwiftUIView() {
        let swiftUIView = GlideVerificationView(
            headerText: headerText,
            headerImage: headerImage,
            onDismiss: onDismiss ?? { [weak self] in self?.dismiss(animated: true) }
        )
        
        let hostingController = UIHostingController(rootView: swiftUIView)
        addChild(hostingController)
        view.addSubview(hostingController.view)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        hostingController.didMove(toParent: self)
    }
}

// MARK: - SwiftUI View
public struct GlideVerificationView: View {
    
    private let headerText: String?
    private let headerImage: UIImage?
    private let onDismiss: (() -> Void)?
    
    public init(
        headerText: String? = nil,
        headerImage: UIImage? = nil,
        onDismiss: (() -> Void)? = nil
    ) {
        self.headerText = headerText
        self.headerImage = headerImage
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
        NavigationView {
            VStack {
                Spacer()
                HeaderView(text: headerText, image: headerImage)
                Spacer()
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") { onDismiss?() }
                }
            }
        }
    }
}
#endif
