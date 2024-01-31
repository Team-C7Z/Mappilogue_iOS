//
//  CalendarManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/19.
//

import Foundation
import Combine
import Moya

struct CalendarManager: CalendarAPI {
    private let baseURL = "\(Environment.baseURL)/api/v1/schedules/"
    
    func getCalendar(calendar: Calendar1) -> AnyPublisher<BaseDTO<CalendarDTO>, Error> {
        let url = URL(string: "\(baseURL)calendars?year=\(calendar.year)&month=\(calendar.month)")!
        let request = setupRequest(for: url, method: "Get")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                print(data, response, 22)
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: BaseDTO<CalendarDTO>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func getScheduleDetail(date: String) -> AnyPublisher<BaseDTO<ScheduleDetailDTO>, Error> {
        let url = URL(string: "\(baseURL)detail-by-date?date=\(date)")!
        let request = setupRequest(for: url, method: "Get")
      
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: BaseDTO<ScheduleDetailDTO>.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    func deleteSchedule(id: Int) -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(baseURL)\(id)")!
        let request = setupRequest(for: url, method: "DELETE")

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { _, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 else {
                    throw URLError(.badServerResponse)
                }
              
                return
            }
            .eraseToAnyPublisher()
    }
    
    private func setupRequest(for url: URL, method: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let token = AuthUserDefaults.accessToken {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        return request
    }
}

struct CalendarManager111 {
    static let shared = CalendarManager111()
    private let provider = MoyaProvider<CalendarAPI111>(plugins: [NetworkLoggerPlugin()])
    private let interceptorSessionProvider = MoyaProvider<CalendarAPI111>(session: Session(interceptor: Interceptor()), plugins: [NetworkLoggerPlugin()])
  
    func getCalendar(year: Int, month: Int, completion: @escaping (NetworkResult<Any>) -> Void) {
        provider.request(.getCalendar(year: year, month: month)) { result in
            switch result {
            case .success(let response):
                let statusCode = response.statusCode
                let data = response.data
                let networkResult = self.judgeStatus(statusCode, data, BaseDTO<CalendarDTO>.self)
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
