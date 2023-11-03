//
//  AddScheduleDTO.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/23.
//

import Foundation

struct AddScheduleDTO: Codable {
    var title: String?
    var colorId: Int
    var startDate: String
    var endDate: String
    var alarmOptions: [String]?
    var area: [AddSchedule]?
}

struct AddSchedule: Codable {
    var date: String
    var value: [AddSchduleLocation]
}

struct AddSchduleLocation: Codable {
    var name: String
    var streetAddress: String
    var latitude: String
    var longitude: String
    var time: String?
}

struct AddSchduleResponse: Codable {
    var newScheduleId: Int
}
