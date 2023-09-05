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
    private let profileNameLabel = UILabel()
    private let profileEmailLabel = UILabel()
    private let moveImage = UIImageView()
    
    override func setupProperty() {
        super.setupProperty()
        
        profileImage.layer.cornerRadius = 56 / 2
        profileImage.backgroundColor = .colorF5F3F0
        
        profileNameLabel.textColor = .color000000
        profileNameLabel.font = .title02
        
        profileEmailLabel.textColor = .color707070
        profileEmailLabel.font = .caption01
        
        moveImage.image = UIImage(named: "my_move")
        moveImage.tintColor = .color707070
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(profileImage)
        contentView.addSubview(profileNameLabel)
        contentView.addSubview(profileEmailLabel)
        contentView.addSubview(moveImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        profileImage.snp.makeConstraints {
            $0.leading.centerY.equalTo(contentView)
            $0.width.height.equalTo(56)
        }
        
        profileNameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImage.snp.trailing).offset(12)
            $0.top.equalTo(contentView).offset(14)
        }
        
        profileEmailLabel.snp.makeConstraints {
            $0.leading.equalTo(profileNameLabel)
            $0.top.equalTo(contentView).offset(38)
        }
        
        moveImage.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView).offset(-1)
            $0.width.equalTo(7)
            $0.height.equalTo(14)
        }
    }

    func configure(_ profile: ProfileResponse?) {
        guard let profile else { return }
        
        profileNameLabel.text = profile.nickname
        profileEmailLabel.text = profile.email
        
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
    }
}
