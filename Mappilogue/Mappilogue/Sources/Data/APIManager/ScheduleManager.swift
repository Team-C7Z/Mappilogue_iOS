//
//  ScheduleManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/23.
//

import Foundation
import Moya

class ScheduleManager {
    static let shared = ScheduleManager()
    private let provider = MoyaProvider<ScheduleAPI>(plugins: [NetworkLoggerPlugin()])
    private let interceptorSessionProvider = MoyaProvider<ScheduleAPI>(session: Session(interceptor: Interceptor()), plugins: [NetworkLoggerPlugin()])
    
    func getColorList(completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.getColorList) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTO<[ColorListDTO]>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addSchedule(schedule: AddScheduleDTO, completion: @escaping (NetworkResult<Any>) -> Void) {
        interceptorSessionProvider.request(.addSchedule(schedule: schedule)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTO<String>.self)
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
