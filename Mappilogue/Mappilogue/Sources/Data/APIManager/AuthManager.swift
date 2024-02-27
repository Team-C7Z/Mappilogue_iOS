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
    
    func socialLogin(auth: Auth, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.socialLogin(auth: auth)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTOResult<AuthDTO>.self)
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
                let networkResult = self.judgeStatus(statusCode, data, BaseDTOResult<RefreshTokenDTO>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func logout(completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.logout) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTO.self)
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
    
    func socialLogin(auth: Auth) -> AnyPublisher<BaseDTOResult<AuthDTO>, Error> {
        let url = URL(string: "\(baseURL)/social-login")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
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
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestParameters)
        } catch {
            return Fail(error: CategoryAPIError.serializationError(error)).eraseToAnyPublisher()
        }
     
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: BaseDTOResult<AuthDTO>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
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
    
    func withdrawal(reason: String?) -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(baseURL)/withdrawal")!
        var request = setupRequest(for: url, method: "POST")
        
        var requestParameters: [String: Any] = [:]
        
        if let reason = reason {
            requestParameters["reason"] = reason
        }
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestParameters)
        } catch {
            return Fail(error: CategoryAPIError.serializationError(error)).eraseToAnyPublisher()
        }

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
