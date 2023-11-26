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
    var cancellables: Set<AnyCancellable> = []
    private let userManager = UserManager2()
    
    func getCategory() {
        return userManager.getProfile()
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
}
