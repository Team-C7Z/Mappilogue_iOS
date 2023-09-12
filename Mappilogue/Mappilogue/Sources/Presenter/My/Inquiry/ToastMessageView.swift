//
//  ToastMessageView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class ToastMessageView: BaseView {
    private let toastMessageImage = UIImageView()
    private let toastMessageLabel = UILabel()
    private let undoButton = UIButton()

    override func setupProperty() {
        super.setupProperty()
        
        layer.cornerRadius = 12
        backgroundColor = .color404040
        
        toastMessageImage.image = UIImage(named: "common_toastMessage")
        
        toastMessageLabel.textColor = .colorFFFFFF
        toastMessageLabel.font = .body02
        
        undoButton.setTitle("되돌리기", for: .normal)
        undoButton.setTitleColor(.color43B54E, for: .normal)
        undoButton.titleLabel?.font = .body03
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(toastMessageImage)
        addSubview(toastMessageLabel)
        addSubview(undoButton)
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
        
        undoButton.snp.makeConstraints {
            $0.trailing.equalTo(self).offset(-10)
            $0.centerY.equalTo(self)
            $0.width.equalTo(69)
            $0.height.equalTo(41)
        }
    }
    
    func configure(_ title: String, showUndo: Bool) {
        toastMessageLabel.text = title
        undoButton.isHidden = !showUndo
    }
}
