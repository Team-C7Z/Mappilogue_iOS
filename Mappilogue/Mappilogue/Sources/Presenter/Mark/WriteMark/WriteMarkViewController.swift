//
//  WriteMarkViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class WriteMarkViewController: BaseViewController {
    var schedule: Schedule?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .colorF9F8F7
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.separatorStyle = .none
        tableView.register(CategoryCell.self, forCellReuseIdentifier: CategoryCell.registerId)
        tableView.register(ScheduleNameColorCell.self, forCellReuseIdentifier: ScheduleNameColorCell.registerId)
        tableView.register(MainLocationCell.self, forCellReuseIdentifier: MainLocationCell.registerId)
        tableView.register(TextContentCell.self, forCellReuseIdentifier: TextContentCell.registerId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let saveMarkView = SaveMarkView()

    override func viewDidLoad() {
        super.viewDidLoad()

        hideKeyboardWhenTappedAround()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationBar()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(tableView)
        view.addSubview(saveMarkView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        tableView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.bottom.equalTo(saveMarkView.snp.top)
        }
        
        saveMarkView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(48)
        }
    }
    
    private func setNavigationBar() {
        title = "기록 쓰기"
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back2"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension WriteMarkViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.registerId, for: indexPath) as? CategoryCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleNameColorCell.registerId, for: indexPath) as? ScheduleNameColorCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            
            if let schedule = schedule {
                cell.configure(with: schedule.title, color: schedule.color)
            }
           
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: MainLocationCell.registerId, for: indexPath) as? MainLocationCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        case 3:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TextContentCell.registerId, for: indexPath) as? TextContentCell else { return UITableViewCell() }
            cell.selectionStyle = .none
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 50
        case 1:
            return 48
        case 2:
            return 48
        case 3:
            return 100
        default:
            return 0
        }
    }
}
    
