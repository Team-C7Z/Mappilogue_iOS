//
//  Schedule.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/19.
//

import Foundation
import UIKit

struct Schedule {
    let title: String
    let color: UIColor
    let time: String
    let location: String
}

func dummyScheduleData() -> [Schedule] {
    let schedules = [
        Schedule(title: "미술관 가기", color: .colorE6C3F2, time: "1:00 PM", location: "국립현대미술관"),
        Schedule(title: "홈트레이닝", color: .colorF0B4D5, time: "4:00 PM", location: ""),
        Schedule(title: "저녁 회의", color: .colorB2EAD6, time: "8:00 PM", location: "스타벅스 논현점")
    ]
    return schedules
}
