//
//  NotificationController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/12.
//

import UIKit

class NotificationController: BaseViewController {
    var notificationData: [NotificationData] = dummyNotificaitonData()
    let announcementData: [AnnouncementData] = dummyAnnouncementData()
    
    var notificationType: NotificationType = .notification
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .colorF9F8F7
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.register(EmptyNotificationCell.self, forCellReuseIdentifier: EmptyNotificationCell.registerId)
        tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.registerId)
        tableView.register(AnnouncementCell.self, forCellReuseIdentifier: AnnouncementCell.registerId)
        tableView.register(NotificationAnnouncementHeaderView.self, forHeaderFooterViewReuseIdentifier: NotificationAnnouncementHeaderView.registerId)
        tableView.register(LineHeaderView.self, forHeaderFooterViewReuseIdentifier: LineHeaderView.registerId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func setupProperty() {
        super.setupProperty()
        
        setNavigationTitleAndBackButton("알림", backButtonAction: #selector(backButtonTapped))
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
      
        view.addSubview(tableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
     
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func removeNotification(_ index: Int) {
        notificationData.remove(at: index)
        
        tableView.reloadData()
    }
}

extension NotificationController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch notificationType {
        case .notification:
            return notificationData.isEmpty ? 1 : notificationData.count
        case .announcement:
            return announcementData.isEmpty ? 1 : announcementData.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch notificationType {
        case .notification:
            if notificationData.isEmpty {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyNotificationCell.registerId, for: indexPath) as? EmptyNotificationCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.configure(notificationType: .notification)
                
                return cell
             } else {
                 guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.registerId, for: indexPath) as? NotificationCell else { return UITableViewCell() }
                 cell.selectionStyle = .none
                 
                 let notification = notificationData[indexPath.section]
                 cell.configure(notification, index: indexPath.section)
                 
                 cell.onRemove = { index in
                     self.removeNotification(index)
                 }
                 
                 return cell
             }
        case .announcement:
            if announcementData.isEmpty {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyNotificationCell.registerId, for: indexPath) as? EmptyNotificationCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.configure(notificationType: .announcement)
            
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AnnouncementCell.registerId, for: indexPath) as? AnnouncementCell else { return UITableViewCell() }
                cell.selectionStyle = .none
            
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch notificationType {
        case .notification:
            return notificationData.isEmpty ? tableView.frame.height - 100 : 83
        case .announcement:
            return announcementData.isEmpty ? tableView.frame.height - 100 : 75
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NotificationAnnouncementHeaderView.registerId) as? NotificationAnnouncementHeaderView else { return UIView() }
            headerView.delegate = self
            return headerView
        } else {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: LineHeaderView.registerId) as? LineHeaderView else { return UIView() }
            return headerView
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 66 : 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
}

extension NotificationController: NotificationTypeDelegate {
    func categoryButtonTapped(_ notificationType: NotificationType) {
        self.notificationType = notificationType

        tableView.reloadData()
    }
}
