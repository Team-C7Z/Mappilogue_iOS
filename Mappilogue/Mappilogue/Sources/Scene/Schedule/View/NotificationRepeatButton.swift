//
//  NotificationRepeatButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class NotificationRepeatButton: BaseButton {
    private let image = UIImageView()
    private let label = UILabel()
    private let moveImage = UIImageView()
    
    override func setupProperty() {
        super.setupProperty()

        backgroundColor = .grayF9F8F7
        
        label.textColor = .gray707070
        label.font = .body02
        
        moveImage.image = UIImage(named: "move")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
    
        addSubview(image)
        addSubview(label)
        addSubview(moveImage)
    }
    
    override func setupLayout() {
        super.setupLayout()

        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        image.snp.makeConstraints {
            $0.leading.equalTo(self).offset(0.5)
            $0.centerY.equalTo(self)
            $0.width.height.equalTo(16)
        }
        
        label.snp.makeConstraints {
            $0.leading.equalTo(image.snp.trailing).offset(8)
            $0.centerY.equalTo(self)
        }
        
        moveImage.snp.makeConstraints {
            $0.trailing.centerY.equalTo(self)
        }
    }
    
    func configure(imageName: UIImage, title: String) {
        image.image = imageName
        label.text = title
    }
}
