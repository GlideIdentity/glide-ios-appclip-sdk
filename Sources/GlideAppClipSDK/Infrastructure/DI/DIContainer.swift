//
//  DIContainer.swift
//  GlideAppClipSDK
//
//  Created by amir avisar on 09/12/2025.
//

import Foundation

internal final class DIContainer {
    
    static let shared = DIContainer()
    
    private init() {}
    
    // MARK: - Providers
    internal func provideEntitlementChecker() -> EntitlementChecker {
        return CommCenterEntitlementChecker()
    }
    
    // MARK: - Use Cases
    internal func provideCheckEntitlementUseCase() -> CheckEntitlementUseCase {
        return CheckEntitlementUseCase(entitlementChecker: provideEntitlementChecker())
    }
}
