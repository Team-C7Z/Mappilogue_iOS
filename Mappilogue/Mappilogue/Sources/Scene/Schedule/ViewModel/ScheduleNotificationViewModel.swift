//
//  ScheduleNotificationViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/10/23.
//

import Foundation

class ScheduleNotificationViewModel {
    var calendarViewModel = CalendarViewModel()
    var onNotificationSelected: (([String]) -> Void)?
    
    var dates = ["7일 전", "3일 전", "이틀 전", "전날", "당일"]
    var beforDay = [7, 3, 2, 1, 0]
    var convertedDate: [String] = []
    var selectedBeforeDayIndex: Int = 0
    let hours = Array(1...12)
    var minutes = Array(0...59).map {String(format: "%02d", $0)}
    var timePeriod = ["AM", "PM"]
    var selectedTimePeriodIndex: Int = 0
    var isDate: Bool = false
    var selectedNotification = SelectedNotification()
    var notificationList: [SelectedNotification] = []
    var alarmOptions: [String] = []
    
    func updateAlarmOptionsFromNotificationList() {
        notificationList.forEach {
            if let time = calendarViewModel.convertTimeIntToDate(
                hour: $0.hour ?? 0,
                minute: $0.minute ?? 0,
                timePeriod: $0.timePeriod ?? "AM"
            ) {
                let alarm = "\($0.notification ?? "")T\(time)"
                alarmOptions.append(alarm)
            }
        }
        
        onNotificationSelected?(alarmOptions)
    }
    
    func setCurrentDate() -> SelectedNotification {
        let todayDate = "당일 (\(calendarViewModel.currentMonth)월 \(calendarViewModel.currentDay)일)"
        let notification = calendarViewModel.setDateFormatter(date: SelectedDate(
            year: calendarViewModel.currentYear,
            month: calendarViewModel.currentMonth,
            day: calendarViewModel.currentDay)
        )?.formatToyyyyMMddDateString()
        return SelectedNotification(notification: notification, date: todayDate, hour: 9, minute: 0, timePeriod: "AM")
    }
    
    func setDateList() {
        selectedBeforeDayIndex = dates.count-1
        for index in dates.indices {
            let date = calendarViewModel.getDateBefore(beforeDay: beforDay[index])
            convertedDate.append(date)
            dates[index] += " (\(date.formatToMMddDateString()))"
        }
    }
    
    func addNotification() {
        notificationList.append(selectedNotification)
    }
    
    func updateSelectedNotification(row: Int) {
        if isDate {
            selectedNotification.notification = convertedDate[row]
            selectedNotification.date = dates[row]
            selectedBeforeDayIndex = row
        } else {
            selectedNotification.hour = hours[row]
        }
    }
    
    func updateSelectedNotificationMinute(row: Int) {
        selectedNotification.minute = Int(minutes[row]) ?? 0
    }
    
    func updateSelectedNotificationTimePeriod(row: Int) {
        selectedNotification.timePeriod = timePeriod[row]
        selectedTimePeriodIndex = row
    }
}
