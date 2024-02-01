//
//  MonthlyCalendar.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/09.
//

import Foundation
import Combine

class CalendarViewModel {
    @Published var calendarResult: CalendarDTO?
   
    var cancellables: Set<AnyCancellable> = []
    private let calendarManager = CalendarManager()
    
    var selectedDate: SelectedDate = SelectedDate(year: 0, month: 0)
    var calendarSchedules: [CalendarSchedules] = []
    var dotDates = Array(repeating: [Int](), count: 3)
    var scheduleId: Int?
    var currentPage = 1
    
    let weekday: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    
    var lastMonthRange: Int = 0
    var nextMonthRange: Int = 0
    
    var currentYear: Int {
        Calendar.current.component(.year, from: Date())
    }
    
    var currentMonth: Int {
        Calendar.current.component(.month, from: Date())
    }
    
    var currentDay: Int {
        Calendar.current.component(.day, from: Date())
    }
    
    func getMonthlyCalendar(year: Int, month: Int) -> [[String]] {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        
        var weeks: [[String]] = []
        var days: [String] = []
        
        // 월의 첫 번째 날 가져오기
        let startDateComponents = DateComponents(year: year, month: month, day: 1)
        guard let startDate = calendar.date(from: startDateComponents) else {
            return weeks
        }
        
        // 월의 마지막 날 가져오기
        guard let range = calendar.range(of: .day, in: .month, for: startDate) else {
            return weeks
        }
        let endDate = calendar.date(byAdding: .day, value: range.count - 1, to: startDate)!
        
        // 이전 달의 마지막 날 가져오기
        let previousMonth = calendar.date(byAdding: .month, value: -1, to: startDate)!
        guard let previousRange = calendar.range(of: .day, in: .month, for: previousMonth) else {
            return weeks
        }
        let previousMonthEndDate = calendar.date(byAdding: .day, value: previousRange.count - 1, to: previousMonth)!
        
        // 다음 달의 첫 번째 날 가져오기
        let nextMonth = calendar.date(byAdding: .month, value: 1, to: startDate)!
        guard let nextMonthStartDate = calendar.date(from: calendar.dateComponents([.year, .month], from: nextMonth)) else {
            return []
        }
        
        // 첫 번째 날 이전의 지난 달 날짜
        let firstWeekday = calendar.component(.weekday, from: startDate)
        let emptyFirstWeekRange = (firstWeekday - calendar.firstWeekday + 7) % 7
        lastMonthRange = emptyFirstWeekRange
        
        var previousMonthDate = previousMonthEndDate
        for _ in 0..<emptyFirstWeekRange {
            let day = dateFormatter.string(from: previousMonthDate)
            days.insert(day, at: 0)
            previousMonthDate = calendar.date(byAdding: .day, value: -1, to: previousMonthDate)!
        }
        
        // 이번 달 날짜
        var currentDate = startDate
        while currentDate <= endDate {
            let day = dateFormatter.string(from: currentDate)
            days.append(day)
            
            // 다음 날로 이동
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
            
            if calendar.component(.weekday, from: currentDate) == calendar.firstWeekday {
                weeks.append(days)
                days = []
            }
        }
        
        // 마지막 주에 다음 달 날짜 출력
        let lastWeekday = calendar.component(.weekday, from: endDate)
        let emptyLastWeekRange = (calendar.firstWeekday + 6 - lastWeekday) % 7
        nextMonthRange = 7 - emptyLastWeekRange
        
        var nextMonthDate = nextMonthStartDate
        for _ in 0..<emptyLastWeekRange {
            let day = dateFormatter.string(from: nextMonthDate)
            days.append(day)
            nextMonthDate = calendar.date(byAdding: .day, value: 1, to: nextMonthDate)!
        }

        if !days.isEmpty {
            weeks.append(days)
        }
        return weeks
    }
    
    func getWeekCount(year: Int, month: Int) -> Int {
        let weeks = getMonthlyCalendar(year: year, month: month)
        return weeks.count
    }
    
    func getWeek(year: Int, month: Int, weekIndex: Int) -> [String] {
        let weeks = getMonthlyCalendar(year: year, month: month)
        let week = weeks[weekIndex]
        return week
    }
    
    func isSaturday(_ weekday: String) -> Bool {
        return weekday == "토"
    }
    
    func isSunday(_ weekday: String) -> Bool {
        return weekday == "일"
    }
    
    func isToday(year: Int, month: Int, day: String) -> Bool {
        return year == currentYear && month == currentMonth && day == String(currentDay)
    }

    func isLastMonth(_ row: Int) -> Bool {
        return row >= lastMonthRange
    }

    func isNextMonth(_ row: Int) -> Bool {
        return row < nextMonthRange
    }
    
    func getPreviousMonth() -> (year: Int, month: Int) {
        let calendar = Calendar.current
        let currentDate = Date()
        
        if let previousMonthDate = calendar.date(byAdding: .month, value: -1, to: currentDate) {
            let components = calendar.dateComponents([.year, .month], from: previousMonthDate)
            if let year = components.year, let month = components.month {
                return (year, month)
            }
        }
        
        return (currentYear, currentMonth)
    }
    
    func getNextMonth() -> (year: Int, month: Int) {
        let calendar = Calendar.current
        let currentDate = Date()
        
        if let previousMonthDate = calendar.date(byAdding: .month, value: 1, to: currentDate) {
            let components = calendar.dateComponents([.year, .month], from: previousMonthDate)
            if let year = components.year, let month = components.month {
                return (year, month)
            }
        }
        
        return (currentYear, currentMonth)
    }
    
    func changePreviousMonth(_ date: SelectedDate) -> SelectedDate {
        var newDate = date
        if date.month == 1 {
            newDate.year -= 1
            newDate.month = 12
        } else {
            newDate.month -= 1
        }
        return newDate
    }
    
    func changeNextMonth(_ date: SelectedDate) -> SelectedDate {
        var newDate = date
        if date.month == 12 {
            newDate.year += 1
            newDate.month = 1
        } else {
            newDate.month += 1
        }
        return newDate
    }
    
    func getDays(year: Int, month: Int) -> [Int] {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        
        var currentMonthDays: [String] = []
        
        // 월의 첫 번째 날 가져오기
        let startDateComponents = DateComponents(year: year, month: month, day: 1)
        guard let startDate = calendar.date(from: startDateComponents) else {
            return []
        }
        
        // 월의 마지막 날 가져오기
        guard let range = calendar.range(of: .day, in: .month, for: startDate) else {
            return []
        }
        let endDate = calendar.date(byAdding: .day, value: range.count - 1, to: startDate)!
        
        var currentDate = startDate
        while currentDate <= endDate {
            let day = dateFormatter.string(from: currentDate)
            currentMonthDays.append(day)
            
            // 다음 날로 이동
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
    
        return currentMonthDays.compactMap {Int($0)}
    }
    
    func getDateBefore(beforeDay: Int) -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
    
        let date = calendar.date(byAdding: .day, value: -beforeDay, to: Date())
        return dateFormatter.string(from: date!)
    }
    
    func datesBetween(startDate: String, endDate: String) -> [Date]? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let startDate = dateFormatter.date(from: startDate),
           let endDate = dateFormatter.date(from: endDate) {
            var dates: [Date] = []
            
            let calendar = Calendar.current
            var currentDate = startDate
            
            while currentDate <= endDate {
                dates.append(currentDate)
                currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
            }
            
            return dates
        } else {
            return nil
        }
    }
    
    func dayFromDate(_ date: String) -> Int? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: date) {
            let calendar = Calendar.current
            let day = calendar.component(.day, from: date)
            return day
        }
        return nil
    }
    
    func daysBetween(start: SelectedDate, end: SelectedDate) -> Int {
        let startDate = setDateFormatter(date: start)
        let endDate = setDateFormatter(date: end)
        if let start = startDate, let end = endDate, let daysDifference = daysBetweenDates(start: start, end: end) {
            return daysDifference
        }
        return 0
    }
    
    func setDateFormatter(date: SelectedDate) -> Date? {
        let calendar = Calendar.current
        
        var dateComponents = DateComponents()
        dateComponents.year = date.year
        dateComponents.month = date.month
        dateComponents.day = date.day
        
        guard let date = calendar.date(from: dateComponents) else {
            return nil
        }
        
        return date
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
    
    func convertTimeIntToDate(hour: Int, minute: Int, timePeriod: String) -> String? {
        var dateComponents = DateComponents()
        dateComponents.hour = timePeriod == "AM" ? hour : hour + 12
        dateComponents.minute = minute
        
        let calendar = Calendar.current
        if let date = calendar.date(from: dateComponents) {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            return dateFormatter.string(from: date)
        } else {
            return nil
        }
    }
    
    func convertStringToInt(date: String) -> SelectedDate {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일"
        
        if let convertedDate = dateFormatter.date(from: date) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: convertedDate)
            
            let date = SelectedDate(year: components.year ?? 0, month: components.month ?? 0, day: components.day)
            
            return date
        }
        return SelectedDate(year: 0, month: 0)
    }
    
    func compareDateToCurrentMonth(_ date: Date) -> MonthType {
        let calendar = Calendar.current
        let currentDate = Date()
        
        guard let selectedDate = setDateFormatter(date: selectedDate) else { return .unknown }
  
        let currentYear = calendar.component(.year, from: selectedDate)
        let currentMonth = calendar.component(.month, from: selectedDate)
        
        let targetYear = calendar.component(.year, from: date)
        let targetMonth = calendar.component(.month, from: date)
        
        if currentYear == targetYear && currentMonth == targetMonth {
            return .currentMonth
        } else if currentYear == targetYear && currentMonth - targetMonth == 1 {
            return .lastMonth
        } else if currentYear == targetYear && targetMonth - currentMonth == 1 {
            return .nextMonth
        } else if currentYear - targetYear == 1 && currentMonth == 1 && targetMonth == 12 {
            return .lastMonth
        } else if targetYear - currentYear == 1 && currentMonth == 12 && targetMonth == 1 {
            return .nextMonth
        } else {
            return .unknown
        }
    }
    
    func setCalendarDot() {
        var dateArr = Array(repeating: [Int](), count: 3)
        for schedule in calendarSchedules {
            guard let dates = datesBetween(startDate: schedule.startDate, endDate: schedule.endDate) else { return }
        
            for date in dates {
                switch compareDateToCurrentMonth(date) {
                case .currentMonth:
                    if let day = dayFromDate(date.formatToyyyyMMddDateString()) {
                        dateArr[1].append(day)
                    }
                case .lastMonth:
                    if let day = dayFromDate(date.formatToyyyyMMddDateString()) {
                        dateArr[0].append(day)
                    }
                case .nextMonth:
                    if let day = dayFromDate(date.formatToyyyyMMddDateString()) {
                        dateArr[2].append(day)
                    }
                case .unknown:
                    break
                }
            }
        }
      
        dotDates = dateArr
    }
}

enum MonthType: String, Codable {
    case lastMonth
    case currentMonth
    case nextMonth
    case unknown
}
