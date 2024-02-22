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
    case refreshToken(token: String)
}

extension AuthAPI: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseURL)!
    }
    
    var path: String {
        switch self {
        case .refreshToken:
            return "/api/v1/users/token-refresh"
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var task: Moya.Task {
        switch self {
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
    func socialLogin(auth: Auth) -> AnyPublisher<BaseDTOResult<AuthDTO>, Error>
    func logout() -> AnyPublisher<Void, Error>
    func withdrawal(reason: String?) -> AnyPublisher<Void, Error>
}
