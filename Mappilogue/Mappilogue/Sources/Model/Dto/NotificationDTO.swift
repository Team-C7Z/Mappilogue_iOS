//
//  NotificationDTO.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/03.
//

import Foundation

struct NotificationDTO: Codable {
    let isTotalAlarm: String
    let isNoticeAlarm: String
    let isMarketingAlarm: String
    let isScheduleReminderAlarm: String
}
