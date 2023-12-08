//
//  VersionCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class VersionCell: BaseCollectionViewCell {
    static let registerId = "\(VersionCell.self)"
    
    var onVersionUpdate: (() -> Void)?
        
    private let versionInfoLabel = UILabel()
    private let stackView = UIStackView()
    private let currentVersionLabel = UILabel()
    private let versionSeparatorLabel = UILabel()
    private let latestVersionLabel = UILabel()
    private let updateButton = UIButton()
    private let updateLabel = UILabel()
    private let moveImage = UIImageView()
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .grayF5F3F0
        
        versionInfoLabel.text = "버전정보"
        versionInfoLabel.textColor = .color000000
        versionInfoLabel.font = .body02
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        
        currentVersionLabel.text = Utils.getAppVersion()
        currentVersionLabel.textColor = .gray707070
        currentVersionLabel.font = .body02
        
        versionSeparatorLabel.text = "/"
        versionSeparatorLabel.textColor = .gray707070
        versionSeparatorLabel.font = .body02
        
        latestVersionLabel.text = "1.0"  // Utils.loadAppStoreVersion()
        latestVersionLabel.textColor = .gray707070
        latestVersionLabel.font = .body02
        
        updateButton.addTarget(self, action: #selector(updateButtonTapped), for: .touchUpInside)
        
        updateLabel.text = "업데이트"
        updateLabel.textColor = .grayC9C6C2
        updateLabel.font = .body02
        
        moveImage.image = UIImage(named: "my_move")
        moveImage.tintColor = .grayC9C6C2
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(versionInfoLabel)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(currentVersionLabel)
        stackView.addArrangedSubview(versionSeparatorLabel)
        stackView.addArrangedSubview(latestVersionLabel)
        contentView.addSubview(updateButton)
        updateButton.addSubview(updateLabel)
        updateButton.addSubview(moveImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        versionInfoLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(12)
        }
        
        stackView.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(versionInfoLabel.snp.trailing).offset(8)
        }
        
        updateButton.snp.makeConstraints {
            $0.leading.equalTo(updateLabel.snp.leading)
            $0.trailing.equalTo(moveImage.snp.trailing)
            $0.height.equalTo(contentView)
        }
        
        updateLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(moveImage.snp.leading).offset(-8)
        }
        
        moveImage.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView).offset(-12)
            $0.width.equalTo(7)
            $0.height.equalTo(14)
        }
    }
    
    @objc private func updateButtonTapped() {
        onVersionUpdate?()
    }
}
