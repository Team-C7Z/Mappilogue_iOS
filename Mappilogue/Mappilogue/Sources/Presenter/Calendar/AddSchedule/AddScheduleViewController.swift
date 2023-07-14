//
//  AddScheduleViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class AddScheduleViewController: BaseViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .colorFFFFFF
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.register(ScheduleTitleColorCell.self, forCellReuseIdentifier: ScheduleTitleColorCell.registerId)
        tableView.register(ScheduleDurationCell.self, forCellReuseIdentifier: ScheduleDurationCell.registerId)
        tableView.register(NotificationRepeatCell.self, forCellReuseIdentifier: NotificationRepeatCell.registerId)
        tableView.register(AddLocationButtonCell.self, forCellReuseIdentifier: AddLocationButtonCell.registerId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationBar()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(tableView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(22)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func setNavigationBar() {
        title = "일정"
        setNavigationBackButton()
        setNavigationCompletionButton()
    }
    
    func setNavigationBackButton() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "back"), for: .normal)
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let leftButton = UIBarButtonItem(customView: backButton)
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func setNavigationCompletionButton() {
        let completionButton = UIButton(type: .custom)
        completionButton.setImage(UIImage(named: "completion"), for: .normal)
        completionButton.addTarget(self, action: #selector(completionButtonTapped), for: .touchUpInside)
        let rightButton = UIBarButtonItem(customView: completionButton)
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func completionButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension AddScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 2:
            return 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleTitleColorCell.registerId, for: indexPath) as? ScheduleTitleColorCell else { return UITableViewCell() }
            
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleDurationCell.registerId, for: indexPath) as? ScheduleDurationCell else { return UITableViewCell() }
            
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationRepeatCell.registerId, for: indexPath) as? NotificationRepeatCell else { return UITableViewCell() }
            
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: AddLocationButtonCell.registerId, for: indexPath) as? AddLocationButtonCell else { return UITableViewCell() }
            
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 48
        case 1:
            return 81
        case 2:
            return 48
        case 3:
            return 53
        default:
            return 0
        }
    }
}
