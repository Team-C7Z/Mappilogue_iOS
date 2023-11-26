//
//  ScheduleDetailDTO.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/21.
//

import Foundation

struct ScheduleDetailDTO: Codable {
    let solarDate: String
    let lunarDate: String
    let schedulesOnSpecificDate: [SchedulesOnSpecificDate]
}

struct SchedulesOnSpecificDate: Codable {
    let scheduleId: Int
    let startDate: String
    let endDate: String
    let title: String
    let colorId: Int
    let colorCode: String
    let areaName: String
    let areaTime: String
}
