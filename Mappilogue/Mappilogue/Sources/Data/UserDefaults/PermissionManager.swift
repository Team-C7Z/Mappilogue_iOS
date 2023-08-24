//
//  PermissionManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/24.
//

import Foundation

class PermissionManager {
    private static let permissionCompleteKey = "isPermissionComplete"
    
    static func isPermissionNeeded() -> Bool {
        return !UserDefaults.standard.bool(forKey: permissionCompleteKey)
    }
    
    static func setPermissionComplete() {
        UserDefaults.standard.set(true, forKey: permissionCompleteKey)
    }
}
