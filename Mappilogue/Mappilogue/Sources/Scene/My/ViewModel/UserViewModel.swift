//
//  UserViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/26.
//

import Foundation
import Combine

class UserViewModel {
    @Published var profileResult: ProfileDTO?
    @Published var notificationResult: NotificationDTO?
    @Published var termsOfUserResult: TermsOfUserDTO?
    
    var cancellables: Set<AnyCancellable> = []
    private let userManager = UserManager()
    
    func getProfile() {
        userManager.getProfile()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    print("error")
                }
            }, receiveValue: { response in
                self.profileResult = response.result
            })
            .store(in: &cancellables)
    }
    
    func updateNickname(nickname: String) {
        userManager.updateNickname(nickname: nickname)
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
    
    func updateProfileImage(image: Data) {
        userManager.updateProfileImage(image: image)
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
    
    func getTermsOfUse() {
        userManager.getTermsOfUse()
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    print("error")
                }
            }, receiveValue: { response in
                self.termsOfUserResult = response.result
            })
            .store(in: &cancellables)
        
    }
}
