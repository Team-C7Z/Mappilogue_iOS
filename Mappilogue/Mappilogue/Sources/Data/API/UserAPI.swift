//
//  UserAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/01.
//

import Foundation
import Moya

enum UserAPI: BaseAPI {
    case logout
    case withdrawal(reason: String?)
    case termsOfUse
    case getNotificationSetting
    case updateNotificationSetting(notification: NotificationDTO)
    case getProfile
    case updateNickname(nickname: String)
    case updateProfileImage(image: MultipartFormData)
}

extension UserAPI: TargetType {
    var path: String {
        switch self {
        case .logout:
            return "/api/v1/users/logout"
        case .withdrawal:
            return "/api/v1/users/withdrawal"
        case .termsOfUse:
            return "/api/v1/users/tos"
        case .getNotificationSetting:
            return "/api/v1/users/alarms-setting"
        case .updateNotificationSetting:
            return "/api/v1/users/alarms-setting"
        case .getProfile:
            return "/api/v1/users/profile"
        case .updateNickname:
            return "/api/v1/users/nickname"
        case .updateProfileImage:
            return "/api/v1/users/profile-image"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .logout, .withdrawal:
            return .post
        case .termsOfUse, .getNotificationSetting, .getProfile:
            return .get
        case .updateNotificationSetting:
            return .put
        case .updateNickname, .updateProfileImage:
            return .patch
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .logout, .termsOfUse, .getNotificationSetting, .getProfile:
            return .requestPlain
            
        case let .withdrawal(reason):
            var requestParameters: [String: String] = [:]
            
            if let reason = reason {
                requestParameters["reason"] = reason
            }
            
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
            
        case let .updateNotificationSetting(notification):
            let requestParameters: [String: String] = [
                "isTotalAlarm": notification.isTotalNotification,
                "isNoticeAlarm": notification.isNoticeNotification,
                "isMarketingAlarm": notification.isMarketingNotification,
                "isScheduleReminderAlarm": notification.isScheduleReminderNotification
            ]
            
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
            
        case let .updateNickname(nickname):
            let requestParameters: [String: String] = [
                "nickname": nickname
            ]
            
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
            
        case let .updateProfileImage(image):
            return .uploadMultipart([image])
        }
    }
    
    var headers: [String: String]? {
        guard let token = AuthUserDefaults.accessToken else { return nil }
        
        switch self {
        case .updateProfileImage:
            return ["Authorization": "Bearer \(token)",
                    "Content-Type": "multipart/form-data"]
        default:
            return ["Authorization": "Bearer \(token)"]
        }
    }
}
