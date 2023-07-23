//
//  GatheringToastMessageView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/23.
//

import UIKit

class GatheringToastMessageView: BaseView {
    private let toastMessageView = UIView()
    private let toastMessageImage = UIImageView()
    private let toastMessageLabel = UILabel()
    private let toastMessageArrow = UIImageView()

    override func setupProperty() {
        super.setupProperty()
        
        toastMessageView.layer.cornerRadius = 12
        toastMessageView.backgroundColor = .color404040
        toastMessageImage.image = UIImage(named: "toastMessage")
        toastMessageLabel.text = "모임 기능은 나중에 만나요!"
        toastMessageLabel.textColor = .colorFFFFFF
        toastMessageLabel.font = .body02
        toastMessageArrow.image = UIImage(named: "toastMessageArrow")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(toastMessageView)
        toastMessageView.addSubview(toastMessageImage)
        toastMessageView.addSubview(toastMessageLabel)
        addSubview(toastMessageArrow)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        toastMessageView.snp.makeConstraints {
            $0.bottom.equalTo(toastMessageArrow.snp.top).offset(4)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(206)
            $0.height.equalTo(37)
        }
        
        toastMessageImage.snp.makeConstraints {
            $0.leading.equalTo(18)
            $0.centerY.equalTo(toastMessageView)
            $0.width.height.equalTo(16)
        }
        
        toastMessageLabel.snp.makeConstraints {
            $0.leading.equalTo(toastMessageImage.snp.trailing).offset(6)
            $0.centerY.equalTo(toastMessageView)
        }
        
        toastMessageArrow.snp.makeConstraints {
            $0.centerX.bottom.equalToSuperview()
            $0.width.equalTo(19)
            $0.height.equalTo(14)
        }
    }
}
