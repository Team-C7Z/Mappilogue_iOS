//
//  NotificationController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/12.
//

import UIKit

class NotificationController: BaseViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .colorF9F8F7
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.register(TodayScheduleCell.self, forCellReuseIdentifier: TodayScheduleCell.registerId)
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
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeEmptyScheduleCell.registerId, for: indexPath) as? HomeEmptyScheduleCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: NotificationAnnouncementHeaderView.registerId) as? NotificationAnnouncementHeaderView else { return UIView() }
        
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
