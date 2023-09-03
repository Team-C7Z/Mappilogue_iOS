//
//  Interceptor.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/29.
//

import Foundation
import Alamofire

class Interceptor: RequestInterceptor {
    func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        guard urlRequest.url?.absoluteString.hasPrefix(Environment.baseURL) == true,
            let accessToken = AuthUserDefaults.accessToken,
            let refreshToken = AuthUserDefaults.refreshToken
        else {
            completion(.success(urlRequest))
            return
        }

        var urlRequest = urlRequest
        urlRequest.setValue(accessToken, forHTTPHeaderField: "accessToken")
        urlRequest.setValue(refreshToken, forHTTPHeaderField: "refreshToken")
        completion(.success(urlRequest))
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        print("진입")
        print(2222)
        guard let response = request.task?.response as? HTTPURLResponse, response.statusCode == 401
        else {
            completion(.doNotRetryWithError(error))
            return
        }
        print(3333)
        guard let refreshToken = AuthUserDefaults.refreshToken else { return }

        AuthManager.shared.updateAccessToken(token: refreshToken) { result in
            print(4444)
            switch result {
            case .success(let response):
                if let baseResponse = response as? BaseResponse<RefreshTokenResponse>, let result = baseResponse.result {
                    AuthUserDefaults.accessToken = result.accessToken
                    AuthUserDefaults.refreshToken = result.refreshToken
                }
                print(5555)
                completion(.retry)
            default:
                completion(.doNotRetry)
            }
        }
    
    }
}
