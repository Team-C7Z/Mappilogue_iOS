//
//  NotificationViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import Foundation

class NotificationViewModel {
    var notificationData: [NotificationData] = []
    var announcementData: [AnnouncementData] = []
    var isAnnouncementExpanded = [Bool]()
    
    var notificationType: NotificationType = .notification
    
    init() {
        isAnnouncementExpanded = Array(repeating: false, count: announcementData.count)
    }
    
    func removeNotification(at index: Int) {
        notificationData.remove(at: index)
    }
}
