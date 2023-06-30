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
    let time: String
}

func dummyUpcomingScheduleData(scheduleCount: Int) -> [UpcomingSchedule] {
    var schedules = [UpcomingSchedule]()
    
    if scheduleCount > 0 {
        let schedule1 = UpcomingSchedule(title: "찬희랑 저녁 약속💗", date: "5월 13일", time: "6:00PM")
        let schedule2 = UpcomingSchedule(title: "말이 길어진다면 말줄임표로 대체해 주세요 졸려죽게따", date: "5월 16일", time: "10:00PM")
        
        schedules = [schedule1, schedule2]
    }
    
    return schedules
}
