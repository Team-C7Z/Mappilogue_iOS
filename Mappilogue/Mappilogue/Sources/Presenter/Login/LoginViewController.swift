//
//  LogInViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/26.
//

import UIKit
import KakaoSDKAuth
import KakaoSDKUser
import KakaoSDKCommon

class LoginViewController: BaseViewController {
    private let logoImage = UIImageView()
    private let titleLabel = UILabel()
    private let kakaoLoginButton = UIButton()
    private let appleLoginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
    
        logoImage.image = UIImage(named: "common_logo")
        
        titleLabel.text = "맵필로그, 기억의 시작"
        titleLabel.textColor = .color1C1C1C
        titleLabel.font = .title01
        
        kakaoLoginButton.setImage(UIImage(named: "login_kakao"), for: .normal)
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
        appleLoginButton.setImage(UIImage(named: "login_apple"), for: .normal)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(logoImage)
        view.addSubview(titleLabel)
        view.addSubview(kakaoLoginButton)
        view.addSubview(appleLoginButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(titleLabel.snp.top).offset(-17)
            $0.width.equalTo(82)
            $0.height.equalTo(40)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(kakaoLoginButton.snp.top).offset(-266)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(appleLoginButton.snp.top).offset(-8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(54)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-110)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(54)
        }
    }
    
    @objc private func kakaoLoginButtonTapped() {
        if UserApi.isKakaoTalkLoginAvailable() {
            UserApi.shared.loginWithKakaoTalk {(oauthToken, error) in
                self.handleKakaoTalkLogin(oauthToken: oauthToken, error: error)
            }
        } else {
            UserApi.shared.loginWithKakaoAccount {(oauthToken, error) in
                self.handleKakaoTalkLogin(oauthToken: oauthToken, error: error)
            }
        }
    }
    
    func handleKakaoTalkLogin(oauthToken: OAuthToken?, error: Error?) {
        if let error = error {
            print(error)
            return
        } else {
            guard let oauthToken = oauthToken else { return }
            let accessToken = oauthToken.accessToken
            
            AuthManager.shared.logIn(token: accessToken, socialVendor: .kakao, isAlarm: .active) { result in
                switch result {
                case .success(let response):
                    self.handleLoginResponse(response)
                default:
                    break
                }
            }
        }
    }
    
    private func handleLoginResponse(_ response: Any) {
        guard let baseResponse = response as? BaseResponse<AuthResponse>, let result = baseResponse.result else { return }
        
        AuthUserDefaults.accessToken = result.accessToken
        AuthUserDefaults.refreshToken = result.refreshToken
        
        guard let authType = AuthType(rawValue: result.type) else {
            return
        }
        
        switch authType {
        case .logIn:
            presentTabBarController()
        case .signUp:
            presentSignUpCompleteViewController()
        }
    }
    
    func presentSignUpCompleteViewController() {
        let signUpCompletionViewController = SignUpCompletionViewController()
        signUpCompletionViewController.modalPresentationStyle = .fullScreen
        signUpCompletionViewController.onTapped = {
            self.presentTabBarController()
        }
        present(signUpCompletionViewController, animated: false)
    }
    
    func presentTabBarController() {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: false)
    }
}
