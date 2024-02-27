//
//  ScheduleManager.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/23.
//

import Foundation
import Combine

class ScheduleManager: ScheduleAPI {
    private let baseURL = "\(Environment.baseURL)/api/v1/schedules"
    
    func updateSchedule(id: Int, schedule: Schedule) -> AnyPublisher<Void, Error> {
        let url = URL(string: "\(baseURL)/\(id)")!
        var request = setupRequest(for: url, method: "PUT")
        
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
