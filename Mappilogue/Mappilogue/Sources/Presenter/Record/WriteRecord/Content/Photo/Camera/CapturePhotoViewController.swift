//
//  CapturePhotoViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/09.
//

import UIKit

class CapturePhotoViewController: BaseViewController {
    private let captureImage = UIImageView()
    private let retackButton = UIButton()
    private let usePhotoButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()
    
        retackButton.setTitle("다시 찍기", for: .normal)
        retackButton.setTitleColor(.color2EBD3D, for: .normal)
        retackButton.titleLabel?.font = .subtitle01
        
        usePhotoButton.setTitle("사진 사용", for: .normal)
        usePhotoButton.setTitleColor(.color2EBD3D, for: .normal)
        usePhotoButton.titleLabel?.font = .subtitle01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(captureImage)
        view.addSubview(retackButton)
        view.addSubview(usePhotoButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        captureImage.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(view.safeAreaLayoutGuide)
            $0.top.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(47)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(view.frame.width * (4 / 3))
        }
        
        retackButton.snp.makeConstraints {
            $0.top.lessThanOrEqualTo(captureImage.snp.bottom).offset(47)
            $0.leading.equalToSuperview().offset(24)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-63)
        }
        
        usePhotoButton.snp.makeConstraints {
            $0.centerY.equalTo(retackButton)
            $0.trailing.equalToSuperview().offset(-24)
        }
    }
    
    func configure(_ image: UIImage) {
        captureImage.image = image
    }
}
