//
//  AuthViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/27.
//

import Foundation
import Combine

class AuthViewModel {
    @Published var profileResult: ProfileDTO?
    
    var cancellables: Set<AnyCancellable> = []
    private let authManager = AuthManager2()
    
    func logout() -> AnyPublisher<Void, Error> {
        authManager.logout()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func withdrawal(reason: String?) -> AnyPublisher<Void, Error> {
        authManager.withdrawal(reason: reason)
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
