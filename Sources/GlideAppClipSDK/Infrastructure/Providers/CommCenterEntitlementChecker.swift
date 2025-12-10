//
//  CommCenterEntitlementChecker.swift
//  GlideAppClipSDK
//
//  Created by amir avisar on 09/12/2025.
//

import Foundation
#if canImport(CoreTelephony)
import CoreTelephony
#endif

final class CommCenterEntitlementChecker: EntitlementChecker {
    
    func checkEntitlement() -> Result<Bool, GlideAppClipError> {
        #if os(iOS) && canImport(CoreTelephony)
        let subscriber = CTSubscriber()
        let hasEntitlement = subscriber.carrierToken != nil
        return .success(hasEntitlement)
        #else
        return .success(false)
        #endif
    }
}

