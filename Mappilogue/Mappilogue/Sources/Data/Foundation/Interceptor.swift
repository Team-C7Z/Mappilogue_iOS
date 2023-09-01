//
//  Interceptor.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/29.
//

import Foundation
import Alamofire

class Interceptor: RequestInterceptor {
    static let shared = Interceptor()
    
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var adaptedRequest = urlRequest
        adaptedRequest.setValue(AuthUserDefaults.accessToken, forHTTPHeaderField: "Authorization")
        
        completion(.success(adaptedRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        if let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401, let refreshToken = AuthUserDefaults.refreshToken {
            AuthManager.shared.updateAccessToken(token: refreshToken) { result in
                switch result {
                case .success(let response):
                    if let baseResponse = response as? BaseResponse<RefreshTokenResponse>, let result = baseResponse.result {
                        AuthUserDefaults.accessToken = result.accessToken
                        AuthUserDefaults.refreshToken = result.refreshToken
                    }
                    completion(.retry)
                default:
                    completion(.doNotRetry)         
                }
            }
        } else {
            completion(.doNotRetry)
        }
    }
}
