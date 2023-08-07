//
//  NotificationSettingCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class NotificationSettingCell: BaseCollectionViewCell {
    static let registerId = "\(NotificationSettingCell.self)"
    
    private let notificationLabel = UILabel()
    private let notificationSwitch = NotificationSwitchButton()
    private let lineView = UIView()
    
    override func setupProperty() {
        super.setupProperty()
        
        notificationLabel.textColor = .color1C1C1C
        notificationLabel.font = .body02
        
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(notificationLabel)
        contentView.addSubview(notificationSwitch)
        contentView.addSubview(lineView)
        
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        notificationLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(14)
            $0.leading.equalTo(contentView)
        }
        
        notificationSwitch.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(8)
            $0.trailing.equalTo(contentView)
        }
      
        lineView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(contentView)
            $0.height.equalTo(1)
        }
    }
    
    func configure(title: String, isSwitch: Bool, isLast: Bool) {
        notificationLabel.text = title
        lineView.backgroundColor = isLast ? .clear : .colorEAE6E1
    }
}
