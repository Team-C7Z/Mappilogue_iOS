//
//  NotificationSettingViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import UIKit
import Combine

class NotificationSettingViewModel {
    @Published var notificationResult: NotificationDTO?
    
    var cancellables: Set<AnyCancellable> = []
    private let userManager = UserManager()
    
    func getNotificationSetting() {
        userManager.getNotificationSetting()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    print("error")
                }
            }, receiveValue: { response in
                self.notificationResult = response.result
            })
            .store(in: &cancellables)
    }
    
    func updateNotificationSetting(notification: NotificationDTO) {
        userManager.updateNotificationSetting(notification: notification)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    print("error")
                }
            }, receiveValue: { _ in })
            .store(in: &cancellables)
    }
    
    func switchToggle(_ notification: String?) -> String {
        guard let notification = notification else { return "" }
        
        let currentType = ActiveStatus(rawValue: notification)
        let newType: ActiveStatus = currentType == .active ? .inactive : .active
        
        return newType.rawValue
    }
}
