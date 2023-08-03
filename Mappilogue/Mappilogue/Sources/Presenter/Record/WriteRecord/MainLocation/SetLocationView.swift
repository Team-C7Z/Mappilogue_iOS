//
//  SetLocationView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/03.
//

import UIKit

class SetLocationView: BaseView {
    private let addressLabel = UILabel()
    private let setLocationButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()
        
        layer.cornerRadius = 24
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        layer.masksToBounds = true
        backgroundColor = .colorF9F8F7
        
        addressLabel.text = "제주특별자치도"
        addressLabel.textColor = .color000000
        addressLabel.font = .title02
        
        setLocationButton.layer.cornerRadius = 12
        setLocationButton.backgroundColor = .color43B54E
        setLocationButton.setTitle("이 위치로 설정하기", for: .normal)
        setLocationButton.setTitleColor(.colorFFFFFF, for: .normal)
        setLocationButton.titleLabel?.font = .body03
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(addressLabel)
        addSubview(setLocationButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        
        addressLabel.snp.makeConstraints {
            $0.top.equalTo(self).offset(24)
            $0.leading.equalTo(self).offset(16)
        }
        
        setLocationButton.snp.makeConstraints {
            $0.top.equalTo(self).offset(100)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
            $0.height.equalTo(53)
        }
    }
}
