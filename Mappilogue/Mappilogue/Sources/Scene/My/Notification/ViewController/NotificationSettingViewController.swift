//
//  NotificationSettingViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class NotificationSettingViewController: NavigationBarViewController {
    var viewModel = NotificationSettingViewModel()
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

    func getNotificationSetting() {
        viewModel.delegate = self
        viewModel.getNotificationSetting()
    }
    
    func configureNotification() {
        let notification = viewModel.notification
        
        totalNotiviationView.configure(title: "알림 받기", isSwitch: notification.isTotalNotification)
        noticeNotification.configure(title: "공지사항 알림", isSwitch: notification.isNoticeNotification)
        scheduleReminderNotification.configure(title: "일정 미리 알림", isSwitch: notification.isScheduleReminderNotification)
        marketingAlertView.configure(title: "마케팅 알림", isSwitch: notification.isMarketingNotification)
    }
    
    func setSwitchToggleActions() {
        totalNotiviationView.onSwitchTapped = { [weak self] in
            guard let self = self else { return }
    
            viewModel.notification.isTotalNotification = viewModel.switchToggle(viewModel.notification.isTotalNotification)
            configureNotification()
            setTotalNotificationControl()
            viewModel.updateNotificationSetting(notification: viewModel.notification)
        }
        
        noticeNotification.onSwitchTapped = { [weak self] in
            guard let self = self else { return }
            viewModel.notification.isNoticeNotification = viewModel.switchToggle(viewModel.notification.isNoticeNotification)
            configureNotification()
            viewModel.updateNotificationSetting(notification: viewModel.notification)
        }
        
        scheduleReminderNotification.onSwitchTapped = { [weak self] in
            guard let self = self else { return }
            viewModel.notification.isScheduleReminderNotification = viewModel.switchToggle(viewModel.notification.isScheduleReminderNotification)
            configureNotification()
            viewModel.updateNotificationSetting(notification: viewModel.notification)
        }
        
        marketingAlertView.onSwitchTapped = { [weak self] in
            guard let self = self else { return }
            
            viewModel.notification.isMarketingNotification = viewModel.switchToggle(viewModel.notification.isMarketingNotification)
            configureNotification()
            viewModel.updateNotificationSetting(notification: viewModel.notification)
        }
    }
    
    func setTotalNotificationControl() {
        let active = ActiveStatus.active.rawValue
        notificationControlOffView.isHidden = viewModel.notification.isTotalNotification == active
    }
}

extension NotificationSettingViewController: NotificationSettingDelegate {
    func getNotification() {
        configureNotification()
        setTotalNotificationControl()
    }
}
