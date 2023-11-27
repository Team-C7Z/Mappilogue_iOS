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
import AuthenticationServices

class LoginViewController: BaseViewController {
    private var isAlarmAccept: ActiveStatus = .inactive
    
    private let logoImage = UIImageView()
    private let titleLabel = UILabel()
    private let kakaoLoginButton = UIButton()
    private let appleLoginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkNotificationAuthorizationStatus()
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
        appleLoginButton.addTarget(self, action: #selector(appleLoginButtonTapped), for: .touchUpInside)
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

            let auth = Auth(socialAccessToken: accessToken, socialVendor: .kakao, fcmToken: AuthUserDefaults.fcmToken, isAlarmAccept: isAlarmAccept)
            AuthManager.shared.logIn(auth: auth) { result in
                switch result {
                case .success(let response):
                    self.handleLoginResponse(response)
                default:
                    break
                }
            }
        }
    }
    
    @objc func appleLoginButtonTapped() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    private func handleLoginResponse(_ response: Any) {
        guard let baseResponse = response as? BaseDTO<AuthDTO>, let result = baseResponse.result else { return }
        
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

extension LoginViewController {
    func checkNotificationAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.isAlarmAccept = .active
            case .denied:
                self.isAlarmAccept = .inactive
            default:
                break
            }
        }
    }
}


extension LoginViewController: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding{
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        switch authorization.credential {
        case let appleIDCredential as ASAuthorizationAppleIDCredential:
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
            
            if  let authorizationCode = appleIDCredential.authorizationCode,
                let identityToken = appleIDCredential.identityToken,
                let authCodeString = String(data: authorizationCode, encoding: .utf8),
                let identifyTokenString = String(data: identityToken, encoding: .utf8) {
                print("authorizationCode: \(authorizationCode)")
                print("identityToken: \(identityToken)")
                print("authCodeString: \(authCodeString)")
                print("identifyTokenString: \(identifyTokenString)")
            }
            
            print("useridentifier: \(userIdentifier)")
            print("fullName: \(fullName)")
            print("email: \(email)")
            
        case let passwordCredential as ASPasswordCredential:
            let username = passwordCredential.user
            let password = passwordCredential.password
            
            print("username: \(username)")
            print("password: \(password)")
            
        default:
            break
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // 로그인 실패(유저의 취소도 포함)
        print("login failed - \(error.localizedDescription)")
    }
}
