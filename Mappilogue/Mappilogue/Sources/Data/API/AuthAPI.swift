//
//  AuthAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/27.
//

import Foundation
import Moya

enum AuthAPI {
    case socialLogin(token: String, socialVendor: String, isAlarm: String?)
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseURL)!
    }
    
    var path: String {
        return "/api/v1/auth/social-login"
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
        case let .socialLogin(token, socialVendor, isAlarm):
            var requestParameters: [String: Any] = [
                "socialAccessToken": token,
                "socialVendor": socialVendor
            ]
            
            if let isAlarmValue = isAlarm {
                requestParameters["isAlarmAccept"] = isAlarmValue
            }
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
}
