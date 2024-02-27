//
//  NotificationSettingViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class NotificationSettingViewController: NavigationBarViewController {
    var viewModel = NotificationSettingViewModel()
    private var notificationDTO: NotificationDTO?
    
    private let totalNotiviationView = NotificationSettingView()
    private var stackView = UIStackView()
    private let noticeNotification = NotificationSettingView()
    private let scheduleReminderNotification = NotificationSettingView()
    private let marketingAlertView = NotificationSettingView()
    private let notificationControlOffView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getNotificationSetting()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setPopBar(title: "알림 설정")
        
        popBar.onPopButtonTapped = { [weak self] in
            guard let self = self else { return }
            
            updateNotification()
        }
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 1
        stackView.backgroundColor = .grayEAE6E1

        setSwitchToggleActions()
        
        notificationControlOffView.backgroundColor = .grayF9F8F7.withAlphaComponent(0.4)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(totalNotiviationView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(noticeNotification)
        stackView.addArrangedSubview(scheduleReminderNotification)
        stackView.addArrangedSubview(marketingAlertView)
        stackView.addSubview(notificationControlOffView)
    }
    
    override func setupLayout() {
        super.setupLayout()
    
        totalNotiviationView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(98)
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(totalNotiviationView.snp.bottom).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        notificationControlOffView.snp.makeConstraints {
            $0.width.height.equalTo(stackView)
        }
    }
    
    @objc private func updateNotification() {
        if let notification = notificationDTO {
            viewModel.updateNotificationSetting(notification: notification)
        }
        
        navigationController?.popViewController(animated: true)
    }
    
    func getNotificationSetting() {
        viewModel.getNotificationSetting()
        
    }
    
    private func handleNotificationSettingResponse(_ result: NotificationDTO) {
        notificationDTO = result
        configureNotification()
        setTotalNotificationControl()
    }
    
    func configureNotification() {
        guard let notification = notificationDTO else { return }
 
        totalNotiviationView.configure(title: "알림 받기", isSwitch: notification.isTotalNotification)
        noticeNotification.configure(title: "공지사항 알림", isSwitch: notification.isNoticeNotification)
        scheduleReminderNotification.configure(title: "일정 미리 알림", isSwitch: notification.isScheduleReminderNotification)
        marketingAlertView.configure(title: "마케팅 알림", isSwitch: notification.isMarketingNotification)
    }
    
    func setSwitchToggleActions() {
        totalNotiviationView.onSwitchTapped = { [weak self] in
            guard let self = self else { return }
            guard let notification = notificationDTO else { return }
            
            notificationDTO?.isTotalNotification = viewModel.switchToggle(notification.isTotalNotification)
            configureNotification()
            setTotalNotificationControl()
        }
        
        noticeNotification.onSwitchTapped = { [weak self] in
            guard let self = self else { return }
            guard let notification = notificationDTO else { return }
            
            notificationDTO?.isNoticeNotification = viewModel.switchToggle(notification.isNoticeNotification)
            configureNotification()
        }
        
        scheduleReminderNotification.onSwitchTapped = { [weak self] in
            guard let self = self else { return }
            guard let notification = notificationDTO else { return }
            
            notificationDTO?.isScheduleReminderNotification = viewModel.switchToggle(notification.isScheduleReminderNotification)
            configureNotification()
        }
        
        marketingAlertView.onSwitchTapped = { [weak self] in
            guard let self = self else { return }
            guard let notification = notificationDTO else { return }
            
            notificationDTO?.isMarketingNotification = viewModel.switchToggle(notification.isMarketingNotification)
            configureNotification()
        }
    }
    
    func setTotalNotificationControl() {
        guard let notification = notificationDTO, let isTotalNotification = ActiveStatus(rawValue: notification.isTotalNotification) else { return }
        
        notificationControlOffView.isHidden = isTotalNotification == .active
    }
}
