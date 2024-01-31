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
}

extension CalendarAPI111: TargetType {
    var path: String {
        switch self {
        case .getCalendar:
            return "api/v1/schedules/calendars"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCalendar:
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
        }
    }
}

protocol CalendarAPI {
    func getCalendar(calendar: Calendar1) -> AnyPublisher<BaseDTO<CalendarDTO>, Error>
    func getScheduleDetail(date: String) -> AnyPublisher<BaseDTO<ScheduleDetailDTO>, Error>
    func deleteSchedule(id: Int) -> AnyPublisher<Void, Error>
}
