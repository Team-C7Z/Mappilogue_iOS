//
//  SelectedNotificationCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/07.
//

import UIKit

class SelectedNotificationCell: BaseCollectionViewCell {
    static let registerId = "\(SelectedNotificationCell.self)"

    private let notificationLabel = UILabel()
    private let deletButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()
    
        contentView.backgroundColor = .colorF5F3F0
        contentView.layer.cornerRadius = 12
        deletButton.setImage(UIImage(named: "deleteNotification"), for: .normal)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(notificationLabel)
        contentView.addSubview(deletButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        notificationLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(20)
            $0.centerY.equalTo(contentView)
        }
        
        deletButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView).offset(-10)
            $0.width.height.equalTo(24)
        }
    }
    
    func configure(_ date: SelectedNotification) {
        notificationLabel.text = "\(date.date ?? "") \(date.hour ?? 0):\(String(format: "%02d", date.minute ?? 0)) \(date.timePeriod ?? "")"
    }
}
