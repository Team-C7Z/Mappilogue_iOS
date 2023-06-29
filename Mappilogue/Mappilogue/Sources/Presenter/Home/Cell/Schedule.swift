//
//  Schedule.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/29.
//

import UIKit
import Foundation

struct Schedule {
    let title: String
    let location: [String]
    let time: [String]
    let color: UIColor
}

func generateDummyScheduleData(schduleCount: Int) -> [Schedule] {
    var schedules = [Schedule]()
    
    if schduleCount == 0 {
        
    } else if schduleCount == 1 {
        let schedule = Schedule(title: "아빠랑 데이트 🏃🏻", location: ["춘배식당", "카페 문", "아주 건강해지는 제이슨 건강어쩌구어쩌구"], time: ["9:00 AM", "10:00 AM", "1:00 PM"], color: .yellow)
        schedules = [schedule]
    } else {
        let schedule1 = Schedule(title: "아빠랑 데이트 🏃🏻", location: ["춘배식당", "카페 문", "아주 건강해지는 제이슨 건강어쩌구어쩌구"], time: ["9:00 AM", "10:00 AM", "1:00 PM"], color: .yellow)
        let schedule2 = Schedule(title: "러닝메이트 회의", location: ["공간대여 산", "에나 파스타"], time: ["3:00 PM", "6:00 PM"], color: .green)
        let schedule3 = Schedule(title: "CS 스터디", location: ["운영체제 회의실", "자료구조 카페"], time: ["1:00 PM", "3:00 PM"], color: .gray)
        
        schedules = [schedule1, schedule2, schedule3]
    }
    
    return schedules
}
