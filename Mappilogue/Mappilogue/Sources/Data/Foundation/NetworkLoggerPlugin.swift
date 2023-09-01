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
        guard request.request != nil else {
            print("Invalid Request")
            return
        }
    }
    
    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case let .success(response):
            onSucceed(response)
        case let .failure(error):
            onFail(error)
        }
    }
}

extension NetworkLoggerPlugin {
    func onSucceed(_ response: Response) {
        let log = """
            ===================== SUCCESS 🎁 =====================
            ✔️ url: \(response.request?.url?.absoluteString ?? "")
            ✔️ response: \(String(bytes: response.data, encoding: String.Encoding.utf8) ?? "")
            ✔️ status code: \(response.statusCode)
            """
        print(log)
    }
    
    func onFail(_ error: MoyaError) {
        let log = """
            ===================== FAILURE ❌ =====================
            ✔️ url: \(error.response?.request?.url?.absoluteString ?? "")
            ✔️ status code: \(error.response?.statusCode ?? 0)
            """
        print(log)
    }
}
