//
//  UserManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/01.
//

import Foundation
import Moya
import Combine

class UserManager {
    static let shared = UserManager()
    private let provider = MoyaProvider<UserAPI>(plugins: [NetworkLoggerPlugin()])
    private let interceptorSessionProvider = MoyaProvider<UserAPI>(session: Session(interceptor: Interceptor()), plugins: [NetworkLoggerPlugin()])
  
    func logout(completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.logout) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTO<String>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }

    func withdrawal(reason: String?, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.withdrawal(reason: reason)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTO<String>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func termsOfUse(completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.termsOfUse) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTO<TermsOfUserDTO>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }

    private func judgeStatus<T: Codable>(_ statusCode: Int, _ data: Data, _ dataModel: T.Type) -> NetworkResult<Any> {
        let decoder = JSONDecoder()
        switch statusCode {
        case 200:
            guard let decodedData = try? decoder.decode(dataModel.self, from: data) else { return .pathError }
            return .success(decodedData)
        case 400...401:
            guard let decodedData = try? decoder.decode(ErrorDTO.self, from: data) else { return .pathError }
            return .requestError(decodedData)
        case 500:
            return .serverError
        default:
            return .networkFail
        }
    }
}

class UserManager2: UserAPI2 {
    private let baseURL = "\(Environment.baseURL)/api/v1/users/profiles"
    
    func getProfile() -> AnyPublisher<BaseDTO<ProfileDTO>, Error> {
        let url = URL(string: baseURL)!
        let request = setupRequest(for: url, method: "GET")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: BaseDTO<ProfileDTO>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func updateNickname(nickname: String) -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(baseURL)/nicknames")!
        var request = setupRequest(for: url, method: "PATCH")
        
        let requestParameters: [String: Any] = [
            "nickname": nickname
        ]
        
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
    
    func updateProfileImage(image: Data) -> AnyPublisher<BaseDTO<ProfileImageDTO>, Error> {
        let url = URL(string: "\(baseURL)/images")!
        var request = setupRequest(for: url, method: "PATCH")
        let boundary = UUID().uuidString
        
        request.httpMethod = "PATCH"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        var body = Data()
        
        body.append("\r\n--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"image\"; filename=\"profile.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(image)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: BaseDTO<ProfileImageDTO>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getNotificationSetting() -> AnyPublisher<BaseDTO<NotificationDTO>, Error> {
        let url = URL(string: "\(baseURL)/alarm-settings")!
        let request = setupRequest(for: url, method: "GET")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: BaseDTO<NotificationDTO>.self, decoder: JSONDecoder())
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
