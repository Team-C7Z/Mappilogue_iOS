//
//  ProfileViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import UIKit
import Combine

class ProfileViewModel {
    var cancellables: Set<AnyCancellable> = []
    private let userManager = UserManager()
    
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
}
