//
//  NetworkLoggerPlugin.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/28.
//

import Foundation
import Moya

class NetworkLoggerPlugin: PluginType {
    func willSend(_ request: RequestType, target: TargetType) {
        guard let _ = request.request else {
            print("Invalid Request")
            return
        }
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case let .success(response):
            print("Logger - SUCCESS")
            print(response.statusCode)
        case let .failure(error):
            print("Logger - FAILURE")
            print(error)
        }
    }
}
