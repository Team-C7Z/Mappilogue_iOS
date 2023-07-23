//
//  HomeViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

class HomeViewController: NavigationBarViewController {
    let dummyTodayData = dummyTodayScheduleData(scheduleCount: 0)
    let dummyUpcomingData = dummyUpcomingScheduleData(scheduleCount: 2)
    var isScheduleExpanded = [Bool]()
    
    var selectedScheduleType: ScheduleType = .today
    var limitedUpcomingScheduleCount = 4
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .colorF9F8F7
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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        isScheduleExpanded = Array(repeating: true, count: dummyTodayData.count + 2)
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setupNavigationBar()
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
        switch selectedScheduleType {
        case .today:
            if dummyTodayData.isEmpty {
                return EmptyTodayScheduleSection.allCases.count
            } else {
                guard let tableViewSection = TodayScheduleSection(rawValue: 0) else { return 0 }
                return tableViewSection.numberOfSections(dummyTodayData)
            }
        case .upcoming:
            return dummyUpcomingData.isEmpty ? EmptyUpcomingScheduleSection.allCases.count : UpcomingScheduleSection.allCases.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch selectedScheduleType {
        case .today:
            if dummyTodayData.isEmpty {
                guard let tableViewSection = EmptyTodayScheduleSection(rawValue: section) else { return 0 }
                return tableViewSection.numberOfRows
                
            } else {
                guard let tableViewSection = TodayScheduleSection(rawValue: 0) else { return 0 }
                return tableViewSection.numberOfRows(section, scheduleData: dummyTodayData, isExpand: isScheduleExpanded[section])
            }
        case .upcoming:
            if dummyUpcomingData.isEmpty {
                guard let tableViewSection = EmptyUpcomingScheduleSection(rawValue: section) else { return 0 }
                return tableViewSection.numberOfRows
            } else {
                guard let tableViewSection = UpcomingScheduleSection(rawValue: section) else { return 0 }
                return tableViewSection.numberOfRows(section: section, scheduleData: dummyUpcomingData, limitedUpcomingScheduleCount: limitedUpcomingScheduleCount)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch selectedScheduleType {
        case .today:
            if dummyTodayData.isEmpty {
                guard let tableViewSection = EmptyTodayScheduleSection(rawValue: indexPath.section) else { return UITableViewCell() }
                
                let cellIdentifier = tableViewSection.cellIdentifier
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                
                if let emptyScheduleCell = cell as? EmptyScheduleCell {
                    tableViewSection.configureCell(emptyScheduleCell)
                }
                return cell
                
            } else if dummyTodayData.count > indexPath.section {
                switch indexPath.row {
                case 0:
                    guard let tableViewSection = TodayScheduleSection(rawValue: 0) else { return UITableViewCell() }
                    
                    let cellIdentifier = tableViewSection.cellIdentifier
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                    cell.selectionStyle = .none
                    
                    if let todayScheduleCell = cell as? TodayScheduleCell {
                        todayScheduleCell.delegate = self
                        tableViewSection.configureTodayScheduleCell(todayScheduleCell, section: indexPath.section, scheduleData: dummyTodayData, isExpand: isScheduleExpanded[indexPath.section])
                    }
            
                    return cell
                    
                default:
                    guard let tableViewSection = TodayScheduleSection(rawValue: 1) else { return UITableViewCell() }
                    
                    let cellIdentifier = tableViewSection.cellIdentifier
                    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                    cell.selectionStyle = .none
                    
                    if let todayScheduleInfoCell = cell as? TodayScheduleInfoCell {
                        tableViewSection.configureTodayScheduleInfoCell(todayScheduleInfoCell, indexPath: indexPath, scheduleData: dummyTodayData)
                    }
                  
                    return cell
                }
                
            } else if dummyTodayData.count == indexPath.section {
                guard let tableViewSection = TodayScheduleSection(rawValue: 2) else { return UITableViewCell() }
                
                let cellIdentifier = tableViewSection.cellIdentifier
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                cell.selectionStyle = .none
                
                return cell
            } else {
                guard let tableViewSection = TodayScheduleSection(rawValue: 3) else { return UITableViewCell() }
                
                let cellIdentifier = tableViewSection.cellIdentifier
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                cell.selectionStyle = .none
                
                return cell
            }
            
        case .upcoming:
            if dummyUpcomingData.isEmpty {
                guard let section = EmptyUpcomingScheduleSection(rawValue: indexPath.section) else { return UITableViewCell() }
                
                let cellIdentifier = section.cellIdentifier
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                cell.selectionStyle = .none
                
                if let emptyScheduleCell = cell as? EmptyScheduleCell {
                    section.configureCell(emptyScheduleCell)
                }
                return cell
                
            } else {
                guard let section = UpcomingScheduleSection(rawValue: indexPath.section) else { return UITableViewCell() }
                let cellIdentifier = section.cellIdentifier
                let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
                cell.selectionStyle = .none
          
                if let upcomingScheduleCell = cell as? UpcomingScheduleCell {
                    section.configureCell(upcomingScheduleCell, row: indexPath.row, scheduleData: dummyUpcomingData)
                }
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch selectedScheduleType {
        case .today:
            if dummyTodayData.isEmpty {
                guard let section = EmptyTodayScheduleSection(rawValue: indexPath.section) else { return 0 }
                return section.rowHeight
                
            } else {
                guard let section = TodayScheduleSection(rawValue: indexPath.section) else { return 0 }
                return section.rowHeight(indexPath, scheduleData: dummyTodayData)
            }
        case .upcoming:
            if dummyUpcomingData.isEmpty {
                guard let section = EmptyUpcomingScheduleSection(rawValue: indexPath.section) else { return 0 }
                return section.rowHeight
                
            } else {
                guard let section = UpcomingScheduleSection(rawValue: indexPath.section) else { return 0 }
                return section.rowHeight(indexPath.section)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ScheduleTypeHeaderView.registerId) as? ScheduleTypeHeaderView else { return UIView() }
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat = (section == 0) ? 58 : 0
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch selectedScheduleType {
        case .today:
            if dummyTodayData.isEmpty {
                guard let tableViewSection = EmptyTodayScheduleSection(rawValue: section) else { return 0 }
                return tableViewSection.footerHeight
                
            } else {
                guard let tableViewSection = TodayScheduleSection(rawValue: section) else { return 0 }
                return tableViewSection.footerHeight(section, scheduleData: dummyTodayData)
            }
        case .upcoming:
            if dummyUpcomingData.isEmpty {
                guard let tableViewSection = EmptyUpcomingScheduleSection(rawValue: section) else { return 0 }
                return tableViewSection.footerHeight
                
            } else {
                guard let tableViewSection = UpcomingScheduleSection(rawValue: section) else { return 0 }
                return tableViewSection.footerHeight(section)
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
        
        isScheduleExpanded[indexPath.section] = !isScheduleExpanded[indexPath.section]
        tableView.reloadSections([indexPath.section], with: .none)
    }
}
