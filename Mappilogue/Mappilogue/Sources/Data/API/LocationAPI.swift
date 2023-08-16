//
//  LocationAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/15.
//

import Foundation
import Moya

enum LocationAPI {
    case getAddress(long: Double, lat: Double)
    case search(keyword: String, page: Int = 1)
}

extension LocationAPI: TargetType {
    var baseURL: URL {
        return URL(string: Environment.kakaoAPI)!
    }

    var path: String {
        switch self {
        case .getAddress:
            return "/v2/local/geo/coord2address"
        case .search:
            return "/v2/local/search/keyword"
        }
        
    }

    var method: Moya.Method {
        switch self {
        case .getAddress:
            return .get
        case .search:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .getAddress(long, lat):
            let requestParameters: [String: Any] = ["x": long, "y": lat]
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        case let .search(keyword, page):
            let requestParameters: [String: Any] = ["query": keyword, "page": page]
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
            
        }
    }

    var headers: [String: String]? {
        return ["Authorization": "KakaoAK \(Environment.kakaoRestKey)"]
    }
}
