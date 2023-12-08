//
//  TermsOfUseViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import Foundation
import Combine

class TermsOfUseViewModel {
    @Published var termsOfUserResult: TermsOfUserDTO?
    
    var cancellables: Set<AnyCancellable> = []
    private let userManager = UserManager()
    
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
