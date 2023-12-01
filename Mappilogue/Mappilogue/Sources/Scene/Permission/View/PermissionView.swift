//
//  PermissionView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/24.
//

import UIKit

class PermissionView: BaseView {
    private let permissionImage = UIImageView()
    private let permissionTitleLabel = UILabel()
    private let permissionSubTitleLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        permissionImage.contentMode = .scaleAspectFit
        
        permissionTitleLabel.textColor = .color000000
        permissionTitleLabel.font = .title02
        
        permissionSubTitleLabel.textColor = .gray9B9791
        permissionSubTitleLabel.font = .body02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(permissionImage)
        addSubview(permissionTitleLabel)
        addSubview(permissionSubTitleLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(49)
        }
        
        permissionImage.snp.makeConstraints {
            $0.leading.equalTo(self)
            $0.top.equalTo(self).offset(3)
        }
        
        permissionTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(permissionImage.snp.trailing).offset(16)
            $0.top.equalTo(self).offset(3)
        }
        
        permissionSubTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(permissionImage.snp.trailing).offset(16)
            $0.top.equalTo(permissionTitleLabel.snp.bottom).offset(7)
        }
    }
    
    func configure(imageName: String, size: CGSize, title: String, subTitle: String) {
        permissionImage.image = UIImage(named: imageName)
        permissionImage.snp.makeConstraints {
            $0.width.equalTo(size.width)
            $0.height.equalTo(size.height)
        }
        
        permissionTitleLabel.text = title
        permissionSubTitleLabel.text = subTitle
    }
}
