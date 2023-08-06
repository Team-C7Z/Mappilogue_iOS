//
//  EmailCopyToastMessageView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class EmailCopyToastMessageView: BaseView {
    private let toastMessageImage = UIImageView()
    private let toastMessageLabel = UILabel()

    override func setupProperty() {
        super.setupProperty()
        
        layer.cornerRadius = 12
        backgroundColor = .color404040
        toastMessageImage.image = UIImage(named: "emailCopy")
        toastMessageLabel.text = "이메일이 복사되었어요"
        toastMessageLabel.textColor = .colorFFFFFF
        toastMessageLabel.font = .body02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(toastMessageImage)
        addSubview(toastMessageLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.width.equalTo(343)
            $0.height.equalTo(48)
        }
        
        toastMessageImage.snp.makeConstraints {
            $0.leading.equalTo(20)
            $0.centerY.equalTo(self)
            $0.width.height.equalTo(16)
        }
        
        toastMessageLabel.snp.makeConstraints {
            $0.leading.equalTo(toastMessageImage.snp.trailing).offset(6)
            $0.centerY.equalTo(self)
        }
    }
}
