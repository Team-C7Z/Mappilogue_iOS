//
//  ScheduleViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class ScheduleViewController: BaseViewController {
    weak var delegate: PresentAddScheduleViewControllerDelegate?
    
    var schedules = dummyScheduleData()
    var calendarSchedule: CalendarSchedule?
    let lunarDate: String = ""
    
    var addButtonLocation: CGRect?
    
    private let scheduleView = UIView()
    private let dateLabel = UILabel()
    private let lunarDateLabel = UILabel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .colorF9F8F7
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.register(ScheduleCell.self, forCellReuseIdentifier: ScheduleCell.registerId)
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    private let addScheduleButton = AddScheduleButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let month = calendarSchedule?.month, let day = calendarSchedule?.day {
            dateLabel.text = "\(month)월 \(day)일"
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseOut, animations: {
            self.addScheduleButton.frame.origin.x = self.scheduleView.frame.maxX - 56 - 20
            self.addScheduleButton.frame.origin.y = self.scheduleView.frame.maxY - 56 - 20
            self.view.layoutIfNeeded()
        })
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .color404040.withAlphaComponent(0.1)
        
        scheduleView.layer.cornerRadius = 24
        scheduleView.backgroundColor = .colorF9F8F7
        
        dateLabel.font = .title01
        dateLabel.textColor = .color1C1C1C
        
        lunarDateLabel.text = "음력 3월 27일"
        lunarDateLabel.font = .body02
        lunarDateLabel.textColor = .color707070
        
        addScheduleButton.addTarget(self, action: #selector(addScheduleButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(scheduleView)
        scheduleView.addSubview(dateLabel)
        scheduleView.addSubview(lunarDateLabel)
        scheduleView.addSubview(tableView)
        view.addSubview(addScheduleButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scheduleView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(429)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(scheduleView).offset(30)
            $0.leading.equalTo(scheduleView).offset(20)
        }
        
        lunarDateLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(6)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(scheduleView).offset(78)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(scheduleView).offset(-18)
        }
        
        addScheduleButton.snp.makeConstraints {
            $0.leading.equalTo(view).offset(addButtonLocation?.minX ?? 0)
            $0.top.equalTo(view).offset(addButtonLocation?.minY ?? 0)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, !scheduleView.frame.contains(touch.location(in: view)) else { return }
        
        view.backgroundColor = .clear
        scheduleView.isHidden = true
        
        UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
            self.addScheduleButton.frame.origin.x = self.addButtonLocation?.minX ?? 0
            self.addScheduleButton.frame.origin.y = self.addButtonLocation?.minY ?? 0
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.dismiss(animated: false) {
                NotificationCenter.default.post(name: Notification.Name("DismissScheduleViewController"), object: nil)
            }
        })
    }
    
    @objc func addScheduleButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            self.delegate?.presentAddScheduleViewController()
        }
    }
}

extension ScheduleViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return schedules.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ScheduleCell.registerId, for: indexPath) as? ScheduleCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        
        if let schedules = calendarSchedule?.schedules, schedules.count > indexPath.row {
            let schedule = schedules[indexPath.row]
            cell.configure(with: schedule)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { _, _, _ in
            self.presentDeleteAlert(at: indexPath)
        }
        deleteAction.backgroundColor = .colorF14C4C
        deleteAction.image = UIImage(named: "delete")
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    private func presentDeleteAlert(at indexPath: IndexPath) {
         let deleteAlertViewController = DeleteAlertViewController()
         deleteAlertViewController.modalPresentationStyle = .overCurrentContext
         deleteAlertViewController.onDeleteTapped = {
             self.deleteSchedule(at: indexPath)
         }
         present(deleteAlertViewController, animated: false)
     }
    
    private func deleteSchedule(at indexPath: IndexPath) {
        schedules.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .none)
    }
}

protocol PresentAddScheduleViewControllerDelegate: AnyObject {
    func presentAddScheduleViewController()
}
