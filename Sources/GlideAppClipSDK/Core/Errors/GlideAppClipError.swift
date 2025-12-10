//
//  GlideAppClipError.swift
//  GlideAppClipSDK
//
//  Created by amir avisar on 09/12/2025.
//

import Foundation

public enum GlideAppClipError: Error {
    case entitlementMissing
    case entitlementCheckFailed(Error)
    case entitlementValueIncorrect(String)
    case unknown(Error)
    
    public var localizedDescription: String {
        switch self {
        case .entitlementMissing:
            return "CommCenter fine-grained entitlement is missing or has incorrect value. The entitlement 'com.apple.CommCenter.fine-grained' may require special approval from Apple for App Clips."
        case .entitlementCheckFailed(let error):
            return "Failed to check entitlement: \(error.localizedDescription)"
        case .entitlementValueIncorrect(let value):
            return "CommCenter entitlement value '\(value)' is incorrect. This entitlement may require Apple approval for production use."
        case .unknown(let error):
            return "An unknown error occurred: \(error.localizedDescription)"
        }
    }
}
