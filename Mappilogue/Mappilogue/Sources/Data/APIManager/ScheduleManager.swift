//
//  ScheduleManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/23.
//

import Foundation
import Combine

class ScheduleManager: ScheduleAPI {
    private let baseURL = URL(string: "\(Environment.baseURL)/api/v1/schedules")!
    
    func addSchedule(schedule: AddSchedule) -> AnyPublisher<BaseDTO<AddScheduleDTO>, Error> {
        var request = setupRequest(for: baseURL, method: "POST")
        
        var requestParameters: [String: Any] = [
            "colorId": schedule.colorId,
            "startDate": schedule.startDate,
            "endDate": schedule.endDate
        ]
        
        if let title = schedule.title {
            requestParameters["title"] = title
        }
        
        if let alarmOptions = schedule.alarmOptions {
            requestParameters["alarmOptions"] = alarmOptions
        }
        
        if let area = schedule.area {
            requestParameters["area"] = area.map { areaList in
                return [
                    "date": areaList.date,
                    "value": areaList.value.map { location in
                        var locationInfo: [String: Any] = [
                            "name": location.name
                        ]
                        if let streetAddress = location.streetAddress {
                            locationInfo["streetAddress"] = streetAddress
                        }
                        if let latitude = location.latitude {
                            locationInfo["latitude"] = latitude
                        }
                        if let longitude = location.longitude {
                            locationInfo["longitude"] = longitude
                        }
                        if let time = location.time {
                            locationInfo["time"] = time
                        }

                        return locationInfo
                    }
                ] as [String: Any]
            }
        }
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestParameters)
        } catch {
            return Fail(error: CategoryAPIError.serializationError(error)).eraseToAnyPublisher()
        }

        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                    throw URLError(.badServerResponse)
                }
            
                return data
            }
            .decode(type: BaseDTO<AddScheduleDTO>.self, decoder: JSONDecoder())
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
