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
    case getNotificationSetting
}

extension MyAPI: TargetType {
    var path: String {
        switch self {
        case .getProfile:
            return "/api/v1/user-profiles"
        case .getNotificationSetting:
            return "/api/v1/user-profiles/alarm-settings"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getProfile, .getNotificationSetting:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getProfile, .getNotificationSetting:
            return .requestPlain
        }
    }
}
