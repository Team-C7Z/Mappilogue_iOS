//
//  MonthlyCalendar.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/09.
//

import Foundation

struct MonthlyCalendar {
    let weekday: [String] = ["일", "월", "화", "수", "목", "금", "토"]
    
    var thisMonthSaturday: [String] = []
    var thisMonthSunday: [String] = []
    
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
    
    mutating func getMonthlyCalendar(year: Int, month: Int) -> [String] {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        
        var days: [String] = []
        
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
        
        // 이전 달의 마지막 날 가져오기
        let previousMonth = calendar.date(byAdding: .month, value: -1, to: startDate)!
        guard let previousRange = calendar.range(of: .day, in: .month, for: previousMonth) else {
            return []
        }
        let previousMonthEndDate = calendar.date(byAdding: .day, value: previousRange.count - 1, to: previousMonth)!
        
        // 다음 달의 첫 번째 날 가져오기
        let nextMonth = calendar.date(byAdding: .month, value: 1, to: startDate)!
        guard let nextMonthStartDate = calendar.date(from: calendar.dateComponents([.year, .month], from: nextMonth)) else {
            return []
        }
        
        // 첫 번째 날 이전의 지난 달 날짜 출력
        let firstWeekday = calendar.component(.weekday, from: startDate)
        let emptyFirstWeekRange = (firstWeekday - calendar.firstWeekday + 7) % 7
        lastMonthRange = emptyFirstWeekRange
        
        var previousMonthDate = previousMonthEndDate
        for _ in 0..<emptyFirstWeekRange {
            let day = dateFormatter.string(from: previousMonthDate)
            days.insert(day, at: 0)
            previousMonthDate = calendar.date(byAdding: .day, value: -1, to: previousMonthDate)!
        }
        
        // 이번 달 날짜 출력
        var currentDate = startDate
        while currentDate <= endDate {
            let day = dateFormatter.string(from: currentDate)
            days.append(day)
            
            if calendar.component(.weekday, from: currentDate) == 7 {
                thisMonthSaturday.append(day)
            }
            
            if calendar.component(.weekday, from: currentDate) == 1 {
                thisMonthSunday.append(day)
            }
    
            // 다음 날로 이동
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }
        
        // 마지막 주에 다음 달 날짜 출력
        let lastWeekday = calendar.component(.weekday, from: endDate)
        let emptyLastWeekRange = (calendar.firstWeekday + 6 - lastWeekday) % 7
        nextMonthRange = days.count
        
        var nextMonthDate = nextMonthStartDate
        for _ in 0..<emptyLastWeekRange {
            let day = dateFormatter.string(from: nextMonthDate)
            days.append(day)
            nextMonthDate = calendar.date(byAdding: .day, value: 1, to: nextMonthDate)!
        }
        
        return days
    }
    
    func isSaturday(_ weekday: String) -> Bool {
        return weekday == "토"
    }
    
    func isSunday(_ weekday: String) -> Bool {
        return weekday == "일"
    }
    
    mutating func getThisMonthlyCalendar() -> [String] {
        return getMonthlyCalendar(year: currentYear, month: currentMonth)
    }
    
    func isCurrentMonth(_ row: Int) -> Bool {
        return row >= lastMonthRange && row < nextMonthRange
    }
    
    func isDaySaturday(_ day: String) -> Bool {
        return thisMonthSaturday.contains(day)
    }
    
    func isDaySunday(_ day: String) -> Bool {
        return thisMonthSunday.contains(day)
    }
}
