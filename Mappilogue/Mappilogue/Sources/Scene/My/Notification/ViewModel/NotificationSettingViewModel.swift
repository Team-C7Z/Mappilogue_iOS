//
//  NotificationSettingViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import UIKit
import Combine

class NotificationSettingViewModel {
    var notificationResult: NotificationDTO?
    
    func getNotificationSetting() {
        MyManager.shared.getNotificationSetting { result in
            switch result {
            case .success(let response):
                guard let baseResponse = response as? BaseDTOResult<NotificationDTO>, let result = baseResponse.result else { return }
                self.notificationResult = result
            default:
                break
            }
        }
    }
    
    func updateNotificationSetting(notification: NotificationDTO) {
//        userManager.updateNotificationSetting(notification: notification)
//            .receive(on: DispatchQueue.main)
//            .sink(receiveCompletion: { completion in
//                switch completion {
//                case .finished:
//                    break
//                case .failure:
//                    print("error")
//                }
//            }, receiveValue: { _ in })
//            .store(in: &cancellables)
    }
    
    func switchToggle(_ notification: String?) -> String {
        guard let notification = notification else { return "" }
        
        let currentType = ActiveStatus(rawValue: notification)
        let newType: ActiveStatus = currentType == .active ? .inactive : .active
        
        return newType.rawValue
    }
}
