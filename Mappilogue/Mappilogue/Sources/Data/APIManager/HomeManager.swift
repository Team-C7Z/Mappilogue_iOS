//
//  HomeManager.swift
//  Mappilogue
//
//  Created by hyemi on 2/26/24.
//

import Foundation
import Moya

struct HomeManager {
    static let shared = HomeManager()
    private let provider = MoyaProvider<HomeAPI>(plugins: [NetworkLoggerPlugin()])
    private let interceptorSessionProvider = MoyaProvider<HomeAPI>(session: Session(interceptor: Interceptor()), plugins: [NetworkLoggerPlugin()])
  
    func getHome(option: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.getHome(option: option)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTOResult<HomeDTO>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func judgeStatus<T: Codable>(_ statusCode: Int, _ data: Data, _ dataModel: T.Type) -> NetworkResult<Any> {
          let decoder = JSONDecoder()
          switch statusCode {
          case 200:
              guard let decodedData = try? decoder.decode(dataModel.self, from: data) else { return .pathError }
              return .success(decodedData)
          case 400...401:
              guard let decodedData = try? decoder.decode(ErrorDTO.self, from: data) else { return .pathError }
              return .requestError(decodedData)
          case 500:
              return .serverError
          default:
              return .networkFail
          }
      }
}
