//
//  Schedule.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/19.
//

import Foundation
import UIKit

struct CalendarSchedule {
    var year: Int
    var month: Int
    var day: Int
    var schedules: [Schedule]
}

struct Schedule {
    var title: String = ""
    var color: UIColor?
    var time: String?
    var location: String?
}

func dummyScheduleData() -> [CalendarSchedule] {
    let calendarSchedule1 = CalendarSchedule(year: 2023, month: 7, day: 24, schedules: [
        Schedule(title: "미술관 가기", color: .colorE6C3F2, time: "1:00 PM", location: "국립현대미술관"),
        Schedule(title: "홈트레이닝", color: .colorF0B4D5, time: "4:00 PM", location: ""),
        Schedule(title: "저녁 회의", color: .colorB2EAD6, time: "8:00 PM", location: "스타벅스 논현점")
    ])
    let calendarSchedule2 = CalendarSchedule(year: 2023, month: 7, day: 16, schedules: [
        Schedule(title: "놀이공원", color: .colorBAD7FA, time: "3:00 PM", location: "잠실역")
    ])
    let calendarSchedule3 = CalendarSchedule(year: 2023, month: 8, day: 25, schedules: [
        Schedule(title: "부산여행", color: .colorF0F1B0, time: "3:00 PM", location: "잠실역")
    ])
    let calendarSchedule4 = CalendarSchedule(year: 2023, month: 8, day: 26, schedules: [
        Schedule(title: "부산여행", color: .colorF0F1B0, time: nil, location: "잠실역")
    ])
    let calendarSchedule5 = CalendarSchedule(year: 2023, month: 8, day: 27, schedules: [
        Schedule(title: "부산여행", color: .colorF0F1B0, time: nil, location: "잠실역")
    ])
    let calendarSchedule6 = CalendarSchedule(year: 2023, month: 8, day: 28, schedules: [
        Schedule(title: "부산여행", color: .colorF0F1B0, time: nil, location: "잠실역")
    ])

    return [calendarSchedule1, calendarSchedule2, calendarSchedule3, calendarSchedule4, calendarSchedule5, calendarSchedule6]
}
