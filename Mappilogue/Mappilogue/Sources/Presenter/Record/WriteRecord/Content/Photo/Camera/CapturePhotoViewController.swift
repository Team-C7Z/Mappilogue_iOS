//
//  CapturePhotoViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/09.
//

import UIKit

class CapturePhotoViewController: BaseViewController {
    var onDismiss: (() -> Void)?
    private var photo: UIImage?
    
    private let capturePhoto = UIImageView()
    private let retackButton = UIButton()
    private let usePhotoButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        retackButton.setTitle("다시 찍기", for: .normal)
        retackButton.setTitleColor(.color2EBD3D, for: .normal)
        retackButton.titleLabel?.font = .subtitle01
        retackButton.addTarget(self, action: #selector(retakePhoto), for: .touchUpInside)
        
        usePhotoButton.setTitle("사진 사용", for: .normal)
        usePhotoButton.setTitleColor(.color2EBD3D, for: .normal)
        usePhotoButton.titleLabel?.font = .subtitle01
        usePhotoButton.addTarget(self, action: #selector(usePhoto), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(capturePhoto)
        view.addSubview(retackButton)
        view.addSubview(usePhotoButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        capturePhoto.snp.makeConstraints {
            $0.top.equalToSuperview().offset(135)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.frame.width * (4 / 3))
        }
        
        retackButton.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(capturePhoto.snp.bottom).offset(47)
            $0.leading.equalToSuperview().offset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-63)
        }
        
        usePhotoButton.snp.makeConstraints {
            $0.centerY.equalTo(retackButton)
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
    
    func configure(_ photo: UIImage) {
        self.photo = photo
        capturePhoto.image = photo
    }
    
    @objc private func retakePhoto() {
        navigationController?.popViewController(animated: false)
    }
    
    @objc private func usePhoto() {
        if let navigationController = self.navigationController {
            let viewControllers = navigationController.viewControllers
            
            let viewController = viewControllers[1]
            navigationController.popToViewController(viewController, animated: false)
            
            if let editProfileViewController = viewController as? EditProfileViewController, let photo {
                editProfileViewController.updateProfilePhotoImage(photo)
            }
        }
    }
}
