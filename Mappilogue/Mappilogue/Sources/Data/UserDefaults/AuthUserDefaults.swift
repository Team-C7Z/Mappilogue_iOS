//
//  AuthManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/29.
//

import Foundation

class AuthUserDefaults {
    private static let accessTokenKey = "accessToken"
    private static let refreshTokenKey = "refreshToken"
    
    static var accessToken: String? {
        get {
            return UserDefaults.standard.string(forKey: accessTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: accessTokenKey)
        }
    }
    
    static var refreshToken: String? {
        get {
            return UserDefaults.standard.string(forKey: refreshTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: refreshTokenKey)
        }
    }
}
