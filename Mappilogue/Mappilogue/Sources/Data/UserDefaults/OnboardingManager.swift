//
//  OnboardingManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/05.
//

import Foundation

class OnboardingManager {
    private static let onboardingCompleteKey = "isOnboardingComplete"
    
    static func isOnboardingNeeded() -> Bool {
        return !UserDefaults.standard.bool(forKey: onboardingCompleteKey)
    }
    
    static func setOnboardingComplete() {
        UserDefaults.standard.set(true, forKey: onboardingCompleteKey)
    }
}
