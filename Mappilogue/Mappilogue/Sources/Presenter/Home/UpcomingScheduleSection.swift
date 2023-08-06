//
//  UpcomingScheduleSection.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/14.
//

import Foundation

enum UpcomingScheduleSection: Int, CaseIterable {
    case upcomingSchedule
    case addSchedule
    case markedRecord
    
    var cellIdentifier: String {
        switch self {
        case .upcomingSchedule:
            return UpcomingScheduleCell.registerId
        case .addSchedule:
            return AddScheduleButtonCell.registerId
        case .markedRecord:
            return MarkedRecordsCell.registerId
        }
    }
    
    func numberOfRows(section: Int, scheduleData: [UpcomingSchedule], limitedUpcomingScheduleCount: Int) -> Int {
        switch section {
        case 0:
            return min(scheduleData.count, limitedUpcomingScheduleCount)
        default:
            return 1
        }
    }
    
    func configureCell(_ cell: UpcomingScheduleCell, row: Int, scheduleData: [UpcomingSchedule]) {
        let schedule = scheduleData[row]
        let title = schedule.title
        let date = schedule.date
        let time = schedule.time
        
        cell.configure(with: title, date: date, time: time)
    }
    
    func rowHeight(_ section: Int) -> CGFloat {
        switch section {
        case 0:
            return 76 + 10
        case 1:
            return 53
        default:
            return 259
        }
    }
    
    func footerHeight(_ section: Int) -> CGFloat {
        switch section {
        case 0:
            return 0
        default:
            return 27
        }
    }
}
