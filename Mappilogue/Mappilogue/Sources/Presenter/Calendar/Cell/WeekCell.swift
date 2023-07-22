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
    private var dummySchedule = dummyScheduleData()
    
    private var selectedDate: SelectedDate = SelectedDate(year: 0, month: 0)
    private var weekIndex: Int = 0
    private var week: [String] = []
    private var isCurrentMonth: Bool = true
    private var year: Int = 0
    private var month: Int = 0
    private var schedules: [Schedule] = []
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .colorF9F8F7
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(DayCell.self, forCellWithReuseIdentifier: DayCell.registerId)
        collectionView.register(ScheduleTitleCell.self, forCellWithReuseIdentifier: ScheduleTitleCell.registerId)
        collectionView.delegate = self
        collectionView.dataSource = self
       
        return collectionView
    }()
    
    private let stackView = UIStackView()
    
    override func setupProperty() {
        super.setupProperty()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 0
        
        createdayButton()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
    
        contentView.addSubview(collectionView)
        contentView.addSubview(stackView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(contentView)
        }
        
        stackView.snp.makeConstraints {
            $0.width.height.equalTo(contentView)
        }
    }
    
    func configure(year: Int, month: Int, weekIndex: Int) {
        selectedDate = SelectedDate(year: year, month: month)
        self.year = year
        self.month = month
        self.weekIndex = weekIndex
        week = monthlyCalendar.getWeek(year: year, month: month, weekIndex: weekIndex)
        collectionView.reloadData()
    }
    
    func getDaySchedule(year: Int, month: Int, day: Int) -> [Schedule] {
        if let index = dummySchedule.firstIndex(where: {$0.year == year && $0.month == month && $0.day == day}) {
            return dummySchedule[index].schedules
        }
        return []
    }
    
    func getPreviousDaySchedule(year: Int, month: Int, day: Int) -> [Schedule] {
        if week.contains(String(day-1)), let index = dummySchedule.firstIndex(where: {$0.year == year && $0.month == month && $0.day == day-1}) {
            return dummySchedule[index].schedules
        }
        return []
    }
    
    private func createdayButton() {
        for index in 0..<7 {
            let button = createButton(index)
            stackView.addArrangedSubview(button)
        }
    }
    
    private func createButton(_ index: Int) -> UIButton {
        let button = UIButton()
        button.tag = index
        button.addTarget(self, action: #selector(dayButtonTapped), for: .touchUpInside)
  
        return button
    }
    
    @objc private func dayButtonTapped(_ sender: UIButton) {
        NotificationCenter.default.post(name: Notification.Name("PresentScheduleViewController"), object: nil)
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
            schedules = getDaySchedule(year: year, month: month, day: Int(day) ?? 0)
            if schedules.count > indexPath.section-1 {
                var scheduleTitle = schedules[indexPath.section-1].title
                let scheduleColor = schedules[indexPath.section-1].color
                let previousDaySchedules = getPreviousDaySchedule(year: year, month: month, day: Int(day) ?? 0)
                if let _ = previousDaySchedules.firstIndex(where: {$0.title == scheduleTitle}) {
                    scheduleTitle = ""
                }
                
                cell.configure(with: scheduleTitle, color: scheduleColor)
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
    
    // section 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: section == 0 ? 1 : 3, right: 0)
    }
}
