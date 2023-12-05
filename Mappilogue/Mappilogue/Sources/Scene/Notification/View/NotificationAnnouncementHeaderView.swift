//
//  NotificationAnnouncementHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/13.
//

import UIKit

class NotificationAnnouncementHeaderView: BaseTableViewHeaderFooterView {
    static let registerId = "\(NotificationAnnouncementHeaderView.self)"
    
    weak var delegate: NotificationTypeDelegate?
    
    var notificationType: NotificationType = .notification
    
    private let stackView = UIStackView()
    private let notificationButton = UIButton()
    private let notificationLineView = UIView()
    private let announcementButton = UIButton()
    private let announcementLineView = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        notificationButton.addTarget(self, action: #selector(scheduleButtonTapped), for: .touchUpInside)
        announcementButton.addTarget(self, action: #selector(scheduleButtonTapped), for: .touchUpInside)
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 12
        
        notificationButton.setTitle("알림", for: .normal)
        notificationButton.titleLabel?.font = .title02
        notificationButton.setTitleColor(.grayEAE6E1, for: .normal)
        
        notificationLineView.backgroundColor = .grayC9C6C2
        
        announcementButton.setTitle("공지사항", for: .normal)
        announcementButton.titleLabel?.font = .title02
        announcementButton.setTitleColor(.grayC9C6C2, for: .normal)
        
        announcementLineView.backgroundColor = .grayC9C6C2
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(stackView)
        [notificationButton, announcementButton].forEach {
            stackView.addArrangedSubview($0)
        }
        notificationButton.addSubview(notificationLineView)
        announcementButton.addSubview(announcementLineView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.top.leading.equalTo(contentView)
            $0.height.equalTo(48)
        }
        
        notificationLineView.snp.makeConstraints {
            $0.bottom.equalTo(stackView)
            $0.leading.trailing.equalTo(notificationButton)
            $0.height.equalTo(2)
        }
        
        announcementLineView.snp.makeConstraints {
            $0.bottom.equalTo(stackView)
            $0.leading.trailing.equalTo(announcementButton)
            $0.height.equalTo(2)
        }
    }
    
    func configure(_ notificationType: NotificationType) {
        self.notificationType = notificationType
        
        updateButtonTitleColor()
    }
    
    @objc private func scheduleButtonTapped(_ sender: UIButton) {
        switch sender {
        case notificationButton:
            notificationType = .notification
        case announcementButton:
            notificationType = .announcement
        default:
            break
        }
        
        delegate?.categoryButtonTapped(notificationType)
    }
    
    private func updateButtonTitleColor() {
        notificationButton.setTitleColor(notificationType == .notification ? .black1C1C1C : .grayC9C6C2, for: .normal)
        notificationLineView.backgroundColor = notificationType == .notification ? .black1C1C1C : .grayC9C6C2
        announcementButton.setTitleColor(notificationType == .announcement ? .black1C1C1C : .grayC9C6C2, for: .normal)
        announcementLineView.backgroundColor = notificationType == .announcement ? .black1C1C1C : .grayC9C6C2
    }
}

protocol NotificationTypeDelegate: AnyObject {
    func categoryButtonTapped(_ notificationType: NotificationType)
}
