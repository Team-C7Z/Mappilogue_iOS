//
//  LogoNotificationBar.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

class LogoNotificationBar: UIView {
    private let logoImage = UIImageView()
    private let notificationButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {
        logoImage.image = Icons.icon(named: .logo)
        notificationButton.setImage(Icons.icon(named: .notificationDefault), for: .normal)
    }
    
    func setupHierarchy() {
        addSubview(logoImage)
        addSubview(notificationButton)
    }
    
    func setupLayout() {
        logoImage.snp.makeConstraints {
            $0.leading.equalTo(self).offset(16)
            $0.bottom.equalTo(self).offset(-9)
            $0.width.equalTo(146.29)
            $0.height.equalTo(32)
        }
        
        notificationButton.snp.makeConstraints {
            $0.trailing.equalTo(self).offset(16)
            $0.bottom.equalTo(self).offset(-7)
            $0.width.equalTo(26)
            $0.height.equalTo(29)
        }
    }
}
