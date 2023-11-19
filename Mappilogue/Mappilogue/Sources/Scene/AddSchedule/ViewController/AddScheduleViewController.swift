//
//  AddScheduleViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class AddScheduleViewController: BaseViewController {
    private var colorViewModel = ColorViewModel()
    private var scheduleViewModel = ScheduleViewModel()
    private var scheduleId: Int = 0
    private var monthlyCalendar = CalendarViewModel()
    private var selectedDate: SelectedDate = SelectedDate(year: 0, month: 0, day: 0)
    private var startDate: SelectedDate = SelectedDate(year: 0, month: 0, day: 0)
    private var endDate: SelectedDate  = SelectedDate(year: 0, month: 0, day: 0)

    var schedule = AddSchedule(colorId: -1, startDate: "", endDate: "")
    
    var colorList: [ColorListDTO] = []
    var isColorSelection: Bool = false
    var selectedColor: UIColor = .color1C1C1C

    var scheduleDateType: AddScheduleDateType = .unKnown
    let years: [Int] = Array(1970...2050)
    let months: [Int] = Array(1...12)
    var days: [Int] = []

    private var selectedDateIndex = 0
    var area: [Area] = []
    var selectedLocations: [IndexPath] = []
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
        collectionView.register(ScheduleDateFooterView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: ScheduleDateFooterView.registerId)
        collectionView.register(DeleteLocationHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DeleteLocationHeaderView.registerId)
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
 
        getColorList()
        setCurrentDate()
        setSelectedDate()
        setKeyboardTap()
        
        area = schedule.area ?? []
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
        setNavigationTitleAndItems(imageName: "common_dismiss", action: #selector(dismissButtonTapped), isLeft: true)
        setNavigationTitleAndItems(imageName: "common_completion", action: #selector(completionButtonTapped), isLeft: false)
    }
    
    @objc func dismissButtonTapped() {
        presentAlert()
    }
    
    private func presentAlert() {
        let alertViewController = AlertViewController()
        alertViewController.modalPresentationStyle = .overCurrentContext
        let alert = Alert(titleText: "일정 작성을 중단할까요?",
                          messageText: "저장하지 않은 일정은 사라져요",
                          cancelText: "취소",
                          doneText: "나가기",
                          buttonColor: .colorF14C4C,
                          alertHeight: 160)
        alertViewController.configureAlert(with: alert)
        alertViewController.onDoneTapped = {
            self.dismiss(animated: false) {
                self.navigationController?.popViewController(animated: true)
           }
        }
        present(alertViewController, animated: false)
    }
    
    @objc func completionButtonTapped(_ sender: UIButton) {
        schedule.startDate = startDate.stringFromSelectedDate()
        schedule.endDate = endDate.stringFromSelectedDate()
        if schedule.colorId == -1 {
            schedule.colorId = colorList.map({$0.id}).randomElement() ?? 0
        }
        
        schedule.area = area.isEmpty ? nil : area
        scheduleViewModel.addSchedule(schedule: schedule)
        
        navigationController?.popViewController(animated: true)
    }

    func setSelectedDate() {
        func selectedRow(_ value: Int, component: Int) {
            datePickerView.selectRow(value, inComponent: component, animated: false)
        }
        if scheduleDateType == .startDate {
            selectedRow(years.firstIndex(of: startDate.year) ?? 0, component: ComponentType.year.rawValue)
            selectedRow(months.firstIndex(of: startDate.month) ?? 0, component: ComponentType.month.rawValue)
        } else if scheduleDateType == .endDate {
            selectedRow(years.firstIndex(of: endDate.year) ?? 0, component: ComponentType.year.rawValue)
            selectedRow(months.firstIndex(of: endDate.month) ?? 0, component: ComponentType.month.rawValue)
        }

        if scheduleDateType == .startDate {
            if let day = startDate.day, let currentDayIndex = days.firstIndex(of: day) {
                selectedRow(currentDayIndex, component: ComponentType.day.rawValue)
            }
        } else if scheduleDateType == .endDate {
            if let day = endDate.day, let currentDayIndex = days.firstIndex(of: day) {
                selectedRow(currentDayIndex, component: ComponentType.day.rawValue)
            }
        }
        if scheduleDateType == .startDate {
            if let day = startDate.day, let currentDayIndex = days.firstIndex(of: day) {
                selectedRow(currentDayIndex, component: ComponentType.day.rawValue)
            }
        } else if scheduleDateType == .endDate {
            if let day = endDate.day, let currentDayIndex = days.firstIndex(of: day) {
                selectedRow(currentDayIndex, component: ComponentType.day.rawValue)
            }
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
            scheduleDateType = .unKnown
            datePickerOuterView.isHidden = true
            validateDateRange()
        }
        collectionView.reloadData()
        view.removeGestureRecognizer(datePickerTap)
    }
    
    func validateDateRange() {
        if daysBetween() < 0 {
            if scheduleDateType == .startDate {
                endDate = SelectedDate(year: startDate.year, month: startDate.month, day: startDate.day ?? 0)
            } else if scheduleDateType == .endDate {
                startDate = SelectedDate(year: endDate.year, month: endDate.month, day: endDate.day ?? 0)
            }
        }
    }

    func navigateToNotificationViewController() {
        let notificationViewController = NotificationViewController()
        notificationViewController.onNotificationSelected = { alarmOptions in
            self.schedule.alarmOptions = alarmOptions
        }
        navigationController?.pushViewController(notificationViewController, animated: true)
    }
    
    func presentRepeatViewController() {
        let repeatViewController = RepeatViewController()
        navigationController?.pushViewController(repeatViewController, animated: true)
    }
    
    func presentAddLocationController() {
        let addLocationViewController = AddLocationViewController()
        addLocationViewController.modalPresentationStyle = .overFullScreen
        addLocationViewController.onLocationSelected = { location in
            self.selectLocation(location)
        }
        present(addLocationViewController, animated: false)
    }
    
    func selectLocation(_ location: KakaoSearchPlaces) {
        let dateRange = getDatesInRange(startDate: startDate, endDate: endDate)
        for date in dateRange {
            addLocation(date: date, place: location)
        }
       
        collectionView.reloadData()
    }
    
    func addLocation(date: Date, place: KakaoSearchPlaces) {
        let location = AddSchduleLocation(
            name: place.placeName,
            streetAddress: place.addressName,
            latitude: place.lat.isEmpty ? nil : place.lat,
            longitude: place.long.isEmpty ? nil : place.long,
            time: initialTime
        )
  
        if let index = area.firstIndex(where: {$0.date == date.formatToMMddDateString()}) {
            area[index].value.append(location)
        } else {
            let schedule = Area(date: date.formatToyyyyMMddDateString(), value: [location])
            area.append(schedule)
        }
    }

    func presentTimePicker(indexPath: IndexPath) {
        let timePickerViewController = TimePickerViewController()
        let selectedTime = area[indexPath.section].value[indexPath.row].time
        timePickerViewController.selectedTime = (selectedTime == "설정 안 함" ? initialTime : selectedTime) ?? ""
        timePickerViewController.modalPresentationStyle = .overFullScreen
        timePickerViewController.onSelectedTime = { selectedTime in
            self.area[indexPath.section].value[indexPath.row].time = self.formatTime(selectedTime)
            self.collectionView.reloadData()
        }
        present(timePickerViewController, animated: false)
    }
    
    private func formatTime(_ time: String) -> String {
        return time.replacingOccurrences(of: "오전", with: "AM").replacingOccurrences(of: "오후", with: "PM")
    }
    
    private func checkButtonTapped(_ indexPath: IndexPath) {
        if let indexPath = selectedLocations.firstIndex(of: indexPath) {
            selectedLocations.remove(at: indexPath)
        } else {
            selectedLocations.append(indexPath)
        }
    }
    
    func presentDeleteLocationAlert() {
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
    
    private func deleteSelectedLocations() {
        selectedLocations.sorted(by: >).forEach { indexPath in
            if indexPath.section < area.count && indexPath.row < area[indexPath.section].value.count {
                area[indexPath.section].value.remove(at: indexPath.row)
            }
            if area[indexPath.section].value.isEmpty {
                area.remove(at: indexPath.section)
            }
        }
        selectedLocations = []
        collectionView.reloadData()
    }
}

extension AddScheduleViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return area.isEmpty ? 1 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return section == 0 ? 0 : area[selectedDateIndex].value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LocationTimeCell.registerId, for: indexPath) as? LocationTimeCell else { return UICollectionViewCell() }
        
        let location = area[selectedDateIndex].value[indexPath.row]
        cell.configure([selectedDateIndex, indexPath.row], schedule: location, isDeleteMode: isDeleteMode)

        cell.onSelectedLocation = { indexPath in
            self.checkButtonTapped(indexPath)
        }
        cell.onSelectedTime = { indexPath in
            self.presentTimePicker(indexPath: indexPath)
        }
        
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
                configureAddScheduleHeaderView(headerView)
                return headerView
            default:
                let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DeleteLocationHeaderView.registerId, for: indexPath) as! DeleteLocationHeaderView
                configureDeleteLocationHeaderView(headerView)
                return headerView
            }
        } else if kind == UICollectionView.elementKindSectionFooter {
            if !area.isEmpty && indexPath.section == 0 {
                let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ScheduleDateFooterView.registerId, for: indexPath) as! ScheduleDateFooterView
                footerView.configure(area)
                footerView.onDateTapped = { index in
                    self.selectedDateIndex = index
                    self.collectionView.reloadData()
                }
                return footerView
            }
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AddLocationFooterView.registerId, for: indexPath) as! AddLocationFooterView
            footerView.onAddLocationButtonTapped = {
                self.presentAddLocationController()
            }
            return footerView
        }
        return UICollectionReusableView()
    }

    func configureAddScheduleHeaderView(_ headerView: AddScheduleHeaderView) {
        headerView.configureDate(startDate: startDate, endDate: endDate, dateType: scheduleDateType)
        headerView.configureColorList(colorList)
        
        let dateButtonConfiguration = { isStartDate in
            self.validateDateRange()
            self.scheduleDateType = isStartDate
            self.datePickerButtonTapped()
        }
        
        headerView.onScheduleTitle = { title in
            self.schedule.title = title
        }
        
        headerView.onColorSelectionButtonTapped = {
            self.isColorSelection.toggle()
            self.collectionView.performBatchUpdates(nil, completion: nil)
        }
        
        headerView.onColorIndex = { colorId in
            self.schedule.colorId = colorId
            headerView.configureTitleColor(title: self.schedule.title ?? "", isColorSelection: self.isColorSelection, colorId: self.schedule.colorId)
        }
        
        headerView.onStartDateButtonTapped = { dateType in
            dateButtonConfiguration(dateType)
            self.addDatePickerTapGesture()
        }
        
        headerView.onEndDateButtonTapped = { dateType in
            dateButtonConfiguration(dateType)
            self.addDatePickerTapGesture()
        }
        
        headerView.onNotificationButtonTapped = { self.navigateToNotificationViewController()}
        headerView.onRepeatButtonTapped = { self.presentRepeatViewController() }
    }
    
    func configureDeleteLocationHeaderView(_ headerView: DeleteLocationHeaderView) {
        headerView.onDeleteMode = {
            self.isDeleteMode.toggle()
            self.collectionView.reloadData()
        }
        headerView.onDeleteLocation = {
            self.presentDeleteLocationAlert()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: section == 0 ? (isColorSelection ? 411 : 225) : 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: !area.isEmpty && section == 0 ? 72 : 53)
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
}

extension AddScheduleViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        if isDeleteMode {
            return []
        }
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
            
            collectionView.performBatchUpdates({
                collectionView.deleteItems(at: [sourceIndexPath])
                collectionView.insertItems(at: [destinationIndexPath])
                
                let moveLocation = area[sourceIndexPath.section-1].value[sourceIndexPath.row]
                area[sourceIndexPath.section-1].value.remove(at: sourceIndexPath.row)
                area[destinationIndexPath.section-1].value.insert(moveLocation, at: destinationIndexPath.row)
            }, completion: { _ in
                coordinator.drop(dropItem.dragItem, toItemAt: destinationIndexPath)
                    collectionView.reloadData()
                }
            )
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
            if scheduleDateType == .startDate {
                if startDate.year == years[row] { return "\(years[row]) 년" }
            } else if scheduleDateType == .endDate {
                if endDate.year == years[row] { return "\(years[row]) 년" }
            }
            return "\(years[row])"
            
        case .month:
            if scheduleDateType == .startDate {
                if startDate.month == months[row] { return "\(months[row]) 월" }
            } else if scheduleDateType == .endDate {
                if endDate.month == months[row] { return "\(months[row]) 월" }
            }
            return "\(months[row])"
   
        case .day:
            if scheduleDateType == .startDate {
                if startDate.day == days[row] { return "\(days[row]) 일" }
            } else if scheduleDateType == .endDate {
                if endDate.day == days[row] { return "\(days[row]) 일" }
            }
            return "\(days[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let componentType = ComponentType(rawValue: component) else { return }
        switch componentType {
        case .year:
            if scheduleDateType == .startDate {
                startDate.year = years[row]
            } else if scheduleDateType == .endDate {
                endDate.year = years[row]
            }
            
        case .month:
            if scheduleDateType == .startDate {
                startDate.month = months[row]
            } else if scheduleDateType == .endDate {
                endDate.month = months[row]
            }
        
        case .day:
            if scheduleDateType == .startDate {
                startDate.day = days[row]
            } else if scheduleDateType == .endDate {
                endDate.day = days[row]
            }
        }
        
        if scheduleDateType == .startDate {
            updateDaysComponent(startDate)
        } else if scheduleDateType == .endDate {
            updateDaysComponent(endDate)
        }
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
    
    func getDatesInRange(startDate: SelectedDate, endDate: SelectedDate) -> [Date] {
        let calendar = Calendar.current

        let start = calendar.date(from: DateComponents(year: startDate.year, month: startDate.month, day: startDate.day))!
        let end = calendar.date(from: DateComponents(year: endDate.year, month: endDate.month, day: endDate.day))!

        var dates: [Date] = []

        var currentDate = start

        while currentDate <= end {
            dates.append(currentDate)
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }

        return dates
    }
}

extension AddScheduleViewController {
    private func getColorList() {
        colorViewModel.getColorList()
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            } receiveValue: { response in
                guard let result = response.result else { return }

                self.colorList = result
                self.collectionView.reloadData()
            }
            .store(in: &colorViewModel.cancellables)
    }
}


