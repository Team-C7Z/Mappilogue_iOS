//
//  NotificationViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/12.
//

import UIKit

class NotificationViewController: NavigationBarViewController {
    var viewModel = NotificationViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .grayF9F8F7
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.register(EmptyNotificationCell.self, forCellReuseIdentifier: EmptyNotificationCell.registerId)
        tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.registerId)
        tableView.register(AnnouncementCell.self, forCellReuseIdentifier: AnnouncementCell.registerId)
        tableView.register(AnnouncementContentCell.self, forCellReuseIdentifier: AnnouncementContentCell.registerId)
        tableView.register(NotificationAnnouncementHeaderView.self, forHeaderFooterViewReuseIdentifier: NotificationAnnouncementHeaderView.registerId)
        tableView.register(LineHeaderView.self, forHeaderFooterViewReuseIdentifier: LineHeaderView.registerId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.delegate = self
    }

    override func setupProperty() {
        super.setupProperty()
        
        setPopBar(title: "알림")
        
        popBar.onPopButtonTapped = { [weak self] in
            guard let self = self else { return }
            
            navigationController?.popViewController(animated: false)
        }
    }
     
    override func setupHierarchy() {
        super.setupHierarchy()
      
        view.addSubview(tableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
     
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(88)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func loadAnnouncement() {
        guard !viewModel.isLoading && viewModel.currentPage <= viewModel.totalPage else { return }
        
        viewModel.isLoading = true
        
        viewModel.getAnnouncementData(pageNo: viewModel.currentPage)
    }
    
    private func removeNotification(_ index: Int) {
        viewModel.notificationData.remove(at: index)
        
        tableView.reloadData()
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch viewModel.notificationType {
        case .notification:
            return 1
        case .announcement:
            return viewModel.announcements.isEmpty ? 1 : viewModel.announcements.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.notificationType {
        case .notification:
            return 1
        case .announcement:
            if viewModel.announcements.isEmpty {
                return 1
            } else {
                return viewModel.isAnnouncementExpanded[section] ? 2 : 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.notificationType {
        case .notification:
            if viewModel.notificationData.isEmpty {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyNotificationCell.registerId, for: indexPath) as? EmptyNotificationCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.configure(notificationType: .notification)
                
                return cell
             } else {
                 guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.registerId, for: indexPath) as? NotificationCell else { return UITableViewCell() }
                 cell.selectionStyle = .none
                 
                 let notification = viewModel.notificationData[indexPath.section]
                 cell.configure(notification, index: indexPath.section)
                 
                 cell.onRemove = { [weak self] index in
                     guard let self = self else { return }
                     
                     removeNotification(index)
                 }
                 
                 return cell
             }
        case .announcement:
            if viewModel.announcements.isEmpty {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyNotificationCell.registerId, for: indexPath) as? EmptyNotificationCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.configure(notificationType: .announcement)
            
                return cell
            } else {
                if indexPath.row == 0 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: AnnouncementCell.registerId, for: indexPath) as? AnnouncementCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    cell.delegate = self
                    
                    let announcement = viewModel.announcements[indexPath.section]
                    let isExpanded = viewModel.isAnnouncementExpanded[indexPath.section]
                   cell.configure(announcement, isExpanded: isExpanded)
                
                    return cell
                } else {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: AnnouncementContentCell.registerId, for: indexPath) as? AnnouncementContentCell else { return UITableViewCell() }
                    
                    let content = viewModel.announcements[indexPath.section].content
                    cell.configure(content)
              
                    return cell
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.notificationType {
        case .notification:
            return viewModel.notificationData.isEmpty ? tableView.frame.height - 100 : 83
        case .announcement:
            if viewModel.announcements.isEmpty {
                return tableView.frame.height - 100
            } else {
                let content = viewModel.announcements[indexPath.section].content
                let contentTextHeight = calculateTextHeight(text: content, font: UIFont.systemFont(ofSize: 17.8), width: tableView.frame.width)
                let cellHeight = contentTextHeight + 16
                
                return indexPath.row == 0 ? 70 : cellHeight
            }
        }
    }
    
    func calculateTextHeight(text: String, font: UIFont, width: CGFloat) -> CGFloat {
          let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
          let boundingBox = text.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
          return ceil(boundingBox.height)
      
  }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NotificationAnnouncementHeaderView.registerId) as? NotificationAnnouncementHeaderView else { return UIView() }
            headerView.delegate = self
            headerView.configure(viewModel.notificationType)
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

extension NotificationViewController: NotificationTypeDelegate {
    func categoryButtonTapped(_ notificationType: NotificationType) {
        viewModel.notificationType = notificationType

        if notificationType == .announcement {
            loadAnnouncement()
        }
        
        tableView.reloadData()
    }
}

extension NotificationViewController: ExpandCellDelegate {
    func expandButtonTapped(in cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        viewModel.isAnnouncementExpanded[indexPath.section].toggle()
        tableView.reloadSections([indexPath.section], with: .none)
    }
}

extension NotificationViewController: AnnouncementDelegate {
    func getAnnouncement() {
        tableView.reloadData()
    }
}
