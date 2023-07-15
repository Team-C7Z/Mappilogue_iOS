//
//  AddScheduleViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class AddScheduleViewController: BaseViewController {
    private var monthlyCalendar = MonthlyCalendar()
    private var selectedDate: SelectedDate = SelectedDate(year: 0, month: 0, day: 0)
    
    var isColorSelection: Bool = false
    var selectedColor: UIColor = .color1C1C1C
    
    let years = Array(1970...2050)
    let months = Array(1...12)
    let days = Array(1...31)
    
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
    
    private let startDatePickerOuterView = UIView()
    private let startDatePickerView = UIPickerView()
    private let endDatePickerOuterView = UIView()
    private let endDatePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedDate = .init(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth, day: monthlyCalendar.currentDay)
        setDate()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationBar()
        
        startDatePickerOuterView.backgroundColor = .colorF5F3F0
        endDatePickerOuterView.backgroundColor = .colorF5F3F0
        
        startDatePickerView.backgroundColor = .colorF5F3F0
        startDatePickerView.delegate = self
        startDatePickerView.dataSource = self

        endDatePickerView.backgroundColor = .colorF5F3F0
        endDatePickerView.delegate = self
        endDatePickerView.dataSource = self
        
        startDatePickerOuterView.isHidden = true
        endDatePickerOuterView.isHidden = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(tableView)
        view.addSubview(startDatePickerOuterView)
        view.addSubview(endDatePickerOuterView)
        startDatePickerOuterView.addSubview(startDatePickerView)
        endDatePickerOuterView.addSubview(endDatePickerView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(22)
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    
        startDatePickerOuterView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(236)
        }
        
        endDatePickerOuterView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(236)
        }
        
        startDatePickerView.snp.makeConstraints {
            $0.top.equalTo(startDatePickerOuterView).offset(5)
            $0.leading.equalTo(startDatePickerOuterView).offset(40)
            $0.trailing.equalTo(startDatePickerOuterView).offset(-40)
            $0.bottom.equalTo(startDatePickerOuterView).offset(-5)
        }
        
        endDatePickerView.snp.makeConstraints {
            $0.top.equalTo(endDatePickerOuterView).offset(5)
            $0.leading.equalTo(endDatePickerOuterView).offset(40)
            $0.trailing.equalTo(endDatePickerOuterView).offset(-40)
            $0.bottom.equalTo(endDatePickerOuterView).offset(-5)
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
    
    func setDate() {
        let year = selectedDate.year
        if let currentYearIndex = years.firstIndex(of: year) {
            startDatePickerView.selectRow(currentYearIndex, inComponent: 0, animated: true)
            endDatePickerView.selectRow(currentYearIndex, inComponent: 0, animated: true)
        }
        
        let month = selectedDate.month
        if let currentMonthIndex = months.firstIndex(of: month) {
            startDatePickerView.selectRow(currentMonthIndex, inComponent: 1, animated: true)
            endDatePickerView.selectRow(currentMonthIndex, inComponent: 1, animated: true)
        }
        
        if let day = selectedDate.day, let currentDayIndex = days.firstIndex(of: day) {
            startDatePickerView.selectRow(currentDayIndex, inComponent: 2, animated: true)
            endDatePickerView.selectRow(currentDayIndex, inComponent: 2, animated: true)
        }
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
        
        if let scheduleDurationCell = cell as? ScheduleDurationCell {
            scheduleDurationCell.startDateDelegate = self
            scheduleDurationCell.endDateDelegate = self
            scheduleDurationCell.configure(with: selectedDate)
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension AddScheduleViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return years.count
        case 1:
            return months.count
        case 2:
            return days.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return "\(years[row])"
        case 1:
            return "\(months[row])"
        case 2:
            return "\(days[row])"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedDate.year = years[row]
        case 1:
            selectedDate.month = months[row]
        case 2:
            selectedDate.day = days[row]
        default:
            break
        }
    }
}

extension AddScheduleViewController: ColorSelectionDelegate, SelectedColorDelegate, DatePickerStartDateDelegate, DatePickerEndDateDelegate {
    func colorSelectionButtonTapped() {
        isColorSelection = !isColorSelection
        
        tableView.reloadSections([0], with: .none)
    }
    
    func selectColor(_ color: UIColor) {
        selectedColor = color
        
        tableView.reloadData()
    }
    
    func startDateButtonTapped() {
        startDatePickerOuterView.isHidden = false
        endDatePickerOuterView.isHidden = true
    }
    
    func endDateButtonTapped() {
        startDatePickerOuterView.isHidden = true
        endDatePickerOuterView.isHidden = false
    }
}
