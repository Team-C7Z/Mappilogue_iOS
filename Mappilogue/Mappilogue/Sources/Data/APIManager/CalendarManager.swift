//
//  CalendarManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/19.
//

import Foundation
import Moya

struct CalendarManager {
    static let shared = CalendarManager()
    private let provider = MoyaProvider<CalendarAPI>(plugins: [NetworkLoggerPlugin()])
    private let interceptorSessionProvider = MoyaProvider<CalendarAPI>(session: Session(interceptor: Interceptor()), plugins: [NetworkLoggerPlugin()])
  
    func getCalendar(year: Int, month: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.getCalendar(year: year, month: month)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTOResult<CalendarDTO>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getCalendarDetail(date: String, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.getCalendarDetail(date: date)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTOResult<CalendarDetailDTO>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func addSchedule(schedule: Schedule, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.addSchedule(schedule: schedule)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTOResult<AddScheduleDTO>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getSchedule(id: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.getSchedule(id: id)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTOResult<GetScheduleDTO>.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func updateSchedule(id: Int, schedule: Schedule, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.updateSchedule(id: id, schedule: schedule)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTO.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func deleteSchedule(id: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.deleteSchedule(id: id)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTO.self)
                completion(networkResult)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func judgeStatus<T: Codable>(_ statusCode: Int, _ data: Data, _ dataModel: T.Type) -> NetworkResult<Any> {
          let decoder = JSONDecoder()
          switch statusCode {
          case 200...204:
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
