//
//  Notification.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/13.
//

import UIKit

struct NotificationData {
    var color: UIColor
    var date: String
    var time: String
    var text: String
}

func dummyNotificaitonData() -> [NotificationData] {
    let notification = [
        NotificationData(color: .marineBAD7FA, date: "9월 13일", time: "11:00 AM", text: "놀이공원"),
        NotificationData(color: .yellowF5DC82, date: "9월 1일", time: "7:00 PM", text: "포스트 말론 티켓팅 💫")
    ]
    
    return notification
}
