//
//  PermissionViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/24.
//

import UIKit
import MappilogueKit

class PermissionViewController: BaseViewController {
    weak var coordinator: PermissionCoordinator?
    
    private let permissionLabel = UILabel()
    private let stackView = UIStackView()
    private let notificationView = PermissionView()
    private let imageView = PermissionView()
    private let cameraView = PermissionView()
    private let locationView = PermissionView()
    private let startButton = UIButton()
    private let startButtonLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        permissionLabel.setTextWithLineHeight(text: "앱 서비스 접근 권한을\n허용해 주세요", lineHeight: 30)
        permissionLabel.textColor = .color000000
        permissionLabel.font = .title01
        permissionLabel.numberOfLines = 0
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 29
        
        notificationView.configure(image: Images.image(named: .imagePermissionNotification), size: CGSize(width: 24, height: 24), title: "알림", subTitle: "미리 알림 및 공지사항의 푸시 알림")
        imageView.configure(image: Images.image(named: .imagePermissionImage), size: CGSize(width: 24, height: 24), title: "사진", subTitle: "기록 작성 시 업로드할 사진 접근")
        cameraView.configure(image: Images.image(named: .imagePermissionCamera), size: CGSize(width: 28, height: 24), title: "카메라", subTitle: "촬영 후 사진 업로드")
        locationView.configure(image: Images.image(named: .imagePermissionLocation), size: CGSize(width: 24, height: 30), title: "위치", subTitle: "현재 위치에서 기록 검색")
        
        startButton.backgroundColor = .black1C1C1C
        startButton.layer.cornerRadius = 12
        startButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        startButtonLabel.text = "허용하고 시작하기"
        startButtonLabel.textColor = .whiteFFFFFF
        startButtonLabel.font = .subtitle01
        startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(permissionLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(notificationView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(cameraView)
        stackView.addArrangedSubview(locationView)
        view.addSubview(startButton)
        startButton.addSubview(startButtonLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        permissionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(105)
            $0.leading.equalToSuperview().offset(16)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(218)
            $0.leading.equalToSuperview().offset(18)
            $0.trailing.equalToSuperview().offset(-18)
        }
        
        startButton.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
            $0.height.equalTo(94)
        }
        
        startButtonLabel.snp.makeConstraints {
            $0.top.equalTo(startButton).offset(28)
            $0.centerX.equalTo(startButton)
        }
    }
    
    @objc private func startButtonTapped(_ sender: UIButton) {
        RootUserDefaults.setPermissionComplete()
    
        coordinator?.showSelectPermissionViewController()
    }
}
