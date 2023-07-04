//
//  HomeViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

class HomeViewController: NavigationBarViewController {
    let dummyTodayData = dummyTodayScheduleData(scheduleCount: 1)
    let dummyUpcomingData = dummyUpcomingScheduleData(scheduleCount: 1)
    var isScheduleExpanded = [Bool]()
    
    var scheduleType: ScheduleType = .today
    var limitedUpcomingScheduleCount = 4
    
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
        tableView.register(MarkedRecordsCell.self, forCellReuseIdentifier: MarkedRecordsCell.registerId)
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
            return dummyTodayData.isEmpty ? 3 : dummyTodayData.count + 2
        case .upcoming:
            return dummyUpcomingData.isEmpty ? 3 : 3
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch scheduleType {
        case .today:
            if dummyTodayData.isEmpty {
                return 1
            } else if dummyTodayData.count > section && isScheduleExpanded[section] {
                return dummyTodayData[section].location.count + 1
            } else {
                return 1
            }
        case .upcoming:
            if dummyUpcomingData.isEmpty {
               return 1
            } else {
                switch section {
                case 0:
                    return min(dummyUpcomingData.count, limitedUpcomingScheduleCount)
                default:
                    return 1
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch scheduleType {
        case .today:
            if dummyTodayData.isEmpty {
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
                    
                case 2:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: MarkedRecordsCell.registerId, for: indexPath) as? MarkedRecordsCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    
                    return cell
                    
                default:
                    return UITableViewCell()
                }
            } else if dummyTodayData.count > indexPath.section {
                switch indexPath.row {
                case 0:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayScheduleCell.registerId, for: indexPath) as? TodayScheduleCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    cell.delegate = self
                    
                    let schedule = dummyTodayData[indexPath.section]
                    let title = schedule.title
                    let backgroundColor = schedule.color
                    let isExpandable = dummyTodayData.count > 1
                    
                    cell.configure(with: title, backgroundColor: backgroundColor, isExpandable: isExpandable, isExpanded: isScheduleExpanded[indexPath.section])
                    
                    return cell
                    
                default:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayScheduleInfoCell.registerId, for: indexPath) as? TodayScheduleInfoCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    
                    let schedule = dummyTodayData[indexPath.section]
                    let index = "\(indexPath.row)"
                    let location = schedule.location[indexPath.row - 1]
                    let time = schedule.time[indexPath.row - 1]
                    
                    cell.configure(order: index, location: location, time: time)
                    return cell
                }
                
            } else if dummyTodayData.count == indexPath.section {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AddLocationButtonCell.registerId, for: indexPath) as? AddLocationButtonCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                return cell
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: MarkedRecordsCell.registerId, for: indexPath) as? MarkedRecordsCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                return cell
            }
        case .upcoming:
            if dummyUpcomingData.isEmpty {
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
                    
                case 2:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: MarkedRecordsCell.registerId, for: indexPath) as? MarkedRecordsCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    
                    return cell
                    
                default:
                    return UITableViewCell()
                }
                
            } else {
                switch indexPath.section {
                case 0:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingScheduleCell.registerId, for: indexPath) as? UpcomingScheduleCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    
                    let schedule = dummyUpcomingData[indexPath.row]
                    let title = schedule.title
                    let date = schedule.date
                    let time = schedule.time
                    
                    cell.configure(with: title, date: date, time: time)
                    
                    return cell
                case 1:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: AddScheduleButtonCell.registerId, for: indexPath) as? AddScheduleButtonCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    
                    return cell
                case 2:
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: MarkedRecordsCell.registerId, for: indexPath) as? MarkedRecordsCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    
                    return cell
                default:
                    return UITableViewCell()
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch scheduleType {
        case .today:
            if dummyTodayData.isEmpty {
                switch indexPath.section {
                case 0:
                    return 130
                case 1:
                    return 53
                case 2:
                    return 259
                default:
                    return 0
                }
            } else if dummyTodayData.count > indexPath.section {
                switch indexPath.row {
                case 0:
                    return 38
                default:
                    return 50 + 10
                }
            } else if dummyTodayData.count == indexPath.section {
                return 53
            } else {
                return 259
            }
        case .upcoming:
            if dummyUpcomingData.isEmpty {
                switch indexPath.section {
                case 0:
                    return 130
                case 1:
                    return 53
                default:
                    return 259
                }
            } else {
                switch indexPath.section {
                case 0:
                    return 76 + 10
                case 1:
                    return 53
                default:
                    return 259
                }
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
            if dummyTodayData.isEmpty {
                switch section {
                case 0:
                    return 10
                case 1:
                    return 27
                default:
                    return 0
                }
            } else {
                if (dummyTodayData.count - 1) > section {
                    return 13
                } else if (dummyTodayData.count - 1) == section {
                    return 10
                } else if dummyTodayData.count == section {
                    return 27
                } else {
                    return 0
                }
            }
        case .upcoming:
            if dummyUpcomingData.isEmpty {
                switch section {
                case 0:
                    return 10
                case 1:
                    return 27
                default:
                    return 0
                }
            } else {
                switch section {
                case 0:
                    return 0
                default:
                    return 27
                }
            }
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
