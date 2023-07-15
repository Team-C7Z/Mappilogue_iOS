//
//  AddScheduleViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class AddScheduleViewController: BaseViewController {
    private var monthlyCalendar = MonthlyCalendar()
    private var startDate: SelectedDate = SelectedDate(year: 0, month: 0, day: 0)
    private var endDate: SelectedDate  = SelectedDate(year: 0, month: 0, day: 0)

    var isColorSelection: Bool = false
    var selectedColor: UIColor = .color1C1C1C
    
    let years: [Int] = Array(1970...2050)
    let months: [Int] = Array(1...12)
    var days: [Int] = []
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .colorFFFFFF
        tableView.sectionHeaderHeight = 0
        tableView.sectionFooterHeight = 0
        tableView.separatorStyle = .none
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
        
        days = monthlyCalendar.getDays(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth)
        startDate = .init(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth, day: monthlyCalendar.currentDay)
        endDate = .init(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth, day: monthlyCalendar.currentDay)

        setSelectedDate()
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        tapGesture.cancelsTouchesInView = false
        tableView.addGestureRecognizer(tapGesture)
        
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
    
    func setSelectedDate() {
        func selectedRow(for pickerView: UIPickerView, withValue value: Int, isComponent component: Int) {
            pickerView.selectRow(value, inComponent: component, animated: true)
        }
        
        selectedRow(for: startDatePickerView, withValue: years.firstIndex(of: startDate.year) ?? 0, isComponent: ComponentType.year.rawValue)
        selectedRow(for: startDatePickerView, withValue: months.firstIndex(of: startDate.month) ?? 0, isComponent: ComponentType.month.rawValue)

        if let day = startDate.day, let currentDayIndex = days.firstIndex(of: day) {
            selectedRow(for: startDatePickerView, withValue: currentDayIndex, isComponent: ComponentType.day.rawValue)
        }
        
        selectedRow(for: endDatePickerView, withValue: years.firstIndex(of: endDate.year) ?? 0, isComponent: ComponentType.year.rawValue)
        selectedRow(for: endDatePickerView, withValue: months.firstIndex(of: endDate.month) ?? 0, isComponent: ComponentType.month.rawValue)

        if let day = endDate.day, let currentDayIndex = days.firstIndex(of: day) {
            selectedRow(for: endDatePickerView, withValue: currentDayIndex, isComponent: ComponentType.day.rawValue)
        }
    }
    
    @objc func viewTapped(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: tableView)
        
        if !startDatePickerOuterView.isHidden && location.y < startDatePickerOuterView.frame.minY {
            startDatePickerOuterView.isHidden = true
            tableView.reloadData()
        } else if !endDatePickerOuterView.isHidden && location.y < endDatePickerOuterView.frame.minY {
            endDatePickerOuterView.isHidden = true
            tableView.reloadData()
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
        cell.selectionStyle = .none
        
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
            scheduleDurationCell.configure(startDate: startDate, endDate: endDate)
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
    enum ComponentType: Int, CaseIterable {
        case year
        case month
        case day
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return ComponentType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let componentType = ComponentType(rawValue: component) else {
            return 0
        }
        
        switch componentType {
        case .year:
            return years.count
        case .month:
            return months.count
        case .day:
            return days.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let componentType = ComponentType(rawValue: component) else { return nil }
        
        switch componentType {
        case .year:
            return "\(years[row])"
        case .month:
            return "\(months[row])"
        case .day:
            return "\(days[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let componentType = ComponentType(rawValue: component) else { return }
        
        if !startDatePickerOuterView.isHidden {
            switch componentType {
            case .year:
                startDate.year = years[row]
                days = monthlyCalendar.getDays(year: startDate.year, month: startDate.month)
                startDatePickerView.reloadComponent(2)
            case .month:
                startDate.month = months[row]
                days = monthlyCalendar.getDays(year: startDate.year, month: startDate.month)
                startDatePickerView.reloadComponent(2)
            case .day:
                startDate.day = days[row]
            }
        }
        
        if !endDatePickerOuterView.isHidden {
            switch componentType {
            case .year:
                endDate.year = years[row]
                days = monthlyCalendar.getDays(year: startDate.year, month: startDate.month)
                startDatePickerView.reloadComponent(2)
            case .month:
                endDate.month = months[row]
                days = monthlyCalendar.getDays(year: endDate.year, month: endDate.month)
                endDatePickerView.reloadComponent(2)
            case .day:
                endDate.day = days[row]
            }
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
        
        tableView.reloadData()
    }
    
    func endDateButtonTapped() {
        startDatePickerOuterView.isHidden = true
        endDatePickerOuterView.isHidden = false
        
        tableView.reloadData()
    }
}
