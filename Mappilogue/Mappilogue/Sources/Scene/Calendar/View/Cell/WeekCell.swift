//
//  WeekCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/11.
//

import UIKit

struct ScheduleTitle {
    var id: Int
    var title: String
    var color: UIColor
    var dayCount: Int?
}

class WeekCell: BaseCollectionViewCell {
    static let registerId = "\(WeekCell.self)"
    
    var preMonthScheduleList: [[ScheduleTitle?]] = Array(repeating: Array(repeating: nil, count: 10), count: 32)
    var currentMonthScheduleList: [[ScheduleTitle?]] = Array(repeating: Array(repeating: nil, count: 10), count: 32)
    var nextMonthScheduleList: [[ScheduleTitle?]] = Array(repeating: Array(repeating: nil, count: 10), count: 32)
    private var monthlyCalendar = MonthlyCalendar()
    private var dummySchedule = dummyScheduleData()
    private var dummySchedule2222 = dummyScheduleData12()
    
    private var selectedDate: SelectedDate = SelectedDate(year: 0, month: 0)
    private var weekIndex: Int = 0
    private var week: [String] = []
    private var days: [String] = []
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
       //contentView.addSubview(stackView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints {
            $0.top.leading.trailing.bottom.equalTo(contentView)
        }
        
//        stackView.snp.makeConstraints {
//            $0.width.height.equalTo(contentView)
//        }
    }
    
    func configure(year: Int, month: Int, weekIndex: Int) {
        selectedDate = SelectedDate(year: year, month: month)
        self.year = year
        self.month = month
        self.weekIndex = weekIndex
        preMonthScheduleList = Array(repeating: Array(repeating: nil, count: 10), count: 32)
        currentMonthScheduleList = Array(repeating: Array(repeating: nil, count: 10), count: 32)
        nextMonthScheduleList = Array(repeating: Array(repeating: nil, count: 10), count: 32)
        days = monthlyCalendar.getMonthlyCalendar(year: year, month: month).reduce([], +)
        week = monthlyCalendar.getWeek(year: year, month: month, weekIndex: weekIndex)
        getDaySchedule111()
        collectionView.reloadData()
    }
    
    func getDaySchedule111() {
        for schedule in dummySchedule2222 {
           
            guard let dates = monthlyCalendar.datesBetween(startDate: schedule.startDate, endDate: schedule.endDate) else { return }
            
            var index = 0
            for (dateIndex, date) in dates.enumerated() {
                guard let day = monthlyCalendar.dayFromDate(date) else { return }
                let dayCount = 0
                switch monthlyCalendar.compareDateToCurrentMonth(selectedDate: selectedDate, date: date) {
                case .lastMonth:
                    while preMonthScheduleList[day][index] != nil && index < 2 {
                        index += 1
                    }
                    
                    guard let firstDay = days.first else { return }
                    if firstDay == String(day) || dateIndex == 0 {
                        preMonthScheduleList[day][index] = ScheduleTitle(id: schedule.id, title: schedule.title, color: schedule.color, dayCount: min(dates.count, monthlyCalendar.lastMonthRange))
                    } else {
                        preMonthScheduleList[day][index] = ScheduleTitle(id: schedule.id, title: "", color: schedule.color, dayCount: nil)
                    }
                    
                case .currentMonth:
                    if (day + monthlyCalendar.lastMonthRange - 1) % 7 == 0 {
                        index = 0
                    }
                    
                    while currentMonthScheduleList[day][index] != nil && index < 2 {
                        index += 1
                    }
                    
                    if (day + monthlyCalendar.lastMonthRange - 1) % 7 == 0 ||  dateIndex == 0 {
                      //  currentMonthScheduleList[day][index] = ScheduleTitle(id: schedule.id, title: "", color: schedule.color, dayCount: dayCount)
                      //  print(schedule.title, (day + monthlyCalendar.lastMonthRange - 1), 33)
                 //   } else if dateIndex == 0 {
                 //       var dayCount = 7 - ((day + monthlyCalendar.lastMonthRange - 1) % 7)
                        currentMonthScheduleList[day][index] = ScheduleTitle(id: schedule.id, title: schedule.title, color: schedule.color, dayCount: dates.count)
                    } else {
                        currentMonthScheduleList[day][index] = ScheduleTitle(id: schedule.id, title: "", color: schedule.color, dayCount: nil)
                    }
             
                case .nextMonth:
                    while nextMonthScheduleList[day][index] != nil && index < 2 {
                        index += 1
                    }

                    if dateIndex == 0 {
                        nextMonthScheduleList[day][index] = ScheduleTitle(id: schedule.id, title: schedule.title, color: schedule.color, dayCount: min(date.count, monthlyCalendar.nextMonthRange))
                    } else {
                        nextMonthScheduleList[day][index] = ScheduleTitle(id: schedule.id, title: "", color: schedule.color, dayCount: 0)
                    }
                case .unknown:
                    break
                }

            }
        }
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
    
    @objc private func dayButtonTapped(_ button: UIButton) {
        let schedules = getDaySchedule(year: year, month: month, day: Int(week[button.tag]) ?? 0)
        let calendarSchedule = CalendarSchedule(year: year, month: month, day: Int(week[button.tag]) ?? 0, schedules: schedules)
        NotificationCenter.default.post(name: Notification.Name("PresentScheduleViewController"), object: calendarSchedule)
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
            
            let day = Int(week[indexPath.row]) ?? 0
          
            if weekIndex == 0 {
                if !monthlyCalendar.isLastMonth(indexPath.row) {
                    if let schedule = preMonthScheduleList[day][indexPath.section-1] {
                        cell.configure(with: schedule.title, color: schedule.color, scheduleCount: schedule.dayCount, row: indexPath.row)
                    }
                } else {
                    if let schedule = currentMonthScheduleList[day][indexPath.section-1] {
                        cell.configure(with: schedule.title, color: schedule.color, scheduleCount: schedule.dayCount, row: indexPath.row)
                    }
                }
            } else if weekIndex == monthlyCalendar.getWeekCount(year: selectedDate.year, month: selectedDate.month) - 1 {
                if !monthlyCalendar.isNextMonth(indexPath.row) {
                    if let schedule = nextMonthScheduleList[day][indexPath.section-1] {
                        cell.configure(with: schedule.title, color: schedule.color, scheduleCount: schedule.dayCount, row: indexPath.row)
                    }
                } else {
                    if let schedule = currentMonthScheduleList[day][indexPath.section-1] {
                        cell.configure(with: schedule.title, color: schedule.color, scheduleCount: schedule.dayCount, row: indexPath.row)
                    }
                }
            } else {
                if let schedule = currentMonthScheduleList[day][indexPath.section-1] {
                    cell.configure(with: schedule.title, color: schedule.color, scheduleCount: schedule.dayCount, row: indexPath.row)
             
                }
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let day = Int(week[indexPath.row]) ?? 0
        var width: CGFloat = collectionView.bounds.width / 7
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
