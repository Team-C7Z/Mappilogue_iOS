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

    var locations: [LocationTime] = []
    var timeIndex: Int?
    var initialTime: String = "09:00 AM"
    
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
        tableView.register(DeleteLocationCell.self, forCellReuseIdentifier: DeleteLocationCell.registerId)
        tableView.register(LocationTimeCell.self, forCellReuseIdentifier: LocationTimeCell.registerId)
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
        
        setCurrentDate()
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
    
    func setCurrentDate() {
        days = monthlyCalendar.getDays(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth)
        startDate = .init(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth, day: monthlyCalendar.currentDay)
        endDate = .init(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth, day: monthlyCalendar.currentDay)
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
        return locations.isEmpty ? 4 : 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let adjustedSection = locations.isEmpty && section == 3 ? 4 : section
        guard let section = AddScheduleSection(rawValue: adjustedSection) else { return 0 }
        return section.numberOfRows(isColorSelection: isColorSelection, locationCount: locations.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let adjustedSection = locations.isEmpty && indexPath.section == 3 ? 4 : indexPath.section
        guard let section = AddScheduleSection(rawValue: adjustedSection) else { return UITableViewCell() }
        
        let cellIdentifier = section.cellIdentifier(isColorSelection, row: indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.selectionStyle = .none
        
        switch cell {
        case let scheduleTitleColorCell as ScheduleTitleColorCell:
            scheduleTitleColorCell.delegate = self
            scheduleTitleColorCell.configure(with: selectedColor, isColorSelection: isColorSelection)
        
        case let colorSelectionCell as ColorSelectionCell:
            colorSelectionCell.delegate = self
        
        case let scheduleDurationCell as ScheduleDurationCell:
            scheduleDurationCell.startDateDelegate = self
            scheduleDurationCell.endDateDelegate = self
            scheduleDurationCell.configure(startDate: startDate, endDate: endDate)
        
        case let notificationRepeatCell as NotificationRepeatCell:
            section.configureNotificationRepeatCell(notificationRepeatCell, row: indexPath.row)
            
        case let locationTimeCell as LocationTimeCell:
            locationTimeCell.delegate = self
            
            let location = locations[indexPath.row-1]
            let index = indexPath.row-1
            let locationTitle = location.location
            let time = location.time
            
            section.configureLocationTimeCell(locationTimeCell, index: index, location: locationTitle, time: time)
        
        case let addLocationButtonCell as AddLocationButtonCell:
            addLocationButtonCell.delegate = self
            
        default:
            break
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let adjustedSection = locations.isEmpty && indexPath.section == 3 ? 4 : indexPath.section
        guard let section = AddScheduleSection(rawValue: adjustedSection) else { return 0 }
        return section.rowHeight(row: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard let section = AddScheduleSection(rawValue: section) else { return 0 }
        return section.footerHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard indexPath.section == 2 else { return }

        switch indexPath.row {
        case 0:
            let notificationViewController = NotificationViewController()
            notificationViewController.delegate = self
            navigationController?.pushViewController(notificationViewController, animated: true)
        case 1:
            let repeatViewController = RepeatViewController()
            navigationController?.pushViewController(repeatViewController, animated: true)
        
        default:
            break
        }
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
            case .month:
                startDate.month = months[row]
            case .day:
                startDate.day = days[row]
            }
            updateDaysComponent(startDate, datePickerView: startDatePickerView)
        }
        
        if !endDatePickerOuterView.isHidden {
            switch componentType {
            case .year:
                endDate.year = years[row]
            case .month:
                endDate.month = months[row]
            case .day:
                endDate.day = days[row]
            }
            updateDaysComponent(endDate, datePickerView: endDatePickerView)
        }
    }
    
    private func updateDaysComponent(_ selectedDate: SelectedDate, datePickerView: UIPickerView) {
        days = monthlyCalendar.getDays(year: selectedDate.year, month: selectedDate.month)
        datePickerView.reloadComponent(ComponentType.day.rawValue)
    }
}

extension AddScheduleViewController: ColorSelectionDelegate, SelectedColorDelegate, DatePickerStartDateDelegate, DatePickerEndDateDelegate, NotificationTimeDelegate, AddLocationDelegate {
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
    
    func selectedNotificationTime(_ selectedTime: [String]) {
        print(selectedTime)
    }
    
    func addLocationButtonTapped() {
        let addLocationViewController = AddLocationViewController()
        addLocationViewController.delegate = self
        addLocationViewController.modalPresentationStyle = .overFullScreen
        present(addLocationViewController, animated: false)
    }
}

extension AddScheduleViewController: SelectedLocationDelegate, TimeButtonDelegate, SelectedTimeDelegate {
    func selectLocation(_ selectedLocation: String) {
        locations.append(LocationTime(location: selectedLocation, time: initialTime))
        
        tableView.reloadData()
    }
    
    func timeButtonTapped(_ index: Int) {
        timeIndex = index
        
        let timePickerViewController = TimePickerViewController()
        timePickerViewController.delegate = self
        timePickerViewController.modalPresentationStyle = .overFullScreen
        present(timePickerViewController, animated: false)
    }
    
    func selectTime(_ selectedTime: String) {
        let time = selectedTime.replacingOccurrences(of: "오전", with: "AM").replacingOccurrences(of: "오후", with: "PM")
        guard let index = timeIndex else { return }
        locations[index].time = time
        
        tableView.reloadData()
    }
}
