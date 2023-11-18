//
//  NotificationSettingView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class NotificationSettingView: BaseView {
    var onSwitchTapped: (() -> Void)?
    
    private let notificationLabel = UILabel()
    private let notificationSwitch = NotificationSwitchButton()
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .colorF9F8F7
        notificationLabel.textColor = .color1C1C1C
        notificationLabel.font = .body02
        
        notificationSwitch.onSwitchTapped = {
            self.onSwitchTapped?()
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(notificationLabel)
        addSubview(notificationSwitch)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        notificationLabel.snp.makeConstraints {
            $0.top.equalTo(self).offset(14)
            $0.leading.equalTo(self)
        }
        
        notificationSwitch.snp.makeConstraints {
            $0.top.equalTo(self).offset(8)
            $0.trailing.equalTo(self)
        }
    }
    
    func configure(title: String, isSwitch: String) {
        guard let isSwitch = ActiveStatus(rawValue: isSwitch) else { return }
        
        notificationLabel.text = title
        notificationSwitch.configure(isSwitch == .active)
    }
}
