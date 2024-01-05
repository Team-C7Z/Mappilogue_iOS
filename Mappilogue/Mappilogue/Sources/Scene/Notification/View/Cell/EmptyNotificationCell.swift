//
//  EmptyNotificationCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/13.
//

import UIKit
import MappilogueKit

class EmptyNotificationCell: BaseTableViewCell {
    static let registerId = "\(EmptyNotificationCell.self)"

    private let stackView = UIStackView()
    private let notificationImage = UIImageView()
    private let notificationTitleLabel = UILabel()
    private let notificationSubTitleLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 16
  
        notificationImage.image = Images.image(named: .imageNotificationEmpty)
        
        notificationTitleLabel.textColor = .color000000
        notificationTitleLabel.font = .title02
        
        notificationSubTitleLabel.textColor = .gray9B9791
        notificationSubTitleLabel.font = .body02
        notificationSubTitleLabel.textAlignment = .center
        notificationSubTitleLabel.numberOfLines = 0
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        contentView.addSubview(stackView)
        stackView.addArrangedSubview(notificationImage)
        stackView.addArrangedSubview(notificationTitleLabel)
        stackView.addArrangedSubview(notificationSubTitleLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.centerX.equalTo(contentView)
            $0.centerY.equalTo(contentView).offset(-88)
        }
        
        notificationImage.snp.makeConstraints {
            $0.width.height.equalTo(52)
        }
    }
    
    func configure(notificationType: NotificationType) {
        switch notificationType {
        case .notification:
            notificationTitleLabel.text = "새로운 알림이 없어요"
            notificationSubTitleLabel.setTextWithLineHeight(text: "모임 기능의 등장과 함께\n새로운 알림을 보내 드릴게요", lineHeight: 21)
        case .announcement:
            notificationTitleLabel.text = "아직 공지사항이 없어요"
            notificationSubTitleLabel.text = ""
        }
    }
}
