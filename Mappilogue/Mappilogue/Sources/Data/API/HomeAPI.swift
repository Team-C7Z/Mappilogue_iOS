//
//  HomeAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2/26/24.
//

import Foundation
import Moya

enum HomeAPI: BaseAPI {
    case getHome(option: String)
    case getAnnouncement(pageNo: Int = 1, pageSize: Int = 10)
}

extension HomeAPI: TargetType {
    var path: String {
        switch self {
        case .getHome:
            return "/api/v1/users/homes"
        case .getAnnouncement:
            return "/api/v1/users/homes/announcements"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getHome, .getAnnouncement:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .getHome(option):
            let requestParameters: [String: Any] = [
                "option": option
            ]
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        case let .getAnnouncement(pageNo, pageSize):
            let requestParameters: [String: Any] = [
                "pageNo": pageNo,
                "pageSize": pageSize
            ]
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        }
        
    }
}
