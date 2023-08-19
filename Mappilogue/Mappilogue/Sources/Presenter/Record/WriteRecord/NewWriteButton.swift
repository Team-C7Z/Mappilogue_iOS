//
//  NewWriteButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class NewWriteButton: BaseButton {
    private let newWriteLabel = UILabel()
    private let moveImage = UIImageView()
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .colorF5F3F0
        layer.cornerRadius = 12
        
        newWriteLabel.text = "새로 쓰기"
        newWriteLabel.textColor = .color1C1C1C
        newWriteLabel.font = .body02
        
        moveImage.image = UIImage(named: "newWrite")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        addSubview(newWriteLabel)
        addSubview(moveImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        newWriteLabel.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.leading.equalTo(self).offset(12)
        }
        
        moveImage.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.trailing.equalTo(self).offset(-12)
            $0.width.equalTo(8)
            $0.height.equalTo(16)
        }
    }
}
