//
//  NotificationSettingViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import UIKit
import Combine

protocol NotificationSettingDelegate: AnyObject {
    func getNotification()
}

class NotificationSettingViewModel {
    weak var delegate: NotificationSettingDelegate?
    var notification = NotificationDTO(isTotalNotification: ActiveStatus.inactive.rawValue,
                                       isNoticeNotification: ActiveStatus.inactive.rawValue,
                                       isScheduleReminderNotification: ActiveStatus.inactive.rawValue,
                                       isMarketingNotification: ActiveStatus.inactive.rawValue)
    
    func getNotificationSetting() {
        MyManager.shared.getNotificationSetting { result in
            switch result {
            case .success(let response):
                guard let baseResponse = response as? BaseDTOResult<NotificationDTO>, let result = baseResponse.result else { return }
                self.notification = result
                self.delegate?.getNotification()
            default:
                break
            }
        }
    }
    
    func updateNotificationSetting(notification: NotificationDTO) {
        MyManager.shared.updateNotificationSetting(notification: notification) { result in
            switch result {
            case .success(let response):
                guard let baseResponse = response as? BaseDTOResult<NotificationDTO>, let result = baseResponse.result else { return }
                
            default:
                break
            }
        }
    }
    
    func switchToggle(_ notification: String?) -> String {
        guard let notification = notification else { return "" }
        let currentType = ActiveStatus(rawValue: notification)
        let newType: ActiveStatus = currentType == .active ? .inactive : .active
        
        return newType.rawValue
    }
}
