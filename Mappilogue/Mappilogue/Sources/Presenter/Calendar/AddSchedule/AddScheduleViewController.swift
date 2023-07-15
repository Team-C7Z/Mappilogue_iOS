//
//  AddScheduleViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class AddScheduleViewController: BaseViewController {
    var isColorSelection: Bool = false
    var selectedColor: UIColor = .color1C1C1C
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .colorFFFFFF
        tableView.separatorStyle = .none
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        
        tableView.register(ScheduleTitleColorCell.self, forCellReuseIdentifier: ScheduleTitleColorCell.registerId)
        tableView.register(ColorSelectionCell.self, forCellReuseIdentifier: ColorSelectionCell.registerId)
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
        setNavigationButton(imageName: "back", action: #selector(backButtonTapped), isLeft: true)
        setNavigationButton(imageName: "completion", action: #selector(completionButtonTapped), isLeft: false)
    }
    
    func setNavigationButton(imageName: String, action: Selector, isLeft: Bool) {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: imageName), for: .normal)
        button.addTarget(self, action: action, for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        if isLeft {
            navigationItem.leftBarButtonItem = barButtonItem
        } else {
            navigationItem.rightBarButtonItem = barButtonItem
        }
    }

    @objc func backButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func completionButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}

extension AddScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return AddScheduleSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = AddScheduleSection(rawValue: section) else { return 0 }
        return section.numberOfRows(isColorSelection)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = AddScheduleSection(rawValue: indexPath.section) else { return UITableViewCell() }
        
        let cellIdentifier = section.cellIdentifier(isColorSelection, row: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        
        if let scheduleTitleColorCell = cell as? ScheduleTitleColorCell {
            scheduleTitleColorCell.delegate = self
            scheduleTitleColorCell.configure(with: selectedColor, isColorSelection: isColorSelection)
        }
        
        if let colorSelectionCell = cell as? ColorSelectionCell {
            colorSelectionCell.delegate = self
        }
        
        if let notificationRepeatCell = cell as? NotificationRepeatCell {
            section.configureNotificationRepeatCell(notificationRepeatCell, row: indexPath.row)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = AddScheduleSection(rawValue: indexPath.section) else { return 0 }
        return section.rowHeight(row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let section = AddScheduleSection(rawValue: section) else { return 0 }
        return section.footerHeight
    }
}

extension AddScheduleViewController: ColorSelectionDelegate, SelectedColorDelegate {
    func colorSelectionButtonTapped() {
        isColorSelection = !isColorSelection
        
        tableView.reloadSections([0], with: .none)
    }
    
    func selectColor(_ color: UIColor) {
        selectedColor = color
        
        tableView.reloadData()
    }
}
