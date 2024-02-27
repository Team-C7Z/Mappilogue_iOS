//
//  MyViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import UIKit

protocol ProfileReloadViewDelegate: AnyObject {
    func reloadView()
}

protocol LogoutDelegate: AnyObject {
    func logoutAccount()
}

class MyViewModel {
    weak var profileDelegate: ProfileReloadViewDelegate?
    weak var logoutDelegate: LogoutDelegate?
    var profileResult: ProfileDTO?
    
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
        MyManager.shared.getProfile { result in
            switch result {
            case .success(let response):
                guard let baseResponse = response as? BaseDTOResult<ProfileDTO>, let result = baseResponse.result else { return }
                self.profileResult = result
                self.profileDelegate?.reloadView()
            default:
                break
            }
        }
    }
    
    func logout() {
        AuthManager.shared.logout { _ in
            self.logoutDelegate?.logoutAccount()
        }
    }
}
