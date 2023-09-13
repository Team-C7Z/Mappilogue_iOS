//
//  NotificationController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/12.
//

import UIKit

class NotificationController: BaseViewController {
    let notificationData: [NotificationData] = []
    let announcementData: [AnnouncementData] = []
    
    var notificationType: NotificationType = .notification
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .colorF9F8F7
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.register(EmptyNotificationCell.self, forCellReuseIdentifier: EmptyNotificationCell.registerId)
        tableView.register(NotificationAnnouncementHeaderView.self, forHeaderFooterViewReuseIdentifier: NotificationAnnouncementHeaderView.registerId)
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
}

extension NotificationController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch notificationType {
        case .notification:
            return notificationData.isEmpty ? 1 : notificationData.count
        case .announcement:
            return announcementData.isEmpty ? 1 : announcementData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch notificationType {
        case .notification:
            // if notificationData.isEmpty {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyNotificationCell.registerId, for: indexPath) as? EmptyNotificationCell else { return UITableViewCell() }
                cell.configure(notificationType: .notification)
                cell.selectionStyle = .none
            //}
            return cell
        case .announcement:
           // if announcementData.isEmpty {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyNotificationCell.registerId, for: indexPath) as? EmptyNotificationCell else { return UITableViewCell() }
                cell.configure(notificationType: .announcement)
                cell.selectionStyle = .none
           // }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch notificationType {
        case .notification:
            return notificationData.isEmpty ? tableView.frame.height - 100 : 50
        case .announcement:
            return announcementData.isEmpty ? tableView.frame.height - 100 : 40
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NotificationAnnouncementHeaderView.registerId) as? NotificationAnnouncementHeaderView else { return UIView() }
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 48 : 0
    }
    
//    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MaredRecordsFooterView.registerId) as? MaredRecordsFooterView else { return UIView() }
//
//        return footerView
//    }
//
//    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 0
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }
}

extension NotificationController: NotificationTypeDelegate {
    func categoryButtonTapped(_ notificationType: NotificationType) {
        self.notificationType = notificationType

        tableView.reloadData()
    }
}
