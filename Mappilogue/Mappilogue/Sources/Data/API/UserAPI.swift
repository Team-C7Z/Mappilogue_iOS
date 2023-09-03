//
//  UserAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/01.
//

import Foundation
import Moya

enum UserAPI: BaseAPI {
    case logout
    case withdrawal(reason: String?)
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .logout:
            return "/api/v1/users/logout"
        case .withdrawal:
            return "/api/v1/users/withdrawal"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .logout:
            return .post
        case .withdrawal:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .logout:
            return .requestPlain
        case let .withdrawal(reason):
            var requestParameters: [String: String] = [:]
            
            if let reason = reason {
                requestParameters["reason"] = reason
            }
            
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        }
    }
}
