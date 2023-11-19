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
    var image: [String]?
    var content: String?
    var category: String?
}

func dummyScheduleData() -> [CalendarSchedule] {
    let calendarSchedule1 = CalendarSchedule(year: 2023, month: 7, day: 24, schedules: [
        Schedule(title: "미술관 가기", color: .colorE6C3F2, time: "1:00 PM", location: "국립현대미술관"),
        Schedule(title: "홈트레이닝", color: .colorF0B4D5, time: "4:00 PM", location: ""),
        Schedule(title: "저녁 회의", color: .colorB2EAD6, time: "8:00 PM", location: "스타벅스 논현점")
    ])
    let calendarSchedule2 = CalendarSchedule(year: 2023, month: 7, day: 16, schedules: [
        Schedule(title: "놀이공원", color: .colorBAD7FA, time: "3:00 PM", location: "잠실역", category: "데이트")
    ])
    let calendarSchedule3 = CalendarSchedule(year: 2023, month: 8, day: 25, schedules: [
        Schedule(title: "부산여행", color: .colorF0F1B0, time: "3:00 PM", location: "부산역", image: ["recordTest1", "recordTest2", "recordTest3"], content: "제주 여행 마지막 날이다!\n아침부터 보이는 풍경이 너무 멋지다.", category: "여행")
    ])
    let calendarSchedule4 = CalendarSchedule(year: 2023, month: 8, day: 26, schedules: [
        Schedule(title: "부산여행", color: .colorF0F1B0, time: nil, location: "광안리", image: ["recordTest1"], content: "There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don't look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn't anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.", category: "여행")
    ])
    let calendarSchedule5 = CalendarSchedule(year: 2023, month: 8, day: 27, schedules: [
        Schedule(title: "부산여행", color: .colorF0F1B0, time: nil, location: "해운대", content: "냠냠")
    ])
    let calendarSchedule6 = CalendarSchedule(year: 2023, month: 8, day: 28, schedules: [
        Schedule(title: "부산여행", color: .colorF0F1B0, time: nil, location: "잠실역")
    ])

    return [calendarSchedule1, calendarSchedule2, calendarSchedule3, calendarSchedule4, calendarSchedule5, calendarSchedule6]
}

struct CalendarScheduleTitle {
    let title: String
    let color: UIColor
}

struct CalendarSchedule2 {
    let id: Int
    let title: String
    let color: UIColor
    let startDate: String
    let endDate: String
    
    func startComponents() -> SelectedDate? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: startDate) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            return SelectedDate(year: components.year ?? 0, month: components.month ?? 0, day: components.day)
        }
        return nil
    }
    
    func endComponents() -> SelectedDate? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        if let date = dateFormatter.date(from: endDate) {
            let calendar = Calendar.current
            let components = calendar.dateComponents([.year, .month, .day], from: date)
            return SelectedDate(year: components.year ?? 0, month: components.month ?? 0, day: components.day)
        }
        return nil
    }    
}
