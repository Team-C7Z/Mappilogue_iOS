//
//  WeekCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/11.
//

import UIKit

class WeekCell: BaseCollectionViewCell {
    static let registerId = "\(WeekCell.self)"
    
    weak var delegate: ScheduleViewControllerDelegate?
    
    private var monthlyCalendar = MonthlyCalendar()
    
    var selectedDate: SelectedDate = SelectedDate(year: 0, month: 0)
    var weekIndex: Int = 0
    var week: [String] = []
    var isCurrentMonth: Bool = true
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorFFFFFF
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.registerId)
        collectionView.register(ScheduleTitleCell.self, forCellWithReuseIdentifier: ScheduleTitleCell.registerId)
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
            $0.top.leading.trailing.bottom.equalTo(contentView)
        }
    }
    
    func configure(year: Int, month: Int, weekIndex: Int) {
        selectedDate = SelectedDate(year: year, month: month)
        self.weekIndex = weekIndex
        week = monthlyCalendar.getWeek(year: year, month: month, weekIndex: weekIndex)
        collectionView.reloadData()
    }
}

extension WeekCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return week.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DayCell.registerId, for: indexPath) as? DayCell else { return UICollectionViewCell() }
    
            let day = week[indexPath.row]
            let isSaturday = indexPath.row == 6
            let isSunday = indexPath.row == 0
            let isToday = monthlyCalendar.isToday(year: selectedDate.year, month: selectedDate.month, day: day)
          
            if weekIndex == 0 {
                isCurrentMonth = monthlyCalendar.isLastMonth(indexPath.row)
            }
            
            if weekIndex == monthlyCalendar.getWeekCount(year: selectedDate.year, month: selectedDate.month) - 1 {
                isCurrentMonth = monthlyCalendar.isNextMonth(indexPath.row)
            }
            
            cell.configure(with: day, isCurrentMonth: isCurrentMonth, isSaturday: isSaturday, isSunday: isSunday, isToday: isToday)

            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleTitleCell.registerId, for: indexPath) as? ScheduleTitleCell else { return UICollectionViewCell() }
            
            let day = week[indexPath.row]
//                cell.configure(with: scheduleTitle, color: color, isScheduleContinuous: isScheduleContinuous, continuousDay: continuousDay)
//
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width / 7
        let height: CGFloat

        switch indexPath.section {
        case 0:
            height = 30
        default:
            height = 16
        }
        return CGSize(width: width, height: height)
    }

    // 수평 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    // 수직 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // section 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: section == 0 ? 1 : 3, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.presentScheduleViewController(in: self)
    }
}

protocol ScheduleViewControllerDelegate: AnyObject {
    func presentScheduleViewController(in cell: WeekCell)
}
