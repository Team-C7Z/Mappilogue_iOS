//
//  CalendarCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/20.
//

import UIKit

class CalendarCell: BaseCollectionViewCell {
    static let registerId = "\(CalendarCell.self)"
    
    private var monthlyCalendar = MonthlyCalendar()
    private var selectedDate: SelectedDate?
    private var weekCount: Int = 0
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorFFFFFF
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(WeekdayCell.self, forCellWithReuseIdentifier: WeekdayCell.registerId)
        collectionView.register(WeekCell.self, forCellWithReuseIdentifier: WeekCell.registerId)
        collectionView.register(LineCell.self, forCellWithReuseIdentifier: LineCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func setupProperty() {
        super.setupProperty()
        
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
    
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(contentView)
        }
    }
    
    func configure(with date: SelectedDate) {
        selectedDate = date
        setCalendarDate()
    }
    
    func setCalendarDate() {
        guard let year = selectedDate?.year else { return }
        guard let month = selectedDate?.month else { return }
        weekCount = monthlyCalendar.getWeekCount(year: year, month: month)
        
        collectionView.reloadData()
    }
}

extension CalendarCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1 + weekCount
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return monthlyCalendar.weekday.count
        default:
            return 2
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekdayCell.registerId, for: indexPath) as? WeekdayCell else { return UICollectionViewCell() }
            
            let weekday = monthlyCalendar.weekday[indexPath.row]
            let isSaturday = monthlyCalendar.isSaturday(weekday)
            let isSunday = monthlyCalendar.isSunday(weekday)
            
            cell.configure(with: weekday, isSaturday: isSaturday, isSunday: isSunday)
            
            return cell
        default:
            switch indexPath.row {
            case 0:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeekCell.registerId, for: indexPath) as? WeekCell else { return UICollectionViewCell() }
                // cell.delegate = self
                print(selectedDate)
                if let year = selectedDate?.year, let month = selectedDate?.month {
                    cell.configure(year: year, month: month, weekIndex: indexPath.section-1)
                }
                
                return cell
            default:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LineCell.registerId, for: indexPath) as? LineCell else { return UICollectionViewCell() }
                
                return cell
            }
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat
        var height: CGFloat
        
        switch indexPath.section {
        case 0:
            width = (collectionView.bounds.width - 32) / 7
            height = 31
        default:
            switch indexPath.row {
            case 0:
                width = collectionView.bounds.width - 32
                let collectionViewHeight = collectionView.bounds.height - 31 - CGFloat(weekCount)
                let cellHeight = CGFloat(weekCount)
                height = collectionViewHeight / cellHeight
            default:
                width = collectionView.bounds.width
                height = 1
            }
        }
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: section == 0 ? 16 : 0, bottom: 0, right: section == 0 ? 16 : 0)
    }
    
    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
//
//extension CalendarCell: ScheduleViewControllerDelegate {
//    func presentScheduleViewController(in cell: WeekCell) {
//        addScheduleButton.isHidden = true
//
//        let scheduleViewController = ScheduleViewController()
//        scheduleViewController.dismissDelegate = self
//        scheduleViewController.presentDelegate = self
//        scheduleViewController.modalPresentationStyle = .overFullScreen
//        present(scheduleViewController, animated: false)
//    }
//}