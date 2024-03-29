//
//  NotificationHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/07.
//

import UIKit

class NotificationHeaderView: BaseCollectionReusableView {
    static let registerId = "\(NotificationHeaderView.self)"
    
    var onStartDateButtonTapped: (() -> Void)?
    var onStartTimeButtonTapped: (() -> Void)?
    var onAddNotificationButtonTapped: (() -> Void)?
    
    private let startLabel = UILabel()
    private let stackView = UIStackView()
    private let startDateButton = UIButton()
    private let startDateLabel = UILabel()
    private let startTimeButton = UIButton()
    private let startTimeLabel = UILabel()
    private let addNotificationButton = UIButton()
    private let addNotificationImage = UIImageView()
    private let notificationListLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        startLabel.text = "시작일 기준"
        startLabel.textColor = .gray707070
        startLabel.font = .body02
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        stackView.backgroundColor = .grayEAE6E1
        
        startDateButton.backgroundColor = .grayF9F8F7
        startDateLabel.textColor = .black1C1C1C
        startDateLabel.font = .title02
        startDateButton.addTarget(self, action: #selector(startDateButtonTapped), for: .touchUpInside)
        
        startTimeButton.backgroundColor = .grayF9F8F7
        startTimeLabel.textColor = .black1C1C1C
        startTimeLabel.font = .title02
        startTimeButton.addTarget(self, action: #selector(startTimeButtonTapped), for: .touchUpInside)
        
        addNotificationButton.layer.cornerRadius = 12
        addNotificationButton.backgroundColor = .grayEAE6E1
        addNotificationImage.image = UIImage(named: "addNotification")
        addNotificationButton.addTarget(self, action: #selector(addNotificationButtonTapped), for: .touchUpInside)
        
        notificationListLabel.text = "알림 리스트"
        notificationListLabel.textColor = .gray707070
        notificationListLabel.font = .body02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(startLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(startDateButton)
        startDateButton.addSubview(startDateLabel)
        stackView.addArrangedSubview(startTimeButton)
        startTimeButton.addSubview(startTimeLabel)
        startTimeButton.addSubview(addNotificationButton)
        addNotificationButton.addSubview(addNotificationImage)
        addSubview(notificationListLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
     
        startLabel.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.leading.equalTo(self).offset(16)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(self).offset(31)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
            $0.height.equalTo(52)
        }
        
        startDateLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(startDateButton)
        }
        
        startTimeLabel.snp.makeConstraints {
            $0.centerY.equalTo(startTimeButton)
            $0.centerX.equalTo(startTimeButton).offset(-37/2)
        }
        
        addNotificationButton.snp.makeConstraints {
            $0.trailing.centerY.equalTo(startTimeButton)
            $0.width.height.equalTo(32)
        }
        
        addNotificationImage.snp.makeConstraints {
            $0.centerX.centerY.equalTo(addNotificationButton)
            $0.width.height.equalTo(16)
        }
        
        notificationListLabel.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom).offset(36)
            $0.leading.equalTo(self).offset(16)
        }
    }
    
    func configure(_ selectedNotification: SelectedNotification) {
        startDateLabel.text = selectedNotification.date
        guard let hour = selectedNotification.hour, let minute = selectedNotification.minute, let timePeriod = selectedNotification.timePeriod else { return }
        startTimeLabel.text = "\(hour):\(String(format: "%02d", minute)) \(timePeriod)"
    }
    
    @objc private func startDateButtonTapped() {
        onStartDateButtonTapped?()
    }
    
    @objc private func startTimeButtonTapped() {
        onStartTimeButtonTapped?()
    }
    
    @objc private func addNotificationButtonTapped() {
        onAddNotificationButtonTapped?()
    }
}
