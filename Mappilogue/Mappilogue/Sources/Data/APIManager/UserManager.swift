//
//  UserManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/01.
//

import Foundation
import Moya
import Combine

class UserManager: UserAPI {
    private let baseURL = "\(Environment.baseURL)/api/v1/users/profiles"
    
    func getProfile() -> AnyPublisher<BaseDTOResult<ProfileDTO>, Error> {
        let url = URL(string: baseURL)!
        let request = setupRequest(for: url, method: "GET")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: BaseDTOResult<ProfileDTO>.self, decoder: JSONDecoder())
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
    
    func updateProfileImage(image: Data) -> AnyPublisher<BaseDTOResult<ProfileImageDTO>, Error> {
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
            .decode(type: BaseDTOResult<ProfileImageDTO>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getNotificationSetting() -> AnyPublisher<BaseDTOResult<NotificationDTO>, Error> {
        let url = URL(string: "\(baseURL)/alarm-settings")!
        let request = setupRequest(for: url, method: "GET")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: BaseDTOResult<NotificationDTO>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func updateNotificationSetting(notification: NotificationDTO) -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(baseURL)/alarm-settings")!
        var request = setupRequest(for: url, method: "PUT")
        
        let requestParameters: [String: Any] = [
            "isTotalAlarm": notification.isTotalNotification,
            "isNoticeAlarm": notification.isNoticeNotification,
            "isMarketingAlarm": notification.isMarketingNotification,
            "isScheduleReminderAlarm": notification.isScheduleReminderNotification
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
    
    func getTermsOfUse() -> AnyPublisher<BaseDTOResult<TermsOfUserDTO>, Error> {
        let url = URL(string: "\(baseURL)/terms-of-services")!
        let request = setupRequest(for: url, method: "GET")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: BaseDTOResult<TermsOfUserDTO>.self, decoder: JSONDecoder())
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
