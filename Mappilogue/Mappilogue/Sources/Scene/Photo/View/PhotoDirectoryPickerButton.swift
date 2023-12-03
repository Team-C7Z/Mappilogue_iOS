//
//  PhotoDirectoryPickerButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/19.
//

import UIKit

class PhotoDirectoryPickerButton: BaseButton {
    private let photoDirectoryTitleLabel = UILabel()
    private let changePhotoDirectoryImage = UIImageView()
    
    override func setupProperty() {
        super.setupProperty()
        
        photoDirectoryTitleLabel.text = "최근 항목"
        photoDirectoryTitleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        changePhotoDirectoryImage.image = UIImage(named: "record_hidePhotoDirectory")
        changePhotoDirectoryImage.contentMode = .scaleAspectFit
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(photoDirectoryTitleLabel)
        addSubview(changePhotoDirectoryImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.width.equalTo(96)
            $0.height.equalTo(32)
        }
        
        photoDirectoryTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.leading.equalTo(self).offset(7)
        }
        
        changePhotoDirectoryImage.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.trailing.equalTo(self).offset(-7)
            $0.width.equalTo(14)
            $0.height.equalTo(7)
        }
    }
    
    func configure(_ isPhotoDirectory: Bool) {
        changePhotoDirectoryImage.image = UIImage(named: isPhotoDirectory ? "record_showPhotoDirectory" : "record_hidePhotoDirectory")
    }
}
