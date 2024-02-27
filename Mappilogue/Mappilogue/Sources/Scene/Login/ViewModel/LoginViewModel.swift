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

protocol LoginDelegate: AnyObject {
    func showViewController(result: AuthDTO)
}

class LoginViewModel {
    weak var delegate: LoginDelegate?
    
    var isAlarmAccept: ActiveStatus = .inactive
    
    func socialLogin(auth: Auth) {
        AuthManager.shared.socialLogin(auth: auth) { result in
            switch result {
            case .success(let response):
                guard let baseResponse = response as? BaseDTOResult<AuthDTO>, let result = baseResponse.result else { return }
                self.delegate?.showViewController(result: result)
            default:
                break
            }
        }
    }
}
