//
//  GetScheduleDTO.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/22.
//

import Foundation

struct GetScheduleDTO: Codable {
    let scheduleBaseInfo: ScheduleBaseInfo
    let scheduleAlarmInfo: [String]
    let scheduleAreaInfo: [ScheduleAreaInfo]
}

struct ScheduleBaseInfo: Codable {
    let id: Int
    let userId: Int
    let colorId: Int
    let startDate: String
    let endDate: String
    let isAlarm: String
    let title: String
    let colorCode: String
}

struct ScheduleAreaInfo: Codable {
    let date: String
    let value: [Value]
}

struct Value: Codable {
    let scheduleAreaId: Int
    let name: String
    let streetAddress: String
    let latitude: String
    let longitude: String
    let time: String
    let sequence: Int
}
