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
    case socialLogin(token: String, socialVendor: String, fcmToken: String?, isAlarm: String?)
    case refreshToken(token: String)
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
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case let .socialLogin(token, socialVendor, fcmToken, isAlarm):
            var requestParameters: [String: Any] = [
                "socialAccessToken": token,
                "socialVendor": socialVendor
            ]
            
            if let fcmToken = fcmToken {
                requestParameters["fcmToken"] = fcmToken
            }
            
            if let isAlarmValue = isAlarm {
                requestParameters["isAlarmAccept"] = isAlarmValue
            }
            
            return .requestParameters(parameters: requestParameters, encoding: JSONEncoding.default)
            
        case let .refreshToken(token):
            let requestParameters: [String: String] = [
                "refreshToken": token
            ]
            
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}

protocol AuthAPI2 {
    func logout() -> AnyPublisher<Void, Error>
}
