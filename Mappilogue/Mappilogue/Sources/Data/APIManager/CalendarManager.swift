//
//  CalendarManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/19.
//

import Foundation
import Combine

struct CalendarManager: CalendarAPI {
    private let baseURL = "\(Environment.baseURL)/api/v1/schedules/"
    
    func getCalendar(calendar: Calendar1) -> AnyPublisher<BaseDTO<CalendarDTO>, Error> {
        let url = URL(string: "\(baseURL)calenders?year=\(calendar.year)&month=\(calendar.month)")!
        let request = setupRequest(for: url, method: "Get")
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
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
