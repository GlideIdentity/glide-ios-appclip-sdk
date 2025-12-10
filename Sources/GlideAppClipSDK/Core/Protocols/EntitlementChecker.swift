//
//  EntitlementChecker.swift
//  GlideAppClipSDK
//
//  Created by amir avisar on 09/12/2025.
//

import Foundation

protocol EntitlementChecker {
    func checkEntitlement() -> Result<Bool, GlideAppClipError>
}
