//
//  GlideVerificationViewController.swift
//  GlideAppClipSDK
//
//  Created by amir avisar on 01/12/2025.
//

#if canImport(UIKit) && canImport(SwiftUI)
import UIKit
import SwiftUI

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
        
        let swiftUIView = GlideVerificationView(
            headerText: headerText,
            headerImage: headerImage,
            checkEntitlementUseCase: DIContainer.shared.provideCheckEntitlementUseCase(),
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

public struct GlideVerificationView: View {
    
    private let headerText: String?
    private let headerImage: UIImage?
    private let checkEntitlementUseCase: CheckEntitlementUseCase
    private let onDismiss: (() -> Void)?
    
    @State private var isLoading = true
    @State private var hasEntitlement = false
    @State private var error: GlideAppClipError?
    
    public init(
        headerText: String? = nil,
        headerImage: UIImage? = nil,
        onDismiss: (() -> Void)? = nil
    ) {
        self.headerText = headerText
        self.headerImage = headerImage
        self.checkEntitlementUseCase = DIContainer.shared.provideCheckEntitlementUseCase()
        self.onDismiss = onDismiss
    }
    
    internal init(
        headerText: String? = nil,
        headerImage: UIImage? = nil,
        checkEntitlementUseCase: CheckEntitlementUseCase,
        onDismiss: (() -> Void)? = nil
    ) {
        self.headerText = headerText
        self.headerImage = headerImage
        self.checkEntitlementUseCase = checkEntitlementUseCase
        self.onDismiss = onDismiss
    }
    
    public var body: some View {
        NavigationView {
            ZStack {
                if isLoading {
                    loadingView
                } else if let error = error {
                    errorView(error)
                } else {
                    contentView
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Close") { onDismiss?() }
                }
            }
            .onAppear { checkEntitlement() }
        }
    }
    
    private var loadingView: some View {
        VStack {
            ProgressView()
                .scaleEffect(1.5)
                .progressViewStyle(CircularProgressViewStyle())
            Text("Checking entitlements...")
                .foregroundColor(.gray)
                .padding(.top, 20)
        }
    }
    
    private func errorView(_ error: GlideAppClipError) -> some View {
        VStack(spacing: 20) {
            Image(systemName: "exclamationmark.triangle.fill")
                .font(.system(size: 60))
                .foregroundColor(.orange)
            
            Text("Entitlement Error")
                .font(.title2)
                .fontWeight(.bold)
            
            Text(error.localizedDescription)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
    
    private var contentView: some View {
        VStack {
            Spacer()
            
            VStack(spacing: 20) {
                statusBadge
                HeaderView(text: headerText, image: headerImage)
                statusText
            }
            
            Spacer()
        }
    }
    
    private var statusBadge: some View {
        HStack {
            Image(systemName: hasEntitlement ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(hasEntitlement ? .green : .red)
            Text(hasEntitlement ? "Entitlement: Valid" : "Entitlement: Missing")
                .font(.caption)
                .fontWeight(.semibold)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(hasEntitlement ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
        )
    }
    
    private var statusText: some View {
        Text(hasEntitlement 
             ? "CommCenter.fine-grained-entitlement (PublicSubscriberInfo) detected"
             : "CommCenter.fine-grained-entitlement (PublicSubscriberInfo) not found")
            .font(.caption)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 40)
    }
    
    private func checkEntitlement() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let result = checkEntitlementUseCase.execute()
            
            switch result {
            case .success(let entitlement):
                isLoading = false
                hasEntitlement = entitlement
                error = entitlement ? nil : .entitlementMissing
            case .failure(let err):
                isLoading = false
                hasEntitlement = false
                error = err
            }
        }
    }
}

#if DEBUG
struct GlideVerificationView_Previews: PreviewProvider {
    static var previews: some View {
        GlideVerificationView(headerText: "My App")
    }
}
#endif
#endif
