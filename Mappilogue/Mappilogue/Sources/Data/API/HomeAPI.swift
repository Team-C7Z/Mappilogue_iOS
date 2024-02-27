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
}

extension HomeAPI: TargetType {
    var path: String {
        switch self {
        case .getHome:
            return "/api/v1/users/homes"
            
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getHome:
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
        }
        
    }
}
