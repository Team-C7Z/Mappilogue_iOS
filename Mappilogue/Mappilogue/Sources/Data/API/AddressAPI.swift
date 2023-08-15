//
//  AddressAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/15.
//

import Foundation
import Moya

enum AddressAPI {
    case getAddress(long: Double, lat: Double)
}

extension AddressAPI: TargetType {
    var baseURL: URL {
        return URL(string: Environment.kakaoAPI)!
    }

    var path: String {
        return "/v2/local/geo/coord2address"
    }

    var method: Moya.Method {
        switch self {
        case .getAddress:
            return .get
        }
    }

    var task: Task {
        switch self {
        case let .getAddress(long, lat):
            let requestParameters: [String: Any] = ["x": long, "y": lat]
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        }
    }

    var headers: [String: String]? {
        return ["Authorization": "KakaoAK \(Environment.kakaoRestKey)"]
    }
}
