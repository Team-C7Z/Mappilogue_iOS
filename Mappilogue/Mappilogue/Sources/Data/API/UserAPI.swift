//
//  UserAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/01.
//

import Foundation
import Moya
import Combine

enum UserAPI: BaseAPI {
    case logout
    case withdrawal(reason: String?)
}

extension UserAPI: TargetType {
    var path: String {
        switch self {
        case .logout:
            return "/api/v1/users/logout"
        case .withdrawal:
            return "/api/v1/users/withdrawal"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .logout, .withdrawal:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .logout:
            return .requestPlain
            
        case let .withdrawal(reason):
            var requestParameters: [String: String] = [:]
            
            if let reason = reason {
                requestParameters["reason"] = reason
            }
            
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        guard let token = AuthUserDefaults.accessToken else { return nil }
    
        return ["Authorization": "Bearer \(token)"]
        
    }
}

protocol UserAPI2 {
    func getProfile() -> AnyPublisher<BaseDTO<ProfileDTO>, Error>
    func updateNickname(nickname: String) -> AnyPublisher<Void, Error>
    func updateProfileImage(image: Data) -> AnyPublisher<BaseDTO<ProfileImageDTO>, Error>
    func getNotificationSetting() -> AnyPublisher<BaseDTO<NotificationDTO>, Error>
    func updateNotificationSetting(notification: NotificationDTO) -> AnyPublisher<Void, Error>
    func getTermsOfUse() -> AnyPublisher<BaseDTO<TermsOfUserDTO>, Error>
}
