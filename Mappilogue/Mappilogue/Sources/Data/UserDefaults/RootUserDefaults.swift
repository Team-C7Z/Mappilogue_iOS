//
//  RootManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/05.
//

import Foundation

class RootUserDefaults {
    private static let onboardingCompleteKey = "isOnboardingComplete"
    private static let permissionCompleteKey = "isPermissionComplete"
    
    static func isOnboardingNeeded() -> Bool {
        return !UserDefaults.standard.bool(forKey: onboardingCompleteKey)
    }
    
    static func setOnboardingComplete() {
        UserDefaults.standard.set(true, forKey: onboardingCompleteKey)
    }
    
    static func isPermissionNeeded() -> Bool {
        return !UserDefaults.standard.bool(forKey: permissionCompleteKey)
    }
    
    static func setPermissionComplete() {
        UserDefaults.standard.set(true, forKey: permissionCompleteKey)
    }
}
