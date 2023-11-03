//
//  CategoryAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/03.
//

import Foundation
import Moya

enum CategoryAPI: BaseAPI {
    case addCategory(title: String)
    case getCategory
}

extension CategoryAPI: TargetType {
    var path: String {
        switch self {
        case .addCategory:
            return "/api/v1/marks/categories"
        case .getCategory:
            return "/api/v1/marks/categories"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .addCategory:
            return .post
        case .getCategory:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .addCategory(title):
            let requestParameters: [String: String] = [
                "title": title
            ]
            
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
            
        default:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        guard let token = AuthUserDefaults.accessToken else { return nil }
        
        return ["Authorization": "Bearer \(token)"]
    }
}
