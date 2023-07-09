//
//  MonthlyCalendar.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/09.
//

import Foundation

struct MonthlyCalendar {
    var lastMonthDays: [String] = []
    var thisMonthDays: [String] = []
    var nextMonthDays: [String] = []
    
    var currentYear: Int {
        return Calendar.current.component(.year, from: Date())
    }
    
    var currentMonth: Int {
        return Calendar.current.component(.month, from: Date())
    }
    
    mutating func getMonthlyCalendar(year: Int, month: Int) -> [String] {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d"
        
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
        let emptyFirstWeek = (firstWeekday - calendar.firstWeekday + 7) % 7
        var previousMonthDate = previousMonthEndDate
        for _ in 0..<emptyFirstWeek {
            let day = dateFormatter.string(from: previousMonthDate)
            lastMonthDays.insert(day, at: 0)
            previousMonthDate = calendar.date(byAdding: .day, value: -1, to: previousMonthDate)!
        }

        // 이번 달 날짜 출력
        var currentDate = startDate
        while currentDate <= endDate {
            let day = dateFormatter.string(from: currentDate)
            thisMonthDays.append(day)
            
            // 다음 날로 이동
            currentDate = calendar.date(byAdding: .day, value: 1, to: currentDate)!
        }

        // 마지막 주에 다음 달 날짜 출력
        let lastWeekday = calendar.component(.weekday, from: endDate)
        let emptyLastWeek = (calendar.firstWeekday + 6 - lastWeekday) % 7
        var nextMonthDate = nextMonthStartDate
        for _ in 0..<emptyLastWeek {
            let day = dateFormatter.string(from: nextMonthDate)
            nextMonthDays.append(day)
            nextMonthDate = calendar.date(byAdding: .day, value: 1, to: nextMonthDate)!
        }

        return lastMonthDays + thisMonthDays + nextMonthDays
    }
    
    mutating func getCurrentMonthlyCalendar() -> [String] {
        return getMonthlyCalendar(year: currentYear, month: currentMonth)
    }
}
