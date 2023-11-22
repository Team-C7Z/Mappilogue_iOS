//
//  CalendarAPI.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/19.
//

import Foundation
import Combine

protocol CalendarAPI {
    func getCalendar(calendar: Calendar1) -> AnyPublisher<BaseDTO<CalendarDTO>, Error>
    func getScheduleDetail(date: String) -> AnyPublisher<BaseDTO<ScheduleDetailDTO>, Error>
}
