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
        completion(.success(urlRequest))
      
    }
    
    func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}
