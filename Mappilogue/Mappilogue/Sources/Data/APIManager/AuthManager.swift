//
//  AuthManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/27.
//

import Foundation
import Moya

class AuthManager {
    static let shared = AuthManager()
    private let provider = MoyaProvider<AuthAPI>(plugins: [NetworkLoggerPlugin()])
  
    func logIn(token: String, socialVendor: AuthVendor, isAlarm: NotificationType?, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.socialLogin(token: token, socialVendor: socialVendor.rawValue, isAlarm: isAlarm?.rawValue)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseResponse<AuthResponse>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateAccessToken(token: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.refreshToken(token: token)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseResponse<RefreshTokenResponse>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func judgeStatus<T: Codable>(_ statusCode: Int, _ data: Data, _ dataModel: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        switch statusCode {
        case 201:
            guard let decodedData = try? decoder.decode(dataModel.self, from: data) else { return .pathError }
            return .success(decodedData)
        case 400:
            guard let decodedData = try? decoder.decode(ErrorResponse.self, from: data) else { return .pathError }
            return .requestError(decodedData)
        case 500:
            return .serverError
        default:
            return .networkFail
        }
    }
}
