//
//  CalendarDTO.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/19.
//

import Foundation

struct CalendarDTO: Codable {
    let calendarSchedules: [CalendarSchedules]
}

struct CalendarSchedules: Codable {
    let scheduleId: Int
    let userId: Int
    let colorId: Int
    let startDate: String
    let endDate: String
    let title: String
    let colorCode: String
}
