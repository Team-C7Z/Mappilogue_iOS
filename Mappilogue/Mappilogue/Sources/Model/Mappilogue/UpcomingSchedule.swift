//
//  UpcomingSchedule.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/30.
//

import Foundation

struct UpcomingSchedule {
    let title: String
    let date: String
    let time: String?
}

func dummyUpcomingScheduleData(scheduleCount: Int) -> [UpcomingSchedule] {
    var schedules = [UpcomingSchedule]()
    
    if scheduleCount == 0 {
        
    } else if scheduleCount == 1 {
        let schedule1 = UpcomingSchedule(title: "찬희랑 저녁 약속💗", date: "5월 13일", time: "6:00PM")
        
        schedules = [schedule1]
    } else {
        let schedule1 = UpcomingSchedule(title: "찬희랑 저녁 약속💗", date: "5월 13일", time: nil)
        let schedule2 = UpcomingSchedule(title: "말이 길어진다면 말줄임표로 대체해 주세요 이렇게이렇게", date: "5월 16일", time: "10:00PM")
        let schedule3 = UpcomingSchedule(title: "일정1", date: "5월 16일", time: nil)
        let schedule4 = UpcomingSchedule(title: "일정2", date: "5월 16일", time: "10:00PM")
        let schedule5 = UpcomingSchedule(title: "일정3", date: "5월 16일", time: "10:00PM")
        
        schedules = [schedule1, schedule2, schedule3, schedule4, schedule5]
    }
    
    return schedules
}
