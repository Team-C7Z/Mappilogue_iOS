//
//  LoginViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import UIKit
import KakaoSDKAuth
import AuthenticationServices
import Combine

class LoginViewModel {
    @Published var loginResult: AuthDTO?
    var cancellables: Set<AnyCancellable> = []
    private let authManager = AuthManager2()
    
    var isAlarmAccept: ActiveStatus = .inactive
    
    func socialLogin(auth: Auth) {
        return authManager.socialLogin(auth: auth)
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    break
                case .failure:
                    print("error")
                }
            }, receiveValue: { response in
                self.loginResult = response.result
                
            })
            .store(in: &cancellables)
    }
}
