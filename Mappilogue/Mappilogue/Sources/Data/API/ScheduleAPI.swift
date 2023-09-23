//
//  ScheduleAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/23.
//

import Foundation
import Moya

enum ScheduleAPI: BaseAPI {
    case getColorList
}

extension ScheduleAPI: TargetType {
    var path: String {
        switch self {
        case .getColorList:
            return "/api/v1/schedules/colors"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getColorList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getColorList:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        switch self {
        case .getColorList:
            return nil
        }
    }
}
