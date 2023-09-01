//
//  NotificationSettingViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class NotificationSettingViewController: BaseViewController {
    var isNotificationControl: Bool = false
    var isNoti: Bool = false
    var isEvent: Bool = false
    var isMarketing: Bool = false
    
    private let notificationControlView = NotificationSettingView()
    private var stackView = UIStackView()
    private let noticeNotificationView = NotificationSettingView()
    private let eventReminderView = NotificationSettingView()
    private let marketingAlertView = NotificationSettingView()
    private let notificationControlOffView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationTitleAndBackButton("My", backButtonAction: #selector(backButtonTapped))
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 1
        stackView.backgroundColor = .colorEAE6E1
        
        notificationControlView.configure(title: "알림 받기", isSwitch: isNotificationControl)
        noticeNotificationView.configure(title: "공지사항 알림", isSwitch: isNoti)
        eventReminderView.configure(title: "일정 미리 알림", isSwitch: isEvent)
        marketingAlertView.configure(title: "마케팅 알림", isSwitch: isMarketing)
        
        notificationControlView.onSwitchTapped = {
            self.isNotificationControl.toggle()
            self.setNotificationControl()
        }
        
        noticeNotificationView.onSwitchTapped = {
            self.isNoti.toggle()
        }
        
        eventReminderView.onSwitchTapped = {
            self.isEvent.toggle()
        }
        
        marketingAlertView.onSwitchTapped = {
            self.isMarketing.toggle()
        }
        
        notificationControlOffView.backgroundColor = .colorF9F8F7.withAlphaComponent(0.4)
        setNotificationControl()
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
    
    func setNotificationControl() {
        notificationControlOffView.isHidden = isNotificationControl
    }
}
