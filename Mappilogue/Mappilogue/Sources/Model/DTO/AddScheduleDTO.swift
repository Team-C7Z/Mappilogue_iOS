//
//  AddScheduleDTO.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/23.
//

import Foundation

struct AddScheduleDTO {
    var title: String?
    var colorId: Int
    var startDate: String
    var endDate: String
    var alarmOptions: [String]?
    var area: [AddSchedule]?
}

struct AddSchedule {
    var date: String
    var value: [AddSchduleLocation]
}

struct AddSchduleLocation {
    var name: String
    var streetAddress: String
    var latitude: String
    var longitude: String
}
