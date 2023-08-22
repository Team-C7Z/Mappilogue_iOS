//
//  VersionCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class VersionCell: BaseCollectionViewCell {
    static let registerId = "\(VersionCell.self)"
    
    private let versionInfoLabel = UILabel()
    private let versionLabel = UILabel()
    private let updateLabel = UILabel()
    private let moveImage = UIImageView()
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .colorF5F3F0
        
        versionInfoLabel.text = "버전정보"
        versionInfoLabel.textColor = .color000000
        versionInfoLabel.font = .body02
        
        versionLabel.text = "0.0.1 / 0.0.1"
        versionLabel.textColor = .color707070
        versionLabel.font = .body02
        
        updateLabel.text = "업데이트"
        updateLabel.textColor = .colorC9C6C2
        updateLabel.font = .body02
        
        moveImage.image = UIImage(named: "my_move")
        moveImage.tintColor = .colorC9C6C2
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(versionInfoLabel)
        contentView.addSubview(versionLabel)
        contentView.addSubview(updateLabel)
        contentView.addSubview(moveImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        versionInfoLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(12)
        }
        
        versionLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(versionInfoLabel.snp.trailing).offset(8)
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
    
    func configure() {
    }
}
