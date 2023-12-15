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
import MappilogueKit

class LoginViewController: BaseViewController {
    weak var coordinator: LoginCoordinator?
    var viewModel = LoginViewModel()
    
    private let logoImage = UIImageView()
    private let kakaoLoginButton = KakaoLoginButton()
    private let appleLoginButton = AppleLoginButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        checkNotificationAuthorizationStatus()
    }
    
    override func setupProperty() {
        super.setupProperty()
    
        logoImage.image = Icons.icon(named: .logo)
        
        kakaoLoginButton.addTarget(self, action: #selector(kakaoLoginButtonTapped), for: .touchUpInside)
     
        appleLoginButton.addTarget(self, action: #selector(appleLoginButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(logoImage)
        view.addSubview(kakaoLoginButton)
        view.addSubview(appleLoginButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        logoImage.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalToSuperview().offset(-113)
            $0.width.equalTo(256)
            $0.height.equalTo(56)
        }
        
        kakaoLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(appleLoginButton.snp.top).offset(-8)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        appleLoginButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-110)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
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
        
            let socialVendor = AuthVendor.kakao.rawValue
            let isAlarmAccept = ActiveStatus.inactive.rawValue
            let auth = Auth(socialAccessToken: accessToken, socialVendor: socialVendor, fcmToken: AuthUserDefaults.fcmToken, isAlarmAccept: isAlarmAccept)

            viewModel.socialLogin(auth: auth)

            viewModel.$loginResult
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: { result in
                    guard let result else { return }
                    
                    self.handleLoginResponse(result)
                })
                .store(in: &viewModel.cancellables)
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
    
    private func handleLoginResponse(_ result: AuthDTO) {
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
      //  coordinator?.presentTabBarController()
        coordinator?.showSignUpCompletionViewController()
    }
}

extension LoginViewController {
    func checkNotificationAuthorizationStatus() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            switch settings.authorizationStatus {
            case .authorized:
                self.viewModel.isAlarmAccept = .active
            case .denied:
                self.viewModel.isAlarmAccept = .inactive
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
