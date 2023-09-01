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
    private let nickNameTitleLabel = UILabel()
    private let editNickNameTextField = UITextField()
    private let editNickNameImage = UIImageView()
    private let nickNameLineView = UIView()
    private let loginAccountTitleLabel = UILabel()
    private let loginAccountImage = UIImageView()
    private let loginAccountLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationTitleAndBackButton("프로필 편집", backButtonAction: #selector(backButtonTapped))
        
        profileImage.image = UIImage(named: "my_profile")
        
        editProfileImageImage.image = UIImage(named: "my_editProfileImage")
        
        editProfileImageLabel.text = "사진 편집"
        editProfileImageLabel.textColor = .colorFFFFFF
        editProfileImageLabel.font = .caption03
        
        nickNameTitleLabel.text = "닉네임"
        nickNameTitleLabel.textColor = .color707070
        nickNameTitleLabel.font = .body02
        
        editNickNameTextField.placeholder = "8자 이하의 한글/영문"
        editNickNameTextField.text = "맵필로그"
        editNickNameTextField.textColor = .color1C1C1C
        editNickNameTextField.font = .title02
        editNickNameTextField.returnKeyType = .done
        editNickNameTextField.delegate = self
        
        editNickNameImage.image = UIImage(named: "my_editNickName")
        
        nickNameLineView.backgroundColor = .color1C1C1C
        
        loginAccountTitleLabel.text = "로그인 계정"
        loginAccountTitleLabel.textColor = .color707070
        loginAccountTitleLabel.font = .body02
        
        loginAccountImage.image = UIImage(named: "my_kakaoAccount")
        
        loginAccountLabel.text = "mappilogue@kakao.com"
        loginAccountLabel.textColor = .color707070
        loginAccountLabel.font = .caption01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(profileImage)
        profileImage.addSubview(editProfileImageImage)
        editProfileImageImage.addSubview(editProfileImageLabel)
        view.addSubview(nickNameTitleLabel)
        view.addSubview(editNickNameTextField)
        view.addSubview(editNickNameImage)
        view.addSubview(nickNameLineView)
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
        
        nickNameTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(25)
            $0.leading.equalTo(profileImage.snp.trailing).offset(20)
        }
        
        editNickNameTextField.snp.makeConstraints {
            $0.leading.equalTo(nickNameTitleLabel)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(46)
        }
        
        editNickNameImage.snp.makeConstraints {
            $0.leading.equalTo(editNickNameTextField.snp.trailing).offset(8)
            $0.centerY.equalTo(editNickNameTextField)
            $0.width.equalTo(12)
            $0.height.equalTo(11)
        }
        
        nickNameLineView.snp.makeConstraints {
            $0.top.equalTo(editNickNameTextField.snp.bottom).offset(2)
            $0.leading.equalTo(editNickNameTextField)
            $0.trailing.equalTo(editNickNameImage.snp.trailing)
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
    
    func updateTextFieldPlaceHolder() {
        //
    }
}

extension EditProfileViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        updateTextFieldPlaceHolder()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
