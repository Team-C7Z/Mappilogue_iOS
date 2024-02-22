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
    private static let fcmTokenKey = "fcmToken"
    
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
    
    static var fcmToken: String? {
        get {
            return UserDefaults.standard.string(forKey: fcmTokenKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: fcmTokenKey)
        }
    }
    
    static func autoLogin(completion: @escaping (Bool) -> Void) {
        if accessToken != nil {
            guard let refreshToken = refreshToken else {
                completion(false)
                return
            }
          
            AuthManager.shared.updateAccessToken(token: refreshToken) { result in
                switch result {
                case .success(let response):
                    handleRefreshTokenResponse(response, completion: completion)
                default:
                    completion(false)
                }
            }
        } else {
            completion(false)
        }
    }
    
    private static func handleRefreshTokenResponse(_ response: Any, completion: @escaping (Bool) -> Void) {
        guard let baseResponse = response as? BaseDTOResult<RefreshTokenDTO>, let result = baseResponse.result else { return }
        
        AuthUserDefaults.accessToken = result.accessToken
        AuthUserDefaults.refreshToken = result.refreshToken
        completion(true)
    }
}
