//
//  WeekCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/11.
//

import UIKit

class WeekCell: BaseCollectionViewCell {
    static let registerId = "\(WeekCell.self)"
    
    private var monthlyCalendar = MonthlyCalendar()
    private var daySchedules = dummyCalendarScheduleData()
    
    var selectedDate = SelectedDate(year: 0, month: 0)
    var weekIndex: Int = 0
    var week: [String] = []
    var isCurrentMonth: Bool = true
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorFFFFFF
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.registerId)
        collectionView.register(ScheduleCell.self, forCellWithReuseIdentifier: ScheduleCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
       
        return collectionView
    }()

    private let lineView = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        lineView.backgroundColor = .colorEAE6E1
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
    
        contentView.addSubview(collectionView)
        contentView.addSubview(lineView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView)
            $0.bottom.equalTo(contentView).offset(-1)
        }
         
        lineView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(contentView)
            $0.height.equalTo(1)
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
            
            if weekIndex == monthlyCalendar.getWeekCount(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth) - 1 {
                isCurrentMonth = monthlyCalendar.isNextMonth(indexPath.row)
            }
            
            cell.configure(with: day, isCurrentMonth: isCurrentMonth, isSaturday: isSaturday, isSunday: isSunday, isToday: isToday)

            return cell
        default:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScheduleCell.registerId, for: indexPath) as? ScheduleCell else { return UICollectionViewCell() }
            
            let day = week[indexPath.row]
            if let schedules = daySchedules[day], schedules.count > indexPath.section - 1 {
                let schedule = schedules[indexPath.section-1].0
                let scheduleTitle = schedule.schedule
                let color = schedule.color
                
                var isScheduleContinuous: Bool = false
                
                if let day = Int(day), indexPath.row > 0,
                    let previousDaySchedules = daySchedules[String(day - 1)],
                   scheduleTitle == previousDaySchedules[indexPath.section-1].0.schedule {
                        isScheduleContinuous = true
                }
                
                let continuousDay = schedules[indexPath.section-1].1
                
                cell.configure(with: scheduleTitle, color: color, isScheduleContinuous: isScheduleContinuous, continuousDay: continuousDay)
            } 
            
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
}
