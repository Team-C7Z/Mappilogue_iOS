//
//  NotificationSwitchButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class NotificationSwitchButton: BaseButton {
    var onSwitchTapped: (() -> Void)?
    
    private let thumbView = UIView()
    
    override func setupProperty() {
        super.setupProperty()
        
        layer.cornerRadius = 16
        backgroundColor = .colorEAE6E1
  
        thumbView.layer.cornerRadius = 12
        thumbView.layer.applyShadow()
        thumbView.backgroundColor = .color9B9791
        thumbView.isUserInteractionEnabled = false
        
        addTarget(self, action: #selector(updateSwitchDesign), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
 
        addSubview(thumbView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.height.equalTo(32)
        }
        
        thumbView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.leading.equalTo(self).offset(4)
            $0.centerY.equalTo(self)
        }
    }
    
    @objc func updateSwitchDesign() {
        isSelected.toggle()
        configure(isSelected)
        onSwitchTapped?()
    }
    
    func configure(_ isSelected: Bool) {
        backgroundColor = isSelected ? .color2EBD3D : .colorEAE6E1
        thumbView.backgroundColor = isSelected ? .colorFFFFFF : .color9B9791
        
        thumbView.snp.updateConstraints {
            $0.leading.equalTo(self).offset(isSelected ? 36 : 4)
        }
    
        self.layoutIfNeeded()
    }
}
