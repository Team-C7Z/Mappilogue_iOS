//
//  NotificationViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/15.
//

import UIKit

struct SelectedNotification {
    var notification: String?
    var date: String?
    var hour: Int?
    var minute: Int?
    var timePeriod: String?
}

class NotificationViewController: BaseViewController {
    private var monthlyCalendar = CalendarViewModel()
    var onNotificationSelected: (([String]) -> Void)?
    
    var dates = ["7일 전", "3일 전", "이틀 전", "전날", "당일"]
    var beforDay = [7, 3, 2, 1, 0]
    var convertedDate: [String] = []
    var selectedBeforeDayIndex: Int = 0
    let hours = Array(1...12)
    var minutes = Array(0...59).map {String(format: "%02d", $0)}
    var timePeriod = ["AM", "PM"]
    var selectedTimePeriodIndex: Int = 0
    var isDate: Bool = false
    var selectedNotification = SelectedNotification()
    var notificationList: [SelectedNotification] = []
    var alarmOptions: [String] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView.backgroundColor = .grayF9F8F7
        collectionView.register(SelectedNotificationCell.self, forCellWithReuseIdentifier: SelectedNotificationCell.registerId)
        collectionView.register(NotificationHeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NotificationHeaderView.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let pickerOuterView = UIView()
    private let pickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        selectedNotification = setCurrentDate()
        setDateList()
        setSelectedDate()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationTitleAndBackButton("알림", backButtonAction: #selector(popToAddScheduleViewController))
        
        pickerOuterView.backgroundColor = .grayF5F3F0
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerOuterView.isHidden = true
        
        setDatePickerTapGesture()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
 
        view.addSubview(collectionView)
        view.addSubview(pickerOuterView)
        pickerOuterView.addSubview(pickerView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        pickerOuterView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(236)
        }

        pickerView.snp.makeConstraints {
            $0.top.equalTo(pickerOuterView).offset(8)
            $0.bottom.equalTo(pickerOuterView).offset(-8)
            $0.centerX.equalTo(pickerOuterView)
            $0.width.equalTo(240)
        }
    }
    
    @objc func popToAddScheduleViewController() {
        notificationList.forEach {
            if let time = monthlyCalendar.convertTimeIntToDate(
                hour: $0.hour ?? 0,
                minute: $0.minute ?? 0,
                timePeriod: $0.timePeriod ?? "AM"
            ) {
                let alarm = "\($0.notification ?? "")T\(time)"
                alarmOptions.append(alarm)
            }
        }
        
        onNotificationSelected?(alarmOptions)
        navigationController?.popViewController(animated: true)
    }
    
    func setCurrentDate() -> SelectedNotification {
        let todayDate = "당일 (\(monthlyCalendar.currentMonth)월 \(monthlyCalendar.currentDay)일)"
        let notification = monthlyCalendar.convertIntToDate(
            year: monthlyCalendar.currentYear,
            month: monthlyCalendar.currentMonth,
            day: monthlyCalendar.currentDay
        )?.formatToyyyyMMddDateString()
        return SelectedNotification(notification: notification, date: todayDate, hour: 9, minute: 0, timePeriod: "AM")
    }
    
    func setDateList() {
        selectedBeforeDayIndex = dates.count-1
        for index in dates.indices {
            let date = monthlyCalendar.getDateBefore(beforeDay: beforDay[index])
            convertedDate.append(date)
            dates[index] += " (\(date.formatToMMddDateString()))"
        }
    }
    
    func setSelectedDate() {
        pickerView.reloadAllComponents()
        if isDate {
            pickerView.selectRow(selectedBeforeDayIndex, inComponent: 0, animated: false)
        } else {
            guard let hour = selectedNotification.hour else { return }
            guard let minute = selectedNotification.minute else { return }
            
            pickerView.selectRow(hour-1, inComponent: 0, animated: false)
            pickerView.selectRow(minute, inComponent: 1, animated: false)
            pickerView.selectRow(selectedTimePeriodIndex, inComponent: 2, animated: false)
        }
    }
    
    func setDatePickerTapGesture() {
        let datePickerTap = UITapGestureRecognizer(target: self, action: #selector(dismissDatePicker))
        view.addGestureRecognizer(datePickerTap)
    }
    
    func showPickerView(_ isDate: Bool) {
        self.isDate = isDate
        pickerOuterView.isHidden = false
        setSelectedDate()
    }
    
    @objc func dismissDatePicker(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: collectionView)
        if location.y < pickerOuterView.frame.minY {
            pickerOuterView.isHidden = true
            collectionView.reloadData()
        }
    }
    
    func addNotification() {
        notificationList.append(selectedNotification)
        collectionView.reloadData()
    }
}

extension NotificationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notificationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedNotificationCell.registerId, for: indexPath) as? SelectedNotificationCell else { return UICollectionViewCell() }
        
        let date = notificationList[indexPath.row]
        cell.configure(indexPath.row, date: date)
        
        cell.onDeleteButtonTapped = { index in
            self.notificationList.remove(at: index)
            collectionView.reloadData()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width - 32, height: 56)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: NotificationHeaderView.registerId, for: indexPath) as? NotificationHeaderView else { return UICollectionReusableView() }
    
        headerView.configure(selectedNotification)
        headerView.onStartDateButtonTapped = { self.showPickerView(true) }
        headerView.onStartTimeButtonTapped = { self.showPickerView(false) }
        headerView.onAddNotificationButtonTapped = { self.addNotification() }
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 140)
    }
    
    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension NotificationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return isDate ? 1 : 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return isDate ? dates.count : hours.count
        case 1:
            return minutes.count
        default:
            return timePeriod.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return isDate ? "\(dates[row])" : "\(hours[row])"
        case 1:
            return "\(minutes[row])"
        default:
            return "\(timePeriod[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            if isDate {
                selectedNotification.notification = convertedDate[row]
                selectedNotification.date = dates[row]
                selectedBeforeDayIndex = row
            } else {
                selectedNotification.hour = hours[row]
            }
        case 1:
            selectedNotification.minute = Int(minutes[row]) ?? 0
        default:
            selectedNotification.timePeriod = timePeriod[row]
            selectedTimePeriodIndex = row
        }
    }
}
