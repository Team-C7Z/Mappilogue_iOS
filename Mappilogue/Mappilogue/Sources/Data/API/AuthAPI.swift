//
//  AuthAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/27.
//

import Foundation
import Moya
import Combine

enum AuthAPI {
    case socialLogin(auth: Auth)
    case refreshToken(token: String)
    case logout
    case withdrawal(reason: String?)
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .socialLogin:
            return "/api/v1/users/social-login"
        case .refreshToken:
            return "/api/v1/users/token-refresh"
        case .logout:
            return "/api/v1/users/logout"
        case .withdrawal:
            return "/api/v1/users/withdrawal"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case let .socialLogin(auth):
            var requestParameters: [String: Any] = [
                "socialAccessToken": auth.socialAccessToken,
                "socialVendor": auth.socialVendor
            ]
            
            if let fcmToken = auth.fcmToken {
                requestParameters["fcmToken"] = fcmToken
            }
            
            if let isAlarmValue = auth.isAlarmAccept {
                requestParameters["isAlarmAccept"] = isAlarmValue
            }
         
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
            
        case let .refreshToken(token):
            let requestParameters: [String: String] = [
                "refreshToken": token
            ]
            
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        case .logout:
            return .requestPlain
        case let .withdrawal(reason):
            var requestParameters: [String: Any] = [:]
            
            if let reason = reason {
                requestParameters["reason"] = reason
            }
            
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .socialLogin, .refreshToken:
            return nil
        case .logout, .withdrawal:
            guard let token = AuthUserDefaults.accessToken else { return nil }
            return ["Authorization": "Bearer \(token)"]
        }
    }
}

protocol AuthAPI2 {
    func socialLogin(auth: Auth) -> AnyPublisher<BaseDTOResult<AuthDTO>, Error>
    func logout() -> AnyPublisher<Void, Error>
    func withdrawal(reason: String?) -> AnyPublisher<Void, Error>
}
