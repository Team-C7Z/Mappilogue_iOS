//
//  NotificationViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/15.
//

import UIKit

class NotificationViewController: BaseViewController {
    private let notificationTimes = ["10분 전", "30분 전", "1시간 30분 전", "2시간 전", "2시간 30분 전", "3시간 전", "4시간 전", "5시간 전", "6시간 전", "1일(24시간) 전", "2일(48시간) 전", "3일(72시간) 전", "일주일 전"]
    var selectedTime: [Bool] = []
    
    weak var delegate: NotificationTimeDelegate?
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .colorFFFFFF
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.register(NotificationCell.self, forCellReuseIdentifier: NotificationCell.registerId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectedTime = Array(repeating: false, count: notificationTimes.count)
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
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    private func setNavigationBar() {
        title = "알림"
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "back2"), for: .normal)
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        let barButtonItem = UIBarButtonItem(customView: button)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    
    @objc func backButtonTapped(_ sender: UIButton) {
        delegate?.selectedNotificationTime([])
        
        navigationController?.popViewController(animated: true)
    }
}

extension NotificationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notificationTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NotificationCell.registerId, for: indexPath) as? NotificationCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        let notificationTime = notificationTimes[indexPath.row]
        let isSelect = selectedTime[indexPath.row]
        cell.configure(with: notificationTime, isSelect: isSelect)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 42
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 22
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 22
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedTime[indexPath.row] = !selectedTime[indexPath.row]
        
        tableView.reloadRows(at: [indexPath], with: .none)
    }
}

protocol NotificationTimeDelegate: AnyObject {
    func selectedNotificationTime(_ selectedTime: [String])
}
