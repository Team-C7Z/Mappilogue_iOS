//
//  NotificationDTO.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/03.
//

import Foundation

struct NotificationDTO: Codable {
    var isTotalNotification: String
    var isNoticeNotification: String
    var isScheduleReminderNotification: String
    var isMarketingNotification: String
    
    enum CodingKeys: String, CodingKey {
        case isTotalNotification = "isTotalAlarm"
        case isNoticeNotification = "isNoticeAlarm"
        case isScheduleReminderNotification = "isScheduleReminderAlarm"
        case isMarketingNotification = "isMarketingAlarm"
    }
}
