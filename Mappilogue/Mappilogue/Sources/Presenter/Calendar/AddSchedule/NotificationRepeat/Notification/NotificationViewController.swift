//
//  NotificationViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/15.
//

import UIKit

struct SelectedNotification {
    var date: String
    var hour: Int
    var minute: Int
}

class NotificationViewController: BaseViewController {
    private var monthlyCalendar = MonthlyCalendar()
    
    var dates = ["7일 전", "3일 전", "이틀 전", "전날", "당일"]
    var beforDay = [7, 3, 2, 1, 0]
    let hours = Array(1...12)
    let minutes = Array(0...59)
    var isDate: Bool = true
    var selectedNotification: SelectedNotification?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView.backgroundColor = .colorF9F8F7
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
        
        setDateList()
        setSelectedDate()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationBar("알림", backButtonAction: #selector(backButtonTapped))
        
        pickerOuterView.backgroundColor = .colorF5F3F0
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerOuterView.isHidden = true
        
        let datePickerTap = UITapGestureRecognizer(target: self, action: #selector(dismissDatePicker))
        view.addGestureRecognizer(datePickerTap)
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
            $0.top.equalTo(pickerOuterView).offset(6)
            $0.leading.equalTo(pickerOuterView).offset(40)
            $0.trailing.equalTo(pickerOuterView).offset(-40)
            $0.bottom.equalTo(pickerOuterView).offset(-8)
        }
    }
    
    func setDateList() {
        for index in dates.indices {
            dates[index] += " (\(monthlyCalendar.getDateBefore(beforeDay: beforDay[index])))"
        }
    }
    
    func setSelectedDate() {
        if isDate {
            pickerView.selectRow(dates.count-1, inComponent: 0, animated: true)
        }
    }
    
    @objc func dismissDatePicker(_ gesture: UITapGestureRecognizer) {
//        let location = gesture.location(in: collectionView)
//        if location.y < pickerOuterView.frame.minY {
//        }
//        collectionView.reloadData()
//        setSelectedDate()
//        startDatePickerView.reloadAllComponents()
//        endDatePickerView.reloadAllComponents()
    }
}

extension NotificationViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedNotificationCell.registerId, for: indexPath) as? SelectedNotificationCell else { return UICollectionViewCell() }
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
        headerView.onAddNotificationButtonTapped = {
            self.pickerOuterView.isHidden = false
        }
        return headerView
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 130)
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
        return isDate ? 1 : 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return isDate ? dates.count : hours.count
        default:
            return minutes.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return isDate ? "\(dates[row])" : "\(hours[row])"
        default:
            return "\(minutes[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            if isDate {
                selectedNotification?.date = dates[row]
            } else {
                selectedNotification?.hour = hours[row]
            }
        default:
            selectedNotification?.minute = minutes[row]
        }
    }
}
