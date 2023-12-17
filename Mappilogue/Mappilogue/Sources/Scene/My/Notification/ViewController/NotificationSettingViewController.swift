//
//  NotificationSettingViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class NotificationSettingViewController: NavigationBarViewController {
    weak var coordinator: NotificationSettingCoordinator?
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
        
        popBar.onPopButtonTapped = {
            self.updateNotification()
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
        
        coordinator?.popViewController()
    }
    
    func getNotificationSetting() {
        viewModel.getNotificationSetting()
        
        viewModel.$notificationResult
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { result in
                guard let result else { return }
                
                self.handleNotificationSettingResponse(result)
            })
            .store(in: &viewModel.cancellables)
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
        totalNotiviationView.onSwitchTapped = {
            guard let notification = self.notificationDTO else { return }
            
            self.notificationDTO?.isTotalNotification = self.viewModel.switchToggle(notification.isTotalNotification)
            self.configureNotification()
            self.setTotalNotificationControl()
        }
        
        noticeNotification.onSwitchTapped = {
            guard let notification = self.notificationDTO else { return }
            
            self.notificationDTO?.isNoticeNotification = self.viewModel.switchToggle(notification.isNoticeNotification)
            self.configureNotification()
        }
        
        scheduleReminderNotification.onSwitchTapped = {
            guard let notification = self.notificationDTO else { return }
            
            self.notificationDTO?.isScheduleReminderNotification = self.viewModel.switchToggle(notification.isScheduleReminderNotification)
            self.configureNotification()
        }
        
        marketingAlertView.onSwitchTapped = {
            guard let notification = self.notificationDTO else { return }
            
            self.notificationDTO?.isMarketingNotification = self.viewModel.switchToggle(notification.isMarketingNotification)
            self.configureNotification()
        }
    }
    
    func setTotalNotificationControl() {
        guard let notification = notificationDTO, let isTotalNotification = ActiveStatus(rawValue: notification.isTotalNotification) else { return }
        
        notificationControlOffView.isHidden = isTotalNotification == .active
    }
}
