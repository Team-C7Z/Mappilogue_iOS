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
    var homeSchedules: HomeDTO?
    var isScheduleExpanded = [Bool]()
    
    var selectedScheduleType: ScheduleType = .today
    var limitedUpcomingScheduleCount = 4
    
    init() {
        isScheduleExpanded = Array(repeating: true, count: dummyTodayData.count)
    }
    
    func loadHomeData(option: String) {
        HomeManager.shared.getHome(option: option) { result in
            switch result {
            case .success(let response):
                guard let baseResponse = response as? BaseDTOResult<HomeDTO>, let result = baseResponse.result else { return }
                self.homeSchedules = result
                
            default:
                break
            }
        }
    }
}
