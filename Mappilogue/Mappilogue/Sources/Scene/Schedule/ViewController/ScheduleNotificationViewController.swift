//
//  ScheduleNotificationViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/15.
//

import UIKit

class ScheduleNotificationViewController: NavigationBarViewController {
    var viewModel = ScheduleNotificationViewModel()
    
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
        
        viewModel.selectedNotification = viewModel.setCurrentDate()
        viewModel.setDateList()
        viewModel.delegate = self
        setSelectedDate()
    }
    
    override func setupProperty() {
        super.setupProperty()
    
        setNavigationBar()
        
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
            $0.top.equalToSuperview().offset(88)
            $0.leading.bottom.trailing.equalToSuperview()
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
    
    private func setNavigationBar() {
        setPopBar(title: "알림")
        popBar.onPopButtonTapped = { [weak self] in
            guard let self = self else { return }
            
            dismissViewController()
        }
    }
    
    func dismissViewController() {
        navigationController?.popViewController(animated: true)
        viewModel.updateAlarmOptionsFromNotificationList()
    }

    func setSelectedDate() {
        pickerView.reloadAllComponents()
        if viewModel.isDate {
            pickerView.selectRow(viewModel.selectedBeforeDayIndex, inComponent: 0, animated: false)
        } else {
            guard let hour = viewModel.selectedNotification.hour else { return }
            guard let minute = viewModel.selectedNotification.minute else { return }
            
            pickerView.selectRow(hour-1, inComponent: 0, animated: false)
            pickerView.selectRow(minute, inComponent: 1, animated: false)
            pickerView.selectRow(viewModel.selectedTimePeriodIndex, inComponent: 2, animated: false)
        }
    }
    
    func setDatePickerTapGesture() {
        let datePickerTap = UITapGestureRecognizer(target: self, action: #selector(dismissDatePicker))
        view.addGestureRecognizer(datePickerTap)
    }
    
    func showPickerView(_ isDate: Bool) {
        viewModel.isDate = isDate
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
    
}

extension ScheduleNotificationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.notificationList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedNotificationCell.registerId, for: indexPath) as? SelectedNotificationCell else { return UICollectionViewCell() }
        
        let date = viewModel.notificationList[indexPath.row]
        cell.configure(indexPath.row, date: date)
        
        cell.onDeleteButtonTapped = { [weak self] index in
            guard let self = self else { return }
            
            viewModel.notificationList.remove(at: index)
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
    
        headerView.configure(viewModel.selectedNotification)
        
        headerView.onStartDateButtonTapped = { [weak self] in
            guard let self = self else { return }
            
            showPickerView(true)
        }
        
        headerView.onStartTimeButtonTapped = { [weak self] in
            guard let self = self else { return }
            
            showPickerView(false)
        }
        
        headerView.onAddNotificationButtonTapped = { [weak self] in
            guard let self = self else { return }
            
            viewModel.addNotification()
        }
        
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

extension ScheduleNotificationViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return viewModel.isDate ? 1 : 3
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return viewModel.isDate ? viewModel.dates.count : viewModel.hours.count
        case 1:
            return viewModel.minutes.count
        default:
            return viewModel.timePeriod.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return viewModel.isDate ? "\(viewModel.dates[row])" : "\(viewModel.hours[row])"
        case 1:
            return "\(viewModel.minutes[row])"
        default:
            return "\(viewModel.timePeriod[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            viewModel.updateSelectedNotification(row: row)
        case 1:
            viewModel.updateSelectedNotificationMinute(row: row)
        default:
            viewModel.updateSelectedNotificationTimePeriod(row: row)
        }
    }
}

extension ScheduleNotificationViewController: AddNotificationDelegate {
    func reloadView() {
        collectionView.reloadData()
    }
}
