//
//  HomeViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

class HomeViewController: NavigationBarViewController {
    let dummyData = generateDummyScheduleData(scheduleCount: 3)
    var isScheduleExpanded = [Bool]()
    
    var scheduleType: ScheduleType = .today
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .colorFFFFFF
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.register(EmptyScheduleCell.self, forCellReuseIdentifier: EmptyScheduleCell.registerId)
        tableView.register(AddScheduleButtonCell.self, forCellReuseIdentifier: AddScheduleButtonCell.registerId)
        tableView.register(TodayScheduleCell.self, forCellReuseIdentifier: TodayScheduleCell.registerId)
        tableView.register(TodayScheduleInfoCell.self, forCellReuseIdentifier: TodayScheduleInfoCell.registerId)
        tableView.register(AddLocationButtonCell.self, forCellReuseIdentifier: AddLocationButtonCell.registerId)
        tableView.register(ScheduleTypeHeaderView.self, forHeaderFooterViewReuseIdentifier: ScheduleTypeHeaderView.registerId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()

    override func setupProperty() {
        super.setupProperty()
        
        setupNavigationBar()
        
        isScheduleExpanded = Array(repeating: true, count: dummyData.count)
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
        return (dummyData.count == 0) ? 2 : dummyData.count + 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dummyData.count == 0 {
            return 1
        } else {
            if dummyData.count > section && isScheduleExpanded[section] {
                return dummyData[section].location.count + 1
            } else {
                return 1
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if dummyData.count == 0 {
            switch indexPath.section {
            case 0:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyScheduleCell.registerId, for: indexPath) as? EmptyScheduleCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                return cell
                
            case 1:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: AddScheduleButtonCell.registerId, for: indexPath) as? AddScheduleButtonCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                return cell
                
            default:
                return UITableViewCell()
            }
        } else if dummyData.count > indexPath.section {
            switch indexPath.row {
            case 0 :
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayScheduleCell.registerId, for: indexPath) as? TodayScheduleCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                cell.delegate = self
                
                let title = dummyData[indexPath.section].title
                let backgroundColor = dummyData[indexPath.section].color
                let isExpandable = dummyData.count > 1 ? true : false
                
                cell.configure(with: title, backgroundColor: backgroundColor, isExpandable: isExpandable, isExpanded: isScheduleExpanded[indexPath.section])
                return cell
                
            default:
                guard let cell = tableView.dequeueReusableCell(withIdentifier: TodayScheduleInfoCell.registerId, for: indexPath) as? TodayScheduleInfoCell else { return UITableViewCell() }
                cell.selectionStyle = .none
                
                let index = "\(indexPath.row)"
                let location = dummyData[indexPath.section].location[indexPath.row - 1]
                let time = dummyData[indexPath.section].time[indexPath.row - 1]
                
                cell.configure(order: index, location: location, time: time)
                return cell
            }
            
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddLocationButtonCell.registerId, for: indexPath) as? AddLocationButtonCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if dummyData.count == 0 {
            return (indexPath.section == 0) ? 130 : 53
        } else if dummyData.count > indexPath.section {
            switch indexPath.row {
            case 0 :
                return 38
            default:
                return 50 + 10
            }
        } else {
            return 53
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: ScheduleTypeHeaderView.registerId) as? ScheduleTypeHeaderView else { return UIView() }
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeight: CGFloat = (section == 0) ? 48 : 0
        return headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if dummyData.count == 0 {
            return 10
        } else {
            return (dummyData.count - 1) == section ? 10 : 13
        }
    }
}

extension HomeViewController: ScheduleTypeDelegate, ExpandCellDelegate {
    func scheduleButtonTapped(scheduleType: ScheduleType) {
        
    }
    
    func expandButtonTapped(in cell: UITableViewCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }
        
        isScheduleExpanded[indexPath.section] = !isScheduleExpanded[indexPath.section]
        tableView.reloadSections([indexPath.section], with: .none)
    }
}
