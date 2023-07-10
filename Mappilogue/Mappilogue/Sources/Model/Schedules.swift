//
//  CalendarSchedule.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/10.
//

import Foundation
import UIKit

struct CalendarSchedule {
    let daySchedule: [String: [Schedule]]
}

struct Schedule {
    let schedule: String
    let color: UIColor
}

func dummyCalendarScheduleData() -> [String: [Schedule]] {
    let schedule1 = Schedule(schedule: "미술관 가기", color: .colorE6C3F2)
    let schedule2 = Schedule(schedule: "홈트레이닝", color: .colorF0B4D5)
    let schedule3 = Schedule(schedule: "저녁 회의", color: .colorB2EAD6)
    let schedule4 = Schedule(schedule: "데이트", color: .colorF5DC82)
    
    let schedules: [String: [Schedule]] = [
        "9": [schedule4],
        "13": [schedule1, schedule2, schedule3, schedule4]
    ]
    
    return schedules
}
