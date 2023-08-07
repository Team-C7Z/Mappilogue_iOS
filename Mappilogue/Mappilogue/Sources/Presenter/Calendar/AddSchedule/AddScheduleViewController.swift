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
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorF9F8F7
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView.register(DeleteLocationCell.self, forCellWithReuseIdentifier: DeleteLocationCell.registerId)
        collectionView.register(AddScheduleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AddScheduleHeaderView.registerId)
        collectionView.register(AddLocationFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddLocationFooterView.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
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
        collectionView.addGestureRecognizer(keyboardTap)

        let datePickerTap = UITapGestureRecognizer(target: self, action: #selector(dismissDatePicker))
        collectionView.addGestureRecognizer(datePickerTap)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(collectionView)
        view.addSubview(startDatePickerOuterView)
        view.addSubview(endDatePickerOuterView)
        startDatePickerOuterView.addSubview(startDatePickerView)
        endDatePickerOuterView.addSubview(endDatePickerView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
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
        let location = gesture.location(in: collectionView)
        if !startDatePickerOuterView.isHidden && location.y < startDatePickerOuterView.frame.minY {
            startDatePickerOuterView.isHidden = true
            
            if daysBetween() < 0 {
                endDate = .init(year: startDate.year, month: startDate.month, day: startDate.day ?? 0)
            }
            
        } else if !endDatePickerOuterView.isHidden && location.y < endDatePickerOuterView.frame.minY {
            endDatePickerOuterView.isHidden = true
            
            if daysBetween() < 0 {
                startDate = .init(year: endDate.year, month: endDate.month, day: endDate.day ?? 0)
            }
        }
        collectionView.reloadData()
        setSelectedDate()
        startDatePickerView.reloadAllComponents()
        endDatePickerView.reloadAllComponents()
    }
    
    func startDateButtonTapped() {
        startDatePickerOuterView.isHidden = false
        endDatePickerOuterView.isHidden = true

        collectionView.reloadData()
        startDatePickerView.reloadAllComponents()
    }

    func endDateButtonTapped() {
        startDatePickerOuterView.isHidden = true
        endDatePickerOuterView.isHidden = false

        collectionView.reloadData()
        endDatePickerView.reloadAllComponents()
    }
    
    func showNotificationViewController() {
        let notificationViewController = NotificationViewController()
        navigationController?.pushViewController(notificationViewController, animated: true)
    }
    
    func showRepeatViewController() {
        let repeatViewController = RepeatViewController()
        navigationController?.pushViewController(repeatViewController, animated: true)
    }
    
    func showAddLocationController() {
        let addLocationViewController = AddLocationViewController()
        addLocationViewController.modalPresentationStyle = .overFullScreen
        present(addLocationViewController, animated: false)
    }
}

extension AddScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DeleteLocationCell.registerId, for: indexPath) as? DeleteLocationCell else { return UICollectionViewCell() }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: locations.isEmpty ? 0 : 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AddScheduleHeaderView.registerId, for: indexPath) as! AddScheduleHeaderView
            headerView.configureDate(startDate: startDate, endDate: endDate)
            headerView.onStartDateButtonTapped = {
                self.startDateButtonTapped()
            }
            headerView.onEndDateButtonTapped = {
                self.endDateButtonTapped()
            }
            headerView.onNotificationButtonTapped = {
                self.showNotificationViewController()
            }
            headerView.onRepeatButtonTapped = {
                self.showRepeatViewController()
            }
            return headerView
        } else if kind == UICollectionView.elementKindSectionFooter {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AddLocationFooterView.registerId, for: indexPath) as! AddLocationFooterView
            return footerView
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 225)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 53)
    }
    
    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

extension AddScheduleViewController: SelectedLocationDelegate, TimeButtonDelegate, SelectedTimeDelegate, DeleteModeDelegate, DeleteLocationDelegate, CheckLocationDelegate {
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
        alertViewController.onDoneTapped = {
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
