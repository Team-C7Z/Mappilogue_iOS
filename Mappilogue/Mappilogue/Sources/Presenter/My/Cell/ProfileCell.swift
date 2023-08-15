//
//  ProfileCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class ProfileCell: BaseCollectionViewCell {
    static let registerId = "\(ProfileCell.self)"
    
    private let profileImage = UIImageView()
    private let profileName = UILabel()
    private let profileEmail = UILabel()
    private let moveImage = UIImageView()
    
    override func setupProperty() {
        super.setupProperty()
        
        profileImage.layer.cornerRadius = 56 / 2
        profileImage.backgroundColor = .colorF5F3F0
        profileImage.image = UIImage(named: "my_profile")
        
        profileName.text = "맵필로그 님"
        profileName.textColor = .color000000
        profileName.font = .title02
        
        profileEmail.text = "mappilogue@kakao.com"
        profileEmail.textColor = .color707070
        profileEmail.font = .caption01
        
        moveImage.image = UIImage(named: "my_move")
        moveImage.tintColor = .color707070
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(profileImage)
        contentView.addSubview(profileName)
        contentView.addSubview(profileEmail)
        contentView.addSubview(moveImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        profileImage.snp.makeConstraints {
            $0.leading.centerY.equalTo(contentView)
            $0.width.height.equalTo(56)
        }
        
        profileName.snp.makeConstraints {
            $0.leading.equalTo(profileImage.snp.trailing).offset(12)
            $0.top.equalTo(contentView).offset(14)
        }
        
        profileEmail.snp.makeConstraints {
            $0.leading.equalTo(profileName)
            $0.top.equalTo(contentView).offset(38)
        }
        
        moveImage.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView).offset(-1)
            $0.width.equalTo(7)
            $0.height.equalTo(14)
        }
    }
    
    func configure() {
    }
}
