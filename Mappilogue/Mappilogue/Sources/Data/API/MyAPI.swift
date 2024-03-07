//
//  MyAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2/26/24.
//

import Foundation
import Moya

enum MyAPI: BaseAPI {
    case getProfile
    case updateNickname(nickname: String)
    case updateProfileImage(image: MultipartFormData)
    case getNotificationSetting
    case updateNotificationSetting(notification: NotificationDTO)
    case termsOfUse
    case logout
    case withdrawal(reason: String?)
}

extension MyAPI: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseURL)!
    }

    var path: String {
        switch self {
        case .getProfile:
            return "/api/v1/user-profiles"
        case .updateNickname:
            return "/api/v1/user-profiles/nicknames"
        case .updateProfileImage:
                return "/api/v1/user-profiles/images"
        case .getNotificationSetting:
            return "/api/v1/user-profiles/alarm-settings"
        case .updateNotificationSetting:
            return "/api/v1/user-profiles/alarm-settings"
        case .termsOfUse:
            return "/api/v1/user-profiles/terms-of-services"
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

        case let .updateNickname(nickname):
            let requestParameters: [String: String] = [
                "nickname": nickname
            ]

            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        case let .updateProfileImage(image):
            return .uploadMultipart([image])
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
