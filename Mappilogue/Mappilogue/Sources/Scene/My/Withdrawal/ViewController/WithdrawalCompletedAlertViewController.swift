//
//  WithdrawalCompletedAlertViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/11.
//

import UIKit

class WithdrawalCompletedAlertViewController: BaseViewController {
    private let alertView = UIView()
    private let titleLabel = UILabel()
    private let goToLoginButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .gray404040.withAlphaComponent(0.1)
        
        alertView.layer.cornerRadius = 12
        alertView.backgroundColor = .grayF9F8F7
        
        titleLabel.text = "탈퇴가 완료되었어요"
        titleLabel.textColor = .color000000
        titleLabel.font = .title02
    
        goToLoginButton.layer.cornerRadius = 12
        goToLoginButton.backgroundColor = .green2EBD3D
        goToLoginButton.setTitle("로그인 페이지로 돌아가기", for: .normal)
        goToLoginButton.setTitleColor(.whiteFFFFFF, for: .normal)
        goToLoginButton.titleLabel?.font = .body03
        goToLoginButton.addTarget(self, action: #selector(goToLogin), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(alertView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(goToLoginButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        alertView.snp.makeConstraints {
            $0.width.equalTo(278)
            $0.height.equalTo(140)
            $0.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(32)
            $0.centerX.equalTo(alertView)
        }
        
        goToLoginButton.snp.makeConstraints {
            $0.bottom.equalTo(alertView).offset(-10)
            $0.centerX.equalTo(alertView)
            $0.width.equalTo(248)
            $0.height.equalTo(42)
        }
    }
    
    @objc func goToLogin() {
        presentLoginViewController()
    }
    
    private func presentLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: false)
    }
}
