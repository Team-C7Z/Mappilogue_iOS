//
//  CalendarAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/19.
//

import Foundation
import Moya

enum CalendarAPI: BaseAPI {
    case getCalendar(year: Int, month: Int)
    case getCalendarDetail(date: String)
    case addSchedule(schedule: Schedule)
    case getSchedule(id: Int)
    case updateSchedule(id: Int, schedule: Schedule)
    case deleteSchedule(id: Int)
}

extension CalendarAPI: TargetType {
    var path: String {
        switch self {
        case .getCalendar:
            return "api/v1/schedules/calendars"
        case .getCalendarDetail:
            return "/api/v1/schedules/detail-by-date"
        case .addSchedule:
            return "/api/v1/schedules"
        case .getSchedule:
            return "/api/v1/schedules/detail-by-id"
        case .updateSchedule(let id, _):
            return "/api/v1/schedules/\(id)"
        case .deleteSchedule(let id):
            return "/api/v1/schedules/\(id)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCalendar, .getCalendarDetail, .getSchedule:
            return .get
        case .addSchedule:
            return .post
        case .updateSchedule:
            return .put
        case .deleteSchedule:
            return .delete
        }
    }
    
    var task: Moya.Task {
        switch self {
        case let .getCalendar(year, month):
            let requestParameters: [String: Any] = [
                "year": year,
                "month": month
            ]
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        case let .getCalendarDetail(date):
            let requestParameters: [String: Any] = [
                "date": date
            ]
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
        case let .addSchedule(schedule):
          
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
            return .requestParameters(parameters: requestParameters, encoding: JSONEncoding.default)
        case let .getSchedule(id):
            return .requestParameters(parameters: ["scheduleId": id], encoding: URLEncoding.queryString)
        case let .updateSchedule(_, schedule):
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
            
            return .requestParameters(parameters: requestParameters, encoding: JSONEncoding.default)
        case .deleteSchedule:
            return .requestPlain
        }
    }
}
