//
//  HomeViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

class HomeViewController: NavigationBarViewController {
    let dummyTodayData = dummyTodayScheduleData(scheduleCount: 0)
    let dummyUpcomingData = dummyUpcomingScheduleData(scheduleCount: 0)
    var isScheduleExpanded = [Bool]()
    
    var scheduleType: ScheduleType = .today
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .colorFFFFFF
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.register(EmptyScheduleCell.self, forCellReuseIdentifier: EmptyScheduleCell.registerId)
        tableView.register(TodayScheduleCell.self, forCellReuseIdentifier: TodayScheduleCell.registerId)
        tableView.register(TodayScheduleInfoCell.self, forCellReuseIdentifier: TodayScheduleInfoCell.registerId)
        tableView.register(UpcomingScheduleCell.self, forCellReuseIdentifier: UpcomingScheduleCell.registerId)
        tableView.register(AddScheduleButtonCell.self, forCellReuseIdentifier: AddScheduleButtonCell.registerId)
        tableView.register(AddLocationButtonCell.self, forCellReuseIdentifier: AddLocationButtonCell.registerId)
        tableView.register(ScheduleTypeHeaderView.self, forHeaderFooterViewReuseIdentifier: ScheduleTypeHeaderView.registerId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func setupProperty() {
        super.setupProperty()
        
        setupNavigationBar()
        
        isScheduleExpanded = Array(repeating: true, count: dummyTodayData.count)
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
    
    func setupNavigationBar() {
        self.navigationItem.title = ""
        
        let logoImage = UIImage(named: "home_logo")?.withRenderingMode(.alwaysOriginal)
        let buttonItem = UIBarButtonItem(image: logoImage, style: .plain, target: self, action: nil)
        navigationItem.leftBarButtonItem = buttonItem
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch scheduleType {
        case .today:
            return (dummyTodayData.count == 0) ? 2 : dummyTodayData.count + 1
        case .upcoming:
            return (dummyUpcomingData.count == 0) ? 2 : dummyUpcomingData.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch scheduleType {
        case .today:
            if dummyTodayData.count == 0 {
                return 1
            } else {
                if dummyTodayData.count > section && isScheduleExpanded[section] {
                    return dummyTodayData[section].location.count + 1
                } else {
                    return 1
                }
            }
        case .upcoming:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch scheduleType {
        case .today:
            if dummyTodayData.count == 0 {
                switch indexPath.section {
                case 0:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyScheduleCell.registerId, for: indexPath) as? EmptyScheduleCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    
                    cell.configure(scheduleType: .today)
                    
                    return cell
                    
                case 1:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: AddScheduleButtonCell.registerId, for: indexPath) as? AddScheduleButtonCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    
                    return cell
                    
                default:
                    return UITableViewCell()
                }
            } else if dummyTodayData.count > indexPath.section {
                switch indexPath.row {
                case 0 :
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayScheduleCell.registerId, for: indexPath) as? TodayScheduleCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    cell.delegate = self
                    
                    let title = dummyTodayData[indexPath.section].title
                    let backgroundColor = dummyTodayData[indexPath.section].color
                    let isExpandable = dummyTodayData.count > 1 ? true : false
                    
                    cell.configure(with: title, backgroundColor: backgroundColor, isExpandable: isExpandable, isExpanded: isScheduleExpanded[indexPath.section])
                    return cell
                    
                default:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayScheduleInfoCell.registerId, for: indexPath) as? TodayScheduleInfoCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    
                    let index = "\(indexPath.row)"
                    let location = dummyTodayData[indexPath.section].location[indexPath.row - 1]
                    let time = dummyTodayData[indexPath.section].time[indexPath.row - 1]
                    
                    cell.configure(order: index, location: location, time: time)
                    return cell
                }
                
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AddLocationButtonCell.registerId, for: indexPath) as? AddLocationButtonCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                return cell
            }
        case .upcoming:
            if dummyUpcomingData.count == 0 {
                switch indexPath.section {
                case 0:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyScheduleCell.registerId, for: indexPath) as? EmptyScheduleCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    
                    cell.configure(scheduleType: .upcoming)
                    
                    return cell
                    
                case 1:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: AddScheduleButtonCell.registerId, for: indexPath) as? AddScheduleButtonCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    
                    return cell
                    
                default:
                    return UITableViewCell()
                }
                
            } else if dummyUpcomingData.count > indexPath.section {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingScheduleCell.registerId, for: indexPath) as? UpcomingScheduleCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                let title = dummyUpcomingData[indexPath.section].title
                let date = dummyUpcomingData[indexPath.section].date
                let time = dummyUpcomingData[indexPath.section].time
                
                cell.configure(with: title, date: date, time: time)
                
                return cell
                
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AddScheduleButtonCell.registerId, for: indexPath) as? AddScheduleButtonCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch scheduleType {
        case .today:
            if dummyTodayData.count == 0 {
                return (indexPath.section == 0) ? 130 : 53
            } else if dummyTodayData.count > indexPath.section {
                switch indexPath.row {
                case 0 :
                    return 38
                default:
                    return 50 + 10
                }
            } else {
                return 53
            }
        case .upcoming:
            if dummyUpcomingData.count == 0 {
                return (indexPath.section == 0) ? 130 : 53
            } else if dummyUpcomingData.count > indexPath.section {
                return 76
            } else {
                return 53
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ScheduleTypeHeaderView.registerId) as? ScheduleTypeHeaderView else { return UIView() }
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat = (section == 0) ? 48 : 0
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch scheduleType {
        case .today:
            if dummyTodayData.count == 0 {
                return 10
            } else {
                return (dummyTodayData.count - 1) == section ? 10 : 13
            }
        case .upcoming:
            return 10
        }
    }
}

extension HomeViewController: ScheduleTypeDelegate, ExpandCellDelegate {
    func scheduleButtonTapped(scheduleType: ScheduleType) {
        self.scheduleType = scheduleType
        
        tableView.reloadData()
    }
    
    func expandButtonTapped(in cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        isScheduleExpanded[indexPath.section] = !isScheduleExpanded[indexPath.section]
        tableView.reloadSections([indexPath.section], with: .none)
    }
}
