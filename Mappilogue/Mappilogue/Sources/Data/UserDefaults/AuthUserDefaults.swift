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
    
    static func autoLogin(completion: @escaping (Bool) -> Void) {
        if let accessToken = accessToken {
            guard let refreshToken = refreshToken else {
                completion(false)
                return
            }
          
            AuthManager.shared.updateAccessToken(token: refreshToken) { result in
                switch result {
                case .success(let response):
                    if let baseResponse = response as? BaseResponse<RefreshTokenResponse>, let result = baseResponse.result {
                        AuthUserDefaults.accessToken = result.accessToken
                        AuthUserDefaults.refreshToken = result.refreshToken
                        completion(true)
                    }
                default:
                    completion(false)
                }
            }
        } else {
            completion(false)
        }
    }
}
