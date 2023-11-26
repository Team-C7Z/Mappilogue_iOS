//
//  AuthManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/27.
//

import Foundation
import Moya
import Combine

class AuthManager {
    static let shared = AuthManager()
    private let provider = MoyaProvider<AuthAPI>(plugins: [NetworkLoggerPlugin()])
  
    func logIn(auth: Auth, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.socialLogin(token: auth.socialAccessToken, socialVendor: auth.socialVendor.rawValue, fcmToken: auth.fcmToken, isAlarm: auth.isAlarmAccept?.rawValue)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTO<AuthDTO>.self)
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
                let networkResult = self.judgeStatus(statusCode, data, BaseDTO<RefreshTokenDTO>.self)
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
            guard let decodedData = try? decoder.decode(ErrorDTO.self, from: data) else { return .pathError }
            return .requestError(decodedData)
        case 500:
            return .serverError
        default:
            return .networkFail
        }
    }
}

class AuthManager2: AuthAPI2 {
    private let baseURL = "\(Environment.baseURL)/api/v1/users"
    
    func logout() -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(baseURL)/logout")!
        let request = setupRequest(for: url, method: "POST")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { _, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 else {
                    throw URLError(.badServerResponse)
                }
                return
            }
            .eraseToAnyPublisher()
        
    }
    
    private func setupRequest(for url: URL, method: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = AuthUserDefaults.accessToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}
