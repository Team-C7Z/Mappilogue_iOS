//
//  EditProfileViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/31.
//

import UIKit
import Photos

class EditProfileViewController: BaseViewController {
    private let profileImageButton = UIButton()
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

        editNicknameTextFieldTapped()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationTitleAndBackButton("프로필 편집", backButtonAction: #selector(backButtonTapped))
        
        profileImageButton.addTarget(self, action: #selector(profileImageButtonTapped), for: .touchUpInside)
        
        profileImage.layer.cornerRadius = 44
        profileImage.layer.masksToBounds = true
        profileImage.contentMode = .scaleAspectFill
        
        editProfileImageImage.image = UIImage(named: "my_editProfileImage")
        
        editProfileImageLabel.text = "사진 편집"
        editProfileImageLabel.textColor = .colorFFFFFF
        editProfileImageLabel.font = .caption03
        
        nicknameTitleLabel.text = "닉네임"
        nicknameTitleLabel.textColor = .color707070
        nicknameTitleLabel.font = .body02
        
        editNicknameTextField.textColor = .color1C1C1C
        editNicknameTextField.font = .title02
        editNicknameTextField.tintColor = .color2EBD3D
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
        
        view.addSubview(profileImageButton)
        profileImageButton.addSubview(profileImage)
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
    
        profileImageButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.width.height.equalTo(88)
        }
        
        profileImage.snp.makeConstraints {
            $0.edges.equalTo(profileImageButton)
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
        let url = URL(string: profile.profileImageUrl)!
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self?.profileImage.image = image
                }
            }
        }
        
        editNicknameTextField.text = profile.nickname
        loginAccountLabel.text = profile.email
        let snsType = AuthVendor(rawValue: profile.snsType)
        loginAccountImage.image = UIImage(named: snsType == .kakao ? "my_kakaoAccount" : "my_appleAccount")
    }
    
    @objc private func profileImageButtonTapped() {
        checkAlbumPermission()
    }
    
    private func checkAlbumPermission() {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
        case .limited:
            presentImagePickerViewController(.limited)
        case .authorized:
            presentImagePickerViewController(.authorized)
        case .denied, .restricted:
            presentGalleyPermissionAlert()
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { status in
                if status == .limited {
                    self.presentImagePickerViewController(.limited)
                } else if status == .authorized {
                    self.presentImagePickerViewController(.authorized)
                } else {
                    self.presentGalleyPermissionAlert()
                }
            }
            print("Album: 선택하지 않음")
        default:
            break
        }
    }
    
    func presentGalleyPermissionAlert() {
        DispatchQueue.main.async {
            let alertViewController = AlertViewController()
            alertViewController.modalPresentationStyle = .overCurrentContext
            let alert = Alert(titleText: "사진 접근 권한을 허용해 주세요",
                              messageText: "사진 접근 권한을 허용하지 않을 경우\n일부 기능을 사용할 수 없어요",
                              cancelText: "닫기",
                              doneText: "설정으로 이동",
                              buttonColor: .color2EBD3D,
                              alertHeight: 182)
            alertViewController.configureAlert(with: alert)
            alertViewController.onDoneTapped = {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
            self.present(alertViewController, animated: false)
        }
    }
    
    func presentImagePickerViewController(_ status: PHAuthorizationStatus) {
        DispatchQueue.main.async {
            let imagePickerViewController = ImagePickerViewController()
            imagePickerViewController.authStatus = status
            imagePickerViewController.isProfile = true
            imagePickerViewController.onCompletion = { assets in
                if let asset = assets.first {
                    self.updateProfileImage(asset)
                }
            }
            imagePickerViewController.modalPresentationStyle = .fullScreen
            self.present(imagePickerViewController, animated: true)
        }
    }
    
    private func updateProfileImage(_ asset: PHAsset) {
        let imageManager = PHCachingImageManager()
        let options = PHImageRequestOptions()
       
        imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options) { image, _ in
            DispatchQueue.main.async {
                self.profileImage.image = image
            }
            
            if let image = image, let imageData = image.jpegData(compressionQuality: 1.0) {
                UserManager.shared.updateProfileImage(profileImage: imageData) { result in
                    switch result {
                    case .success(let response):
                        print(response)
                    default:
                        break
                    }
                }
            }
        }
    }
    
    func editNicknameTextFieldTapped() {
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
