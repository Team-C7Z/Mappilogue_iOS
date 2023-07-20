//
//  MonthlyCalendar.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/09.
//

import Foundation

struct MonthlyCalendar {
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
    
    mutating func getMonthlyCalendar(year: Int, month: Int) -> [[String]] {
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
    
    mutating func getWeekCount(year: Int, month: Int) -> Int {
        let weeks = getMonthlyCalendar(year: year, month: month)
        return weeks.count
    }
    
    mutating func getWeek(year: Int, month: Int, weekIndex: Int) -> [String] {
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
    
    mutating func getDays(year: Int, month: Int) -> [Int] {
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
}
