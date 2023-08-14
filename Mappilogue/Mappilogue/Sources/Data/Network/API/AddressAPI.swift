//
//  AddressAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/14.
//

import Foundation
import Moya

enum AddressAPI {
    case address(long: Double, lat: Double)
    
    var endPoint: APIEndPoint {
        switch self {
        case .address:
            return .address
        }
    }
}

extension AddressAPI: TargetType {
    var baseURL: URL {
        return URL(string: NetworkService.shared.kakaoBaseURL)!
    }
    
    var path: String {
        return endPoint.path
    }
    
    var method: Moya.Method {
        switch self {
        case .address:
            return .get
        }
    }
    
    var task: Task {
        switch self {
        case let .address(long, lat):
            let requestParameters: [String: Any] = ["x": long, "y": lat]
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        ["Authorization": "KakaoAK \(NetworkService.shared.kakaoRestKey)"]
    }
}
