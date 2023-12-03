//
//  HomeViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit
import MappilogueKit

class HomeViewController: NavigationBarViewController {
    let dummyTodayData = dummyTodayScheduleData(scheduleCount: 2)
    let dummyUpcomingData = dummyUpcomingScheduleData(scheduleCount: 0)
    var isScheduleExpanded = [Bool]()
    
    var selectedScheduleType: ScheduleType = .today
    var limitedUpcomingScheduleCount = 4
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .grayF9F8F7
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        tableView.register(HomeEmptyScheduleCell.self, forCellReuseIdentifier: HomeEmptyScheduleCell.registerId)
        tableView.register(TodayScheduleCell.self, forCellReuseIdentifier: TodayScheduleCell.registerId)
        tableView.register(TodayScheduleInfoCell.self, forCellReuseIdentifier: TodayScheduleInfoCell.registerId)
        tableView.register(UpcomingScheduleCell.self, forCellReuseIdentifier: UpcomingScheduleCell.registerId)
        tableView.register(ScheduleTypeHeaderView.self, forHeaderFooterViewReuseIdentifier: ScheduleTypeHeaderView.registerId)
        tableView.register(MaredRecordsFooterView.self, forHeaderFooterViewReuseIdentifier: MaredRecordsFooterView.registerId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isScheduleExpanded = Array(repeating: true, count: dummyTodayData.count)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setLogoNotificationBar()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(tableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
    
        tableView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(88)
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch selectedScheduleType {
        case .today:
            return dummyTodayData.isEmpty ? 1 : dummyTodayData.count
        case .upcoming:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedScheduleType {
        case .today:
            if dummyTodayData.isEmpty {
                return 1
            } else {
                return isScheduleExpanded[section] ? dummyTodayData[section].location.count + 1 : 1
            }
        case .upcoming:
            return dummyUpcomingData.isEmpty ? 1 : dummyUpcomingData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedScheduleType {
        case .today:
            if dummyTodayData.isEmpty {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeEmptyScheduleCell.registerId, for: indexPath) as? HomeEmptyScheduleCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                cell.configure(scheduleType: .today)
                
                return cell
                
            } else {
                if indexPath.row == 0 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayScheduleCell.registerId, for: indexPath) as? TodayScheduleCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    cell.delegate = self
              
                    let schedule = dummyTodayData[indexPath.section]
                    let isExpanded = isScheduleExpanded[indexPath.section]
                    cell.configure(schedule, isExpanded: isExpanded)
               
                    return cell
                    
                } else {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayScheduleInfoCell.registerId, for: indexPath) as? TodayScheduleInfoCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
             
                    let schedule = dummyTodayData[indexPath.section]
                    let location = schedule.location[indexPath.row - 1]
                    let time = schedule.time[indexPath.row - 1]
                    cell.configure(location: location, time: time)
           
                    return cell
                }
            }
            
        case .upcoming:
            if dummyUpcomingData.isEmpty {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeEmptyScheduleCell.registerId, for: indexPath) as? HomeEmptyScheduleCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                cell.configure(scheduleType: .upcoming)
                
                return cell
                
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingScheduleCell.registerId, for: indexPath) as? UpcomingScheduleCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                let schedule = dummyUpcomingData[indexPath.row]
                cell.configure(schedule)
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch selectedScheduleType {
        case .today:
            if dummyTodayData.isEmpty {
                return 130 + 16
                
            } else {
                if indexPath.row == 0 {
                    return 38 + 16
                } else if indexPath.row == 1 {
                    return 48 + 16
                } else {
                    return 48 + 8
                }
            }
        case .upcoming:
            if dummyUpcomingData.isEmpty {
                return 130 + 16
                
            } else {
                if indexPath.row == 0 {
                    return 76 + 16
                } else {
                    return 76 + 8
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: ScheduleTypeHeaderView.registerId) as? ScheduleTypeHeaderView else { return UIView() }
        headerView.delegate = self
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 30 : 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footerView = tableView.dequeueReusableHeaderFooterView(withIdentifier: MaredRecordsFooterView.registerId) as? MaredRecordsFooterView else { return UIView() }
        
        footerView.onAddSchedule = {
            self.navigateToAddScheduleViewController()
        }
        
        footerView.onMarkedRecord = {
            self.navigateToRecordContentViewController()
        }
        
        footerView.onAddRecord = {
            self.navigateToSelectWriteRecordViewController()
        }
        
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch selectedScheduleType {
        case .today:
            if dummyTodayData.isEmpty {
                return 352
            } else {
                return section == dummyTodayData.count - 1 ? 336 + 16 : 0
            }
        case .upcoming:
            return 352
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch selectedScheduleType {
        case .today:
            if !dummyTodayData.isEmpty {
                navigateToAddScheduleViewController()
            }
        case .upcoming:
            if !dummyUpcomingData.isEmpty {
                navigateToAddScheduleViewController()
            }
        }
    }
}

extension HomeViewController: ScheduleTypeDelegate, ExpandCellDelegate {
    func scheduleButtonTapped(scheduleType: ScheduleType) {
        self.selectedScheduleType = scheduleType
        
        tableView.reloadData()
    }
    
    func expandButtonTapped(in cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        isScheduleExpanded[indexPath.section].toggle()
        tableView.reloadSections([indexPath.section], with: .none)
    }
    
    func navigateToAddScheduleViewController() {
        let addScheduleViewController = AddScheduleViewController()
        navigationController?.pushViewController(addScheduleViewController, animated: true)
    }
    
    func navigateToRecordContentViewController() {
        let recordContentViewController = MyRecordContentViewController()
        navigationController?.pushViewController(recordContentViewController, animated: true)
    }
    
    func navigateToSelectWriteRecordViewController() {
        let selectWriteRecordViewController = SelectWriteRecordViewController()
        navigationController?.pushViewController(selectWriteRecordViewController, animated: true)
    }
}
