//
//  NotificationSettingViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class NotificationSettingViewController: BaseViewController {
    private var notificationDTO: NotificationDTO?
    
    private let notificationControlView = NotificationSettingView()
    private var stackView = UIStackView()
    private let noticeNotificationView = NotificationSettingView()
    private let eventReminderView = NotificationSettingView()
    private let marketingAlertView = NotificationSettingView()
    private let notificationControlOffView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getNotificationSetting()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationTitleAndBackButton("My", backButtonAction: #selector(backButtonTapped))
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 1
        stackView.backgroundColor = .colorEAE6E1

        notificationControlView.onSwitchTapped = {
            //self..toggle()
           // self.setNotificationControl()
        }
        
        noticeNotificationView.onSwitchTapped = {
          //  self.isNoti.toggle()
        }
        
        eventReminderView.onSwitchTapped = {
          //  self.isEvent.toggle()
        }
        
        marketingAlertView.onSwitchTapped = {
            //self.isMarketing.toggle()
        }
        
        notificationControlOffView.backgroundColor = .colorF9F8F7.withAlphaComponent(0.4)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(notificationControlView)
        view.addSubview(stackView)
        stackView.addArrangedSubview(noticeNotificationView)
        stackView.addArrangedSubview(eventReminderView)
        stackView.addArrangedSubview(marketingAlertView)
        stackView.addSubview(notificationControlOffView)
    }
    
    override func setupLayout() {
        super.setupLayout()
    
        notificationControlView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(notificationControlView.snp.bottom).offset(16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        notificationControlOffView.snp.makeConstraints {
            $0.width.height.equalTo(stackView)
        }
    }
    
    func getNotificationSetting() {
        UserManager.shared.getNotificationSetting { result in
            switch result {
            case .success(let response):
                self.handleNotificationSettingResponse(response)
            default:
                break
            }
        }
    }
    
    private func handleNotificationSettingResponse(_ response: Any) {
        guard let baseResponse = response as? BaseResponse<NotificationDTO>, let result = baseResponse.result else { return }
        
        notificationDTO = result
        configureNotification()
        setTotalNotificationControl()
    }
    
    func configureNotification() {
        guard let notification = notificationDTO else { return }
        
        notificationControlView.configure(title: "알림 받기", isSwitch: notification.isTotalAlarm)
        noticeNotificationView.configure(title: "공지사항 알림", isSwitch: notification.isNoticeAlarm)
        eventReminderView.configure(title: "일정 미리 알림", isSwitch: notification.isMarketingAlarm)
        marketingAlertView.configure(title: "마케팅 알림", isSwitch: notification.isScheduleReminderAlarm)
    }
    
    func setTotalNotificationControl() {
        guard let notification = notificationDTO, let isTotalAlarm = NotificationType(rawValue: notification.isTotalAlarm) else { return }
        
        notificationControlOffView.isHidden = isTotalAlarm == .active
    }
}
