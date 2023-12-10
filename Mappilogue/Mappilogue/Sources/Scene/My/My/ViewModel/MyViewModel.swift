//
//  MyViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import UIKit
import Combine

class MyViewModel {
    @Published var profileResult: ProfileDTO?
    
    var cancellables: Set<AnyCancellable> = []
    private let authManager = AuthManager2()
    private let userManager = UserManager()
    
    var myInfoData: [[MyInfo]] = [
        [
            MyInfo(image: "my_notification", title: "알림 설정"),
            MyInfo(image: "my_terms", title: "이용약관"),
            MyInfo(image: "my_inquiry", title: "문의하기")
        ],
        [
            MyInfo(image: "my_logout", title: "로그아웃"),
            MyInfo(image: "my_withdrawal", title: "탈퇴하기")
        ]
    ]
    
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
    
    func logout() -> AnyPublisher<Void, Error> {
        authManager.logout()
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}
