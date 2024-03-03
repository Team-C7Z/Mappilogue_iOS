//
//  NotificationViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import Foundation

protocol AnnouncementDelegate: AnyObject {
    func getAnnouncement()
}

class NotificationViewModel {
    weak var delegate: AnnouncementDelegate?
    
    var notificationData: [NotificationData] = []
    var announcements: [AnnouncementDTO] = []
    var isAnnouncementExpanded = [Bool]()
    
    var notificationType: NotificationType = .notification
    
    var currentPage = 1
    var totalPage = 10
    var isLoading = false
    
    init() {
        isAnnouncementExpanded = Array(repeating: false, count: announcements.count)
    }
    
    func removeNotification(at index: Int) {
        notificationData.remove(at: index)
    }
    
    func getAnnouncementData(pageNo: Int) {
        HomeManager.shared.getAnnouncement(pageNo: pageNo) { result in
            switch result {
            case .success(let response):
                guard let baseResponse = response as? BaseDTOResult<[AnnouncementDTO]>, let result = baseResponse.result else { return }
                self.isLoading = false
                self.announcements += result
                self.currentPage += 1
                for _ in 0..<10 {
                    self.isAnnouncementExpanded.append(false)
                }
                self.delegate?.getAnnouncement()
            default:
                break
            }
        }
    }
}
