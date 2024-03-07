//
//  HomeManager.swift
//  Mappilogue
//
//  Created by hyemi on 2/26/24.
//

import Foundation
import Moya
import RxSwift
import RxMoya

struct HomeManager {
    static let shared = HomeManager()
    private let provider = MoyaProvider<HomeAPI>(plugins: [NetworkLoggerPlugin()])
    private let interceptorSessionProvider = MoyaProvider<HomeAPI>(session: Session(interceptor: Interceptor()), plugins: [NetworkLoggerPlugin()])
    let disposeBag = DisposeBag()
    
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
    
    func getAnnouncement(pageNo: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
          provider.request(.getAnnouncement(pageNo: pageNo)) { result in
              switch result {
              case .success(let response):
                  let statusCode = response.statusCode
                  let data = response.data
                  let networkResult = self.judgeStatus(statusCode, data, BaseDTOResult<[AnnouncementDTO]>.self)
                  completion(networkResult)
              case .failure(let error):
                  print(error)
              }
          }
      }
    
    func getAnnouncement1(pageNo: Int) -> Single<NetworkResult<BaseDTOResult<[AnnouncementDTO]>>> {
           return Single<NetworkResult<BaseDTOResult<[AnnouncementDTO]>>>.create { single in
               self.provider.request(.getAnnouncement(pageNo: pageNo)) { result in
                   switch result {
                   case .success(let response):
                       let networkResult = self.judgeStatus(response: response, type: [AnnouncementDTO].self)
                       single(.success(networkResult))
                       return
                   case .failure(let error):
                       single(.failure(error))
                       return
                   }
               }
               return Disposables.create()
           }
       }

       func judgeStatus<T: Codable>(response: Response, type: T.Type) -> NetworkResult<BaseDTOResult<T>> {
           let decoder = JSONDecoder()
           guard let decodedData = try? decoder.decode(BaseDTOResult<T>.self, from: response.data) else { return .pathError }

           switch response.statusCode {
           case 200..<300:
               if decodedData.statusCode >= 400 {
                   return .success(decodedData)
               } else {
                   return .success(decodedData)
               }
           case 400..<500:
               return .requestError(decodedData)
           case 500:
               return .serverError
           default:
               return .networkFail
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
