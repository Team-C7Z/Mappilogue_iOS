//
//  BaseTargetType.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/29.
//

import Foundation
import Moya

protocol BaseAPI: TargetType {}

extension BaseAPI {
    var baseURL: URL {
        URL(string: Environment.baseURL)!
    }
    
    var headers: [String: String]? {
        guard let token = AuthUserDefaults.accessToken else { return nil }
        return ["Authorization": "Bearer \(token)"]
    }
}
