//
//  CalendarAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/19.
//

import Foundation
import Moya
import Combine

enum CalendarAPI111: BaseAPI {
    case getCalendar(year: Int, month: Int)
    case getScheduleDetail(date: String)
}

extension CalendarAPI111: TargetType {
    var path: String {
        switch self {
        case .getCalendar:
            return "api/v1/schedules/calendars"
        case .getScheduleDetail:
            return "/api/v1/schedules/detail-by-date"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCalendar:
            return .get
        case .getScheduleDetail:
            return .get
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
        case let .getScheduleDetail(date):
            let requestParameters: [String: Any] = [
                "date": date
            ]
            return .requestParameters(parameters: requestParameters, encoding: URLEncoding.default)
            
        }
    }
}

protocol CalendarAPI {
    func getScheduleDetail(date: String) -> AnyPublisher<BaseDTO<ScheduleDetailDTO>, Error>
    func deleteSchedule(id: Int) -> AnyPublisher<Void, Error>
}
