//
//  CalendarSchedule.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/10.
//

import Foundation
import UIKit

struct CalendarSchedule {
    let daySchedule: [String: [(Schedule, Int)]]
}

struct Schedule {
    let schedule: String
    let color: UIColor
}

func dummyCalendarScheduleData() -> [String: [(Schedule, Int)]] {
    let schedule1 = Schedule(schedule: "미술관 가기", color: .colorE6C3F2)
    let schedule2 = Schedule(schedule: "홈트레이닝", color: .colorF0B4D5)
    let schedule3 = Schedule(schedule: "저녁 회의", color: .colorB2EAD6)
    let schedule4 = Schedule(schedule: "데이트", color: .colorF5DC82)
    let schedule5 = Schedule(schedule: "부산 여행 🚙🚙🚙", color: .colorABD9F3)
    
    let schedules: [String: [(Schedule, Int)]] = [
        "9": [(schedule4, 1)],
        "13": [(schedule1, 1), (schedule2, 1), (schedule3, 1), (schedule4, 1)],
        "21": [(schedule5, 4)],
        "22": [(schedule5, 3)],
        "23": [(schedule5, 2)],
        "24": [(schedule5, 1)]
    ]
    
    return schedules
}
