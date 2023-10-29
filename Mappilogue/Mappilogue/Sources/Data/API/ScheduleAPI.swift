//
//  ScheduleAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/23.
//

import Foundation
import Moya

enum ScheduleAPI: BaseAPI {
    case getColorList
    case addSchedule(schedule: AddScheduleDTO)
}

extension ScheduleAPI: TargetType {
    var path: String {
        switch self {
        case .getColorList:
            return "/api/v1/schedules/colors"
        case .addSchedule:
            return "/api/v1/schedules"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getColorList:
            return .get
        case .addSchedule:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getColorList:
            return .requestPlain
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
                            return [
                                "name": location.name,
                                "streetAddress": location.streetAddress,
                                "latitude": location.latitude,
                                "longitude": location.longitude
                            ]
                        }
                    ] as [String : Any]
                }
            }

            return .requestParameters(parameters: requestParameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        guard let token = AuthUserDefaults.accessToken else { return nil }
        
        switch self {
        case .getColorList:
            return nil
        case .addSchedule:
            return ["Authorization": "Bearer \(token)"]
        }
    }
}
