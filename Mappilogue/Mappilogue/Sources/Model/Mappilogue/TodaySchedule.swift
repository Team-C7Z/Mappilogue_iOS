//
//  TodaySchedule.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/29.
//

import UIKit
import Foundation

struct TodaySchedule {
    let title: String
    let location: [String]
    let time: [String?]
    let color: UIColor
}

func dummyTodayScheduleData(scheduleCount: Int) -> [TodaySchedule] {
    var schedules = [TodaySchedule]()
    
    if scheduleCount == 0 {
        
    } else if scheduleCount == 1 {
        let schedule = TodaySchedule(title: "아빠랑 데이트 🏃🏻", location: ["춘배식당", "카페 문", "아주 건강해지는 제이슨 건강어쩌구어쩌구냠냠냠"], time: [nil, "10:00 AM", "1:00 PM"], color: .colorB1E9BE)
        schedules = [schedule]
    } else if scheduleCount == 2 {
        let schedule1 = TodaySchedule(title: "아빠랑 데이트 🏃🏻", location: ["춘배식당", "카페 문", "아주 건강해지는 제이슨 건강어쩌구어쩌구냠냠냠냠"], time: [nil, "10:00 AM", "1:00 PM"], color: .colorB1E9BE)
        let schedule2 = TodaySchedule(title: "러닝메이트 회의", location: ["공간대여 산", "에나 파스타"], time: ["3:00 PM", "6:00 PM"], color: .colorBAD7FA)
        
        schedules = [schedule1, schedule2]
    } else {
        let schedule1 = TodaySchedule(title: "아빠랑 데이트 🏃🏻", location: ["춘배식당", "카페 문", "아주 건강해지는 제이슨 건강어쩌구어쩌구냠냠냠냠"], time: [nil, "10:00 AM", "1:00 PM"], color: .colorB1E9BE)
        let schedule2 = TodaySchedule(title: "러닝메이트 회의", location: ["공간대여 산", "에나 파스타"], time: ["3:00 PM", "6:00 PM"], color: .colorBAD7FA)
        let schedule3 = TodaySchedule(title: "영화", location: ["메가박스", "에나 덮밥"], time: ["11:00 AM", "1:00 PM"], color: .colorF0F1B0)
        
        schedules = [schedule1, schedule2, schedule3]
    }
    
    return schedules
}
