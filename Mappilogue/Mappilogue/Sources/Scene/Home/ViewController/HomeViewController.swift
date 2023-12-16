//
//  HomeViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit
import MappilogueKit

class HomeViewController: NavigationBarViewController {
    weak var coordinator: HomeCoordinator?
    var viewModel = HomeViewModel()
    
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
        
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setLogoNotificationBar()
        
        logoNotoficationBar.onNotificationButtonTapped = {
            self.coordinator?.showNotificationViewController()
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
            $0.leading.bottom.trailing.equalToSuperview()
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        switch viewModel.selectedScheduleType {
        case .today:
            return viewModel.dummyTodayData.isEmpty ? 1 : viewModel.dummyTodayData.count
        case .upcoming:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch viewModel.selectedScheduleType {
        case .today:
            if viewModel.dummyTodayData.isEmpty {
                return 1
            } else {
                return viewModel.isScheduleExpanded[section] ? viewModel.dummyTodayData[section].location.count + 1 : 1
            }
        case .upcoming:
            return viewModel.dummyUpcomingData.isEmpty ? 1 : viewModel.dummyUpcomingData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch viewModel.selectedScheduleType {
        case .today:
            if viewModel.dummyTodayData.isEmpty {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeEmptyScheduleCell.registerId, for: indexPath) as? HomeEmptyScheduleCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                cell.configure(scheduleType: .today)
                
                return cell
                
            } else {
                if indexPath.row == 0 {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayScheduleCell.registerId, for: indexPath) as? TodayScheduleCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
                    cell.delegate = self
              
                    let schedule = viewModel.dummyTodayData[indexPath.section]
                    let isExpanded = viewModel.isScheduleExpanded[indexPath.section]
                    cell.configure(schedule, isExpanded: isExpanded)
               
                    return cell
                    
                } else {
                    guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayScheduleInfoCell.registerId, for: indexPath) as? TodayScheduleInfoCell else { return UITableViewCell() }
                    cell.selectionStyle = .none
             
                    let schedule = viewModel.dummyTodayData[indexPath.section]
                    let location = schedule.location[indexPath.row - 1]
                    let time = schedule.time[indexPath.row - 1]
                    cell.configure(location: location, time: time)
           
                    return cell
                }
            }
            
        case .upcoming:
            if viewModel.dummyUpcomingData.isEmpty {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: HomeEmptyScheduleCell.registerId, for: indexPath) as? HomeEmptyScheduleCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                cell.configure(scheduleType: .upcoming)
                
                return cell
                
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingScheduleCell.registerId, for: indexPath) as? UpcomingScheduleCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                let schedule = viewModel.dummyUpcomingData[indexPath.row]
                cell.configure(schedule)
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch viewModel.selectedScheduleType {
        case .today:
            if viewModel.dummyTodayData.isEmpty {
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
            if viewModel.dummyUpcomingData.isEmpty {
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
            self.coordinator?.showAddScheduleViewController()
        }
        
        footerView.onMarkedRecord = {
            self.coordinator?.showContentViewController()
        }
        
        footerView.onAddRecord = {
            self.coordinator?.showWriteRecordListViewController()
        }
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        switch viewModel.selectedScheduleType {
        case .today:
            if viewModel.dummyTodayData.isEmpty {
                return 352
            } else {
                return section == viewModel.dummyTodayData.count - 1 ? 336 + 16 : 0
            }
        case .upcoming:
            return 352
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch viewModel.selectedScheduleType {
        case .today:
            if !viewModel.dummyTodayData.isEmpty {
              //  coordinator?.showCalendarDetailViewController()
            }
        case .upcoming:
            if !viewModel.dummyUpcomingData.isEmpty {
              //  coordinator?.showCalendarDetailViewController()
            }
        }
    }
}

extension HomeViewController: ScheduleTypeDelegate, ExpandCellDelegate {
    func scheduleButtonTapped(scheduleType: ScheduleType) {
        self.viewModel.selectedScheduleType = scheduleType
        
        tableView.reloadData()
    }
    
    func expandButtonTapped(in cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        viewModel.isScheduleExpanded[indexPath.section].toggle()
        tableView.reloadSections([indexPath.section], with: .none)
    }
}
