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

    var isStartDate: Bool = false
    let years: [Int] = Array(1970...2050)
    let months: [Int] = Array(1...12)
    var days: [Int] = []

    var locations: [LocationTime] = []
    var selectedLocations: [Int] = []
    var timeIndex: Int?
    var initialTime: String = "9:00 AM"
    var isDeleteMode: Bool = false
    
    var dragSectionIndex: Int = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorF9F8F7
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        collectionView.register(LocationTimeCell.self, forCellWithReuseIdentifier: LocationTimeCell.registerId)
        collectionView.register(AddScheduleHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: AddScheduleHeaderView.registerId)
        collectionView.register(ScheduleDateHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: ScheduleDateHeaderView.registerId)
        collectionView.register(DeleteLocationFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: DeleteLocationFooterView.registerId)
        collectionView.register(AddLocationFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AddLocationFooterView.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.dragDelegate = self
        collectionView.dropDelegate = self
        return collectionView
    }()
    
    private let datePickerOuterView = UIView()
    private let datePickerView = UIPickerView()
    
    var keyboardTap = UITapGestureRecognizer()
    var datePickerTap = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setCurrentDate()
        setSelectedDate()
        setKeyboardTap()
    }

    override func setupProperty() {
        super.setupProperty()
        
        setNavigationBar()
        
        datePickerOuterView.backgroundColor = .colorF5F3F0
        datePickerOuterView.isHidden = true
        datePickerView.backgroundColor = .colorF5F3F0
        datePickerView.delegate = self
        datePickerView.dataSource = self
        datePickerTap = UITapGestureRecognizer(target: self, action: #selector(dismissDatePicker))
        keyboardTap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(collectionView)
        view.addSubview(datePickerOuterView)
        datePickerOuterView.addSubview(datePickerView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    
        datePickerOuterView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(236)
        }
        
        datePickerView.snp.makeConstraints {
            $0.top.equalTo(datePickerOuterView).offset(5)
            $0.leading.equalTo(datePickerOuterView).offset(35)
            $0.trailing.equalTo(datePickerOuterView).offset(-33)
            $0.bottom.equalTo(datePickerOuterView).offset(-5)
        }
    }
    
    func setCurrentDate() {
        days = monthlyCalendar.getDays(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth)
        startDate = .init(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth, day: monthlyCalendar.currentDay)
        endDate = .init(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth, day: monthlyCalendar.currentDay)
    }
    
    func setNavigationBar() {
        title = "일정"
        setNavigationBarItems(imageName: "back", action: #selector(backButtonTapped), isLeft: true)
        setNavigationBarItems(imageName: "completion", action: #selector(completionButtonTapped), isLeft: false)
    }
    
    @objc func completionButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    func setSelectedDate() {
        func selectedRow(_ value: Int, component: Int) {
            datePickerView.selectRow(value, inComponent: component, animated: false)
        }
        
        selectedRow(years.firstIndex(of: isStartDate ? startDate.year : endDate.year) ?? 0, component: ComponentType.year.rawValue)
        selectedRow(months.firstIndex(of: isStartDate ? startDate.month : endDate.month) ?? 0, component: ComponentType.month.rawValue)

        if let day = isStartDate ? startDate.day : endDate.day, let currentDayIndex = days.firstIndex(of: day) {
            selectedRow(currentDayIndex, component: ComponentType.day.rawValue)
        }
    }
    
    func setKeyboardTap() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        view.addGestureRecognizer(keyboardTap)
     }
     
     @objc func keyboardWillHide(_ notification: Notification) {
         view.removeGestureRecognizer(keyboardTap)
     }
    
    func addDatePickerTapGesture() {
        view.addGestureRecognizer(datePickerTap)
    }
    
    func datePickerButtonTapped() {
        setSelectedDate()
        datePickerOuterView.isHidden = false
        datePickerView.reloadAllComponents()
        collectionView.reloadData()
    }
    
    @objc func dismissDatePicker(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        if location.y < datePickerOuterView.frame.minY {
            if !datePickerOuterView.isHidden {
                
            }
            datePickerOuterView.isHidden = true
            validateDateRange()
        }
        collectionView.reloadData()
        view.removeGestureRecognizer(datePickerTap)
    }
    
    func validateDateRange() {
        if daysBetween() < 0 {
            if isStartDate {
                endDate = SelectedDate(year: startDate.year, month: startDate.month, day: startDate.day ?? 0)
            } else {
                startDate = SelectedDate(year: endDate.year, month: endDate.month, day: endDate.day ?? 0)
            }
        }
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
        addLocationViewController.delegate = self
        present(addLocationViewController, animated: false)
    }
    
    func addLocation(_ location: Location) {
        
       
    }
}

extension AddScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return locations.isEmpty ? 1 : locations.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.isEmpty ? 0 : section == 0 ? 0 : locations[section-1].locationDetail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationTimeCell.registerId, for: indexPath) as? LocationTimeCell else { return UICollectionViewCell() }
        
        let location = locations[indexPath.section-1].locationDetail[indexPath.row]
        cell.configure(indexPath.row, schedule: location, isDeleteMode: isDeleteMode)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 96)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            switch indexPath.section {
            case 0:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AddScheduleHeaderView.registerId, for: indexPath) as! AddScheduleHeaderView
                configureHeaderView(headerView)
                return headerView
            default:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ScheduleDateHeaderView.registerId, for: indexPath) as! ScheduleDateHeaderView
                let date = locations[indexPath.section-1].date
                headerView.configure(date)
                return headerView
            }
        } else if kind == UICollectionView.elementKindSectionFooter {
            if !locations.isEmpty && indexPath.section == 0 {
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DeleteLocationFooterView.registerId, for: indexPath) as! DeleteLocationFooterView
                return footerView
            }
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AddLocationFooterView.registerId, for: indexPath) as! AddLocationFooterView
            footerView.onAddLocationButtonTapped = {
                self.showAddLocationController()
            }
            return footerView
        }
        return UICollectionReusableView()
    }
    
    func configureHeaderView(_ headerView: AddScheduleHeaderView) {
        headerView.configureDate(startDate: startDate, endDate: endDate)
        
        let dateButtonConfiguration = { isStartDate in
            self.validateDateRange()
            self.isStartDate = isStartDate
            self.datePickerButtonTapped()
        }
        
        headerView.onColorSelectionButtonTapped = {
            self.isColorSelection.toggle()
            self.collectionView.performBatchUpdates(nil, completion: nil)
        }
        headerView.onStartDateButtonTapped = {
            dateButtonConfiguration(true)
            self.addDatePickerTapGesture()
        }
        headerView.onEndDateButtonTapped = {
            dateButtonConfiguration(false)
            self.addDatePickerTapGesture()
        }
        headerView.onNotificationButtonTapped = { self.showNotificationViewController()}
        headerView.onRepeatButtonTapped = { self.showRepeatViewController() }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: section == 0 ? (isColorSelection ? 411 : 225) : locations.count > 1 ? 32 : 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: !locations.isEmpty && section == 0 ? 32 : 53 + 16)
    }
    
    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }

    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) { }
}

extension AddScheduleViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        dragSectionIndex = indexPath.section
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
}

extension AddScheduleViewController: UICollectionViewDropDelegate {
    func collectionView(_ collectionView: UICollectionView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UICollectionViewDropProposal {
        if session.localDragSession != nil && destinationIndexPath?.section == dragSectionIndex {
            return UICollectionViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UICollectionViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func collectionView(_ collectionView: UICollectionView, performDropWith coordinator: UICollectionViewDropCoordinator) {
        guard let destinationIndexPath = coordinator.destinationIndexPath else {
            return
        }
        
        coordinator.items.forEach { dropItem in
            guard let sourceIndexPath = dropItem.sourceIndexPath else { return }
            
            if sourceIndexPath.section != destinationIndexPath.section {
                return
            }
                    
            var sourceLocation = self.locations[sourceIndexPath.section-1]
            var destinationLocation = self.locations[sourceIndexPath.section-1]
            
            collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
                
                let moveLocation = sourceLocation.locationDetail[sourceIndexPath.row]
                sourceLocation.locationDetail.remove(at: sourceIndexPath.row)
                destinationLocation.locationDetail.insert(moveLocation, at: destinationIndexPath.row)
            }, completion: { _ in
                coordinator.drop(dropItem.dragItem, toItemAt: destinationIndexPath)
          //      DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0) {
                    collectionView.reloadData()
                }
          //  }
            )
        }
        
    }
}

extension AddScheduleViewController: SelectedLocationDelegate, TimeButtonDelegate, SelectedTimeDelegate, DeleteModeDelegate, DeleteLocationDelegate, CheckLocationDelegate {
    func selectLocation(_ location: Location) {
        guard let startDate = setDateFormatter(date: startDate), let endDate = setDateFormatter(date: endDate) else { return }
        var dates: [String] = []
        var currentDate = startDate
        dates.append(currentDate.formatDateToString())
   
        while currentDate.formatDateToString() != endDate.formatDateToString() {
            guard let newDate = Calendar.current.date(byAdding: .day, value: 1, to: currentDate) else { return }
            currentDate = newDate
            dates.append(currentDate.formatDateToString())
        }
        
        for date in dates {
            let locationTime = LocationTimeDetail(location: location.title, time: initialTime)
            if let index = locations.firstIndex(where: {$0.date == date}) {
                locations[index].locationDetail.append(locationTime)
            } else {
                locations.append(LocationTime(date: date, locationDetail: [locationTime]))
            }
        }
  
        collectionView.reloadData()
    }
    
    func getDateBetween(startDate: Date, endDate: Date) {
        var dates: [Date] = []
        var currentDate = startDate
        
        while startDate <= endDate {
            dates.append(currentDate)
            
            guard let newDate = Calendar.current.date(bySetting: .day, value: 1, of: currentDate) else { break }
            currentDate = newDate
        }
        
       print(dates)
    }
    
    func timeButtonTapped(_ index: Int) {
        timeIndex = index
        presentTimePicker(index)
    }
    
    func selectTime(_ selectedTime: String?) {
        guard let selectedTime = selectedTime else { return }
        let time = formatTime(selectedTime)
        guard let index = timeIndex else { return }
     //   locations[index].time = time
        reloadTableView()
    }
    
    private func formatTime(_ time: String) -> String {
        return time.replacingOccurrences(of: "오전", with: "AM").replacingOccurrences(of: "오후", with: "PM")
    }
    
    func switchDeleteMode(_ isDeleteMode: Bool) {
        self.isDeleteMode = isDeleteMode
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
//        let timePickerViewController = TimePickerViewController()
//        timePickerViewController.delegate = self
//        timePickerViewController.selectedTime = locations[index].time
//        timePickerViewController.modalPresentationStyle = .overFullScreen
//        present(timePickerViewController, animated: false)
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
        guard let componentType = ComponentType(rawValue: component) else { return 0 }
        
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
            if isStartDate {
                if startDate.year == years[row] { return "\(years[row]) 년" }
            } else {
                if endDate.year == years[row] { return "\(years[row]) 년" }
            }
            return "\(years[row])"
            
        case .month:
            if isStartDate {
                if startDate.month == months[row] { return "\(months[row]) 월" }
            } else {
                if endDate.month == months[row] { return "\(months[row]) 월" }
            }
            return "\(months[row])"
   
        case .day:
            if isStartDate {
                if startDate.day == days[row] { return "\(days[row]) 일" }
            } else {
                if endDate.day == days[row] { return "\(days[row]) 일" }
            }
            return "\(days[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let componentType = ComponentType(rawValue: component) else { return }
        switch componentType {
        case .year:
            if isStartDate {
                startDate.year = years[row]
            } else { endDate.year = years[row] }
            
        case .month:
            if isStartDate {
                startDate.month = months[row]
            } else { endDate.month = months[row] }
        
        case .day:
            if isStartDate {
                startDate.day = days[row]
            } else { endDate.day = days[row] }
        }
        
        updateDaysComponent(isStartDate ? startDate : endDate)
    }
    
    private func updateDaysComponent(_ selectedDate: SelectedDate) {
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
