//
//  EmptyNotificationCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/13.
//

import UIKit

class EmptyNotificationCell: BaseTableViewCell {
    static let registerId = "\(EmptyNotificationCell.self)"

    private let stackView = UIStackView()
    private let notificationImage = UIImageView()
    private let notificationLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
  
        notificationImage.image = UIImage(named: "notification_empty")
        
        notificationLabel.textColor = .color000000
        notificationLabel.font = .title02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        contentView.addSubview(stackView)
        stackView.addArrangedSubview(notificationImage)
        stackView.addArrangedSubview(notificationLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(224)
        }
        
        notificationImage.snp.makeConstraints {
            $0.width.height.equalTo(52)
        }
    }
    
    func configure(notificationType: NotificationType) {
        switch notificationType {
        case .notification:
            notificationLabel.text = "새로운 알림이 없어요"
        case .announcement:
            notificationLabel.text = "아직 공지사항이 없어요"
        }
    }
}
