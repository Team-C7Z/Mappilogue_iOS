//
//  MyManager.swift
//  Mappilogue
//
//  Created by hyemi on 2/26/24.
//

import Foundation
import Moya

struct MyManager {
    static let shared = MyManager()
    private let provider = MoyaProvider<MyAPI>(plugins: [NetworkLoggerPlugin()])
    private let interceptorSessionProvider = MoyaProvider<MyAPI>(session: Session(interceptor: Interceptor()), plugins: [NetworkLoggerPlugin()])
    
    func getProfile(completion: @escaping (NetworkResult<Any>) -> Void) {
        interceptorSessionProvider.request(.getProfile) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTOResult<ProfileDTO>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }

    func updateNickname(nickname: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        interceptorSessionProvider.request(.updateNickname(nickname: nickname)) { result in
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
    
    func updateProfileImage(profileImage: Data, completion: @escaping (NetworkResult<Any>) -> Void) {
        let formData = MultipartFormData(provider: .data(profileImage), name: "image", fileName: "image.jpg", mimeType: "image/jpg")

        interceptorSessionProvider.request(.updateProfileImage(image: formData)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTOResult<ProfileImageDTO>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getNotificationSetting(completion: @escaping (NetworkResult<Any>) -> Void) {
        interceptorSessionProvider.request(.getNotificationSetting) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTOResult<NotificationDTO>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }

    func updateNotificationSetting(notification: NotificationDTO, completion: @escaping (NetworkResult<Any>) -> Void) {
        interceptorSessionProvider.request(.updateNotificationSetting(notification: notification)) { result in
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
    
    func termsOfUse(completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.termsOfUse) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTOResult<TermsOfUseDTO>.self)
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

    func withdrawal(reason: String?, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.withdrawal(reason: reason)) { result in
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
