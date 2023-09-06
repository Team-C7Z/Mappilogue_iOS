//
//  EditProfileViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/31.
//

import UIKit

class EditProfileViewController: BaseViewController {
    private let profileImage = UIImageView()
    private let editProfileImageImage = UIImageView()
    private let editProfileImageLabel = UILabel()
    private let nicknameTitleLabel = UILabel()
    private let editNicknameTextField = UITextField()
    private let editNicknameImage = UIImageView()
    private let nicknameLineView = UIView()
    private let loginAccountTitleLabel = UILabel()
    private let loginAccountImage = UIImageView()
    private let loginAccountLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        editNicnameTextFieldTapped()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationTitleAndBackButton("프로필 편집", backButtonAction: #selector(backButtonTapped))
        
        editProfileImageImage.image = UIImage(named: "my_editProfileImage")
        
        editProfileImageLabel.text = "사진 편집"
        editProfileImageLabel.textColor = .colorFFFFFF
        editProfileImageLabel.font = .caption03
        
        nicknameTitleLabel.text = "닉네임"
        nicknameTitleLabel.textColor = .color707070
        nicknameTitleLabel.font = .body02
        
        editNicknameTextField.textColor = .color1C1C1C
        editNicknameTextField.font = .title02
        editNicknameTextField.delegate = self
        
        editNicknameImage.image = UIImage(named: "my_editNickname")
        
        nicknameLineView.backgroundColor = .color1C1C1C
        
        loginAccountTitleLabel.text = "로그인 계정"
        loginAccountTitleLabel.textColor = .color707070
        loginAccountTitleLabel.font = .body02
        
        loginAccountImage.image = UIImage(named: "my_kakaoAccount")
        
        loginAccountLabel.textColor = .color707070
        loginAccountLabel.font = .caption01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(profileImage)
        profileImage.addSubview(editProfileImageImage)
        editProfileImageImage.addSubview(editProfileImageLabel)
        view.addSubview(nicknameTitleLabel)
        view.addSubview(editNicknameTextField)
        view.addSubview(editNicknameImage)
        view.addSubview(nicknameLineView)
        view.addSubview(loginAccountTitleLabel)
        view.addSubview(loginAccountImage)
        view.addSubview(loginAccountLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
    
        profileImage.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.width.height.equalTo(88)
        }
        
        editProfileImageImage.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(profileImage)
            $0.height.equalTo(22)
        }
        
        editProfileImageLabel.snp.makeConstraints {
            $0.top.equalTo(editProfileImageImage).offset(3)
            $0.centerX.equalTo(editProfileImageImage)
        }
        
        nicknameTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(25)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
        }
        
        editNicknameTextField.snp.makeConstraints {
            $0.leading.equalTo(nicknameTitleLabel)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(46)
        }
        
        editNicknameImage.snp.makeConstraints {
            $0.leading.equalTo(editNicknameTextField.snp.trailing).offset(8)
            $0.centerY.equalTo(editNicknameTextField)
            $0.width.equalTo(12)
            $0.height.equalTo(11)
        }
        
        nicknameLineView.snp.makeConstraints {
            $0.top.equalTo(editNicknameTextField.snp.bottom).offset(2)
            $0.leading.equalTo(editNicknameTextField)
            $0.trailing.equalTo(editNicknameImage.snp.trailing)
            $0.height.equalTo(1)
        }
        
        loginAccountTitleLabel.snp.makeConstraints {
            $0.top.equalTo(profileImage.snp.bottom).offset(24)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(15)
        }
        
        loginAccountImage.snp.makeConstraints {
            $0.top.equalTo(loginAccountTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(loginAccountTitleLabel)
            $0.width.height.equalTo(24)
        }
        
        loginAccountLabel.snp.makeConstraints {
            $0.centerY.equalTo(loginAccountImage)
            $0.leading.equalTo(loginAccountImage.snp.trailing).offset(8)
        }
    }
    
    func configure(_ profile: ProfileDTO) {
        if let profileImageUrl = profile.profileImageUrl, let url = URL(string: profileImageUrl) {
            DispatchQueue.global().async { [weak self] in
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.profileImage.image = image
                    }
                }
            }
        } else {
            profileImage.image = UIImage(named: "my_profile")
        }
        
        editNicknameTextField.text = profile.nickname
        loginAccountLabel.text = profile.email
        let snsType = AuthVendor(rawValue: profile.snsType)
        loginAccountImage.image = UIImage(named: snsType == .kakao ? "my_kakaoAccount" : "my_appleAccount")
    }
    
    func editNicnameTextFieldTapped() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(presentEditNicknameModalViewController))
        editNicknameTextField.addGestureRecognizer(tap)
    }
    
    @objc func presentEditNicknameModalViewController() {
        let editNicknameModalViewController = EditNicknameModalViewController()
        editNicknameModalViewController.modalPresentationStyle = .overFullScreen
        editNicknameModalViewController.configure(editNicknameTextField.text ?? "")
        editNicknameModalViewController.onChangeTapped = { nickname in
            self.changeNickname(nickname)
        }
        present(editNicknameModalViewController, animated: false)
    }
    
    private func changeNickname(_ nickname: String) {
        editNicknameTextField.text = nickname
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return false
    }
}
