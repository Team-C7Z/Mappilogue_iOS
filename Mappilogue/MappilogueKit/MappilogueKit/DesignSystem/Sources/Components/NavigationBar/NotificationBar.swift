//
//  NotificationBar.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

class NotificationBar: UIView {
    private let titleLabel = UILabel()
    private let notificationButton = UIButton()
    
    init(title: String) {
        super.init(frame: CGRect.zero)
        
        setupProperty(title)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty(_ title: String) {
        titleLabel.text = title
        notificationButton.setImage(Icons.icon(named: .notificationDefault), for: .normal)
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(notificationButton)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.bottom.equalTo(self).offset(-10)
        }
        
        notificationButton.snp.makeConstraints {
            $0.trailing.equalTo(self).offset(-16)
            $0.bottom.equalTo(self).offset(-7)
            $0.width.equalTo(26)
            $0.height.equalTo(29)
        }
    }
}
