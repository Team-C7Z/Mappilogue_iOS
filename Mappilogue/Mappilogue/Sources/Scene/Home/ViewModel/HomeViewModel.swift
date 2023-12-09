//
//  HomeViewModel.swift
//  Mappilogue
//
//  Created by hyemi on 12/9/23.
//

import Foundation

class HomeViewModel {
    let dummyTodayData = dummyTodayScheduleData(scheduleCount: 2)
    let dummyUpcomingData = dummyUpcomingScheduleData(scheduleCount: 0)
    var isScheduleExpanded = [Bool]()
    
    var selectedScheduleType: ScheduleType = .today
    var limitedUpcomingScheduleCount = 4
    
    init() {
        isScheduleExpanded = Array(repeating: true, count: dummyTodayData.count)
    }
    
}
