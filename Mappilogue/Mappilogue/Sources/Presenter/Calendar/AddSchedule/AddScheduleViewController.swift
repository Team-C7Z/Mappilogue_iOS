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
    var selectedLocations: [Int] = []
    var timeIndex: Int?
    var initialTime: String = "9:00 AM"
    var isDeleteModel: Bool = false
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .colorF9F8F7
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
        tableView.dragInteractionEnabled = true
        tableView.dragDelegate = self
        tableView.dropDelegate = self

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
        
        let keyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        keyboardTap.cancelsTouchesInView = false
        keyboardTap.delegate = self
        tableView.addGestureRecognizer(keyboardTap)
        
        let datePickerTap = UITapGestureRecognizer(target: self, action: #selector(dismissDatePicker))
        datePickerTap.cancelsTouchesInView = false
        datePickerTap.delegate = self
        tableView.addGestureRecognizer(datePickerTap)
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
            $0.edges.equalTo(view.safeAreaLayoutGuide)
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
            $0.leading.equalTo(startDatePickerOuterView).offset(35)
            $0.trailing.equalTo(startDatePickerOuterView).offset(-33)
            $0.bottom.equalTo(startDatePickerOuterView).offset(-5)
        }
        
        endDatePickerView.snp.makeConstraints {
            $0.top.equalTo(endDatePickerOuterView).offset(5)
            $0.leading.equalTo(endDatePickerOuterView).offset(35)
            $0.trailing.equalTo(endDatePickerOuterView).offset(-33)
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
    
    @objc func dismissDatePicker(_ gesture: UITapGestureRecognizer) {
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

extension AddScheduleViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDragDelegate, UITableViewDropDelegate {
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
            
        case let deleteLocationCell as DeleteLocationCell:
            deleteLocationCell.deleteModelDelegate = self
            deleteLocationCell.deleteLocationDelegate = self
            
        case let locationTimeCell as LocationTimeCell:
            locationTimeCell.timeDelegate = self
            locationTimeCell.checkDelegate = self
            
            let location = locations[indexPath.row-1]
            let index = indexPath.row-1

            section.configureLocationTimeCell(locationTimeCell, index: index, schedule: location, isDeleteMode: isDeleteModel)
        
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
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        guard !locations.isEmpty && indexPath.section == 3 && indexPath.row > 0 else {
            return []
        }
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        guard let destinationIndexPath = destinationIndexPath, session.localDragSession != nil, !locations.isEmpty, destinationIndexPath.section == 3 && destinationIndexPath.row > 0 else {
            return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
            
        }
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 3 && indexPath.row > 0
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        guard !locations.isEmpty && sourceIndexPath.section == 3 && sourceIndexPath.row > 0 && destinationIndexPath.section == 3 && destinationIndexPath.row > 0 else { return }
        let moveCell = locations[sourceIndexPath.row-1]
        locations.remove(at: sourceIndexPath.row-1)
        locations.insert(moveCell, at: destinationIndexPath.row-1)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) { }
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
        
        if !startDatePickerOuterView.isHidden {
            switch componentType {
            case .year:
                if startDate.year == years[row] {
                    return "\(years[row]) 년"
                }
                return "\(years[row])"
            case .month:
                if startDate.month == months[row] {
                    return "\(months[row]) 월"
                }
                return "\(months[row])"
            case .day:
                if startDate.day == days[row] {
                    return "\(days[row]) 일"
                }
                return "\(days[row])"
            }
        }

        if !endDatePickerOuterView.isHidden {
            switch componentType {
            case .year:
                if endDate.year == years[row] {
                    return "\(years[row]) 년"
                }
                return "\(years[row])"
            case .month:
                if endDate.month == months[row] {
                    return "\(months[row]) 월"
                }
                return "\(months[row])"
            case .day:
                if endDate.day == days[row] {
                    return "\(days[row]) 일"
                }
                return "\(days[row])"
            }
        }
        return ""
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
            
            if daysBetween() < 0 {
                endDate = .init(year: startDate.year, month: startDate.month, day: startDate.day ?? 0)
            }
        }
        
    }
    
    private func updateDaysComponent(_ selectedDate: SelectedDate, datePickerView: UIPickerView) {
        days = monthlyCalendar.getDays(year: selectedDate.year, month: selectedDate.month)
        datePickerView.reloadAllComponents()
    }
    
    func daysBetween() -> Int {
        let startDate = setDateFormatter(date: startDate)
        let endDate = setDateFormatter(date: endDate)
        if let start = startDate, let end = endDate, let daysDifference = daysBetweenDates(start: start, end: end) {
            return daysDifference
        }
        return 0
    }
    
    func setDateFormatter(date: SelectedDate) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        return dateFormatter.date(from: "\(date.year)\(String(format: "%02d", date.month))\(String(format: "%02d", date.day ?? 0))")
    }
    
    func daysBetweenDates(start: Date, end: Date) -> Int? {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.day], from: start, to: end)
        return dateComponents.day
    }
}

extension AddScheduleViewController: ColorSelectionDelegate, SelectedColorDelegate, DatePickerStartDateDelegate, DatePickerEndDateDelegate, NotificationTimeDelegate, AddLocationDelegate, SelectedLocationDelegate, TimeButtonDelegate, SelectedTimeDelegate, DeleteModeDelegate, DeleteLocationDelegate, CheckLocationDelegate {
    func colorSelectionButtonTapped() {
        isColorSelection = !isColorSelection
        tableView.reloadSections([0], with: .none)
    }
    
    func selectColor(_ color: UIColor) {
        selectedColor = color
        reloadTableView()
    }
    
    func startDateButtonTapped() {
        startDatePickerOuterView.isHidden = false
        endDatePickerOuterView.isHidden = true
        
        reloadTableView()
        startDatePickerView.reloadAllComponents()
    }
    
    func endDateButtonTapped() {
        startDatePickerOuterView.isHidden = true
        endDatePickerOuterView.isHidden = false
 
        reloadTableView()
        endDatePickerView.reloadAllComponents()
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
    
    func selectLocation(_ selectedLocation: String) {
        locations.append(LocationTime(location: selectedLocation, time: initialTime))
        reloadTableView()
    }
    
    func timeButtonTapped(_ index: Int) {
        timeIndex = index
        presentTimePicker(index)
    }
    
    func selectTime(_ selectedTime: String?) {
        guard let selectedTime = selectedTime else { return }
        let time = formatTime(selectedTime)
        guard let index = timeIndex else { return }
        locations[index].time = time
        reloadTableView()
    }
    
    private func formatTime(_ time: String) -> String {
        return time.replacingOccurrences(of: "오전", with: "AM").replacingOccurrences(of: "오후", with: "PM")
    }
    
    func switchDeleteMode(_ isDeleteMode: Bool) {
        self.isDeleteModel = isDeleteMode
        reloadTableView()
    }
    
    func deleteButtonTapped() {
        guard !selectedLocations.isEmpty else { return }
        
        let alertViewController = AlertViewController()
        let alert = Alert(titleText: "선택한 장소를 삭제할까요?",
                          cancelText: "취소",
                          doneText: "삭제",
                          buttonColor: .colorF14C4C,
                          alertHeight: 140)
        alertViewController.configureAlert(with: alert)
        alertViewController.modalPresentationStyle = .overCurrentContext
        alertViewController.onDeleteTapped = {
            self.deleteSelectedLocations()
        }
        self.present(alertViewController, animated: false)
        
    }
    
    func checkButtonTapped(_ index: Int, isCheck: Bool) {
        if isCheck {
            selectedLocations.append(index)
        } else {
            if let index = selectedLocations.firstIndex(of: index) {
                selectedLocations.remove(at: index)
            }
        }
    }
    
    private func reloadTableView() {
        tableView.reloadData()
    }
    
    private func presentTimePicker(_ index: Int) {
        let timePickerViewController = TimePickerViewController()
        timePickerViewController.delegate = self
        timePickerViewController.selectedTime = locations[index].time
        timePickerViewController.modalPresentationStyle = .overFullScreen
        present(timePickerViewController, animated: false)
    }
    
    private func deleteSelectedLocations() {
        selectedLocations.sorted(by: >).forEach { index in
            if index < locations.count {
                locations.remove(at: index)
            }
        }
        selectedLocations = []
        reloadTableView()
    }
}

extension AddScheduleViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
