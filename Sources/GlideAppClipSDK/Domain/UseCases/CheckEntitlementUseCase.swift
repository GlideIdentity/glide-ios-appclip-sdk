//
//  CheckEntitlementUseCase.swift
//  GlideAppClipSDK
//
//  Created by amir avisar on 09/12/2025.
//

import Foundation

final class CheckEntitlementUseCase {
    
    private let entitlementChecker: EntitlementChecker
    
    init(entitlementChecker: EntitlementChecker) {
        self.entitlementChecker = entitlementChecker
    }
    
    func execute() -> Result<Bool, GlideAppClipError> {
        return entitlementChecker.checkEntitlement()
    }
}
