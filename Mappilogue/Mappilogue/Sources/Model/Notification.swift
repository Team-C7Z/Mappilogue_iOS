//
//  Notification.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import Foundation

struct NotificationInfo {
    var title: String
    var isSwitch: Bool
}

func notificationInfoData() -> [NotificationInfo] {
    let notificationInfo = [
        NotificationInfo(title: "공지사항 알림", isSwitch: false),
        NotificationInfo(title: "일정 미리 알림", isSwitch: false),
        NotificationInfo(title: "마케팅 알림", isSwitch: false)
    ]
    return notificationInfo
}
