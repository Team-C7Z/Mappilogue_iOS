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
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: Environment.baseURL)!
    }
    
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
        }
    }
}
