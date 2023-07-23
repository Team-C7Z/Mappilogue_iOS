//
//  TodayScheduleSection.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/14.
//

import Foundation
import UIKit

enum TodayScheduleSection: Int, CaseIterable {
    case todaySchedule
    case todayScheduleInfo
    case addLocation
    case markedRecord
    
    var cellIdentifier: String {
        switch self {
        case .todaySchedule:
            return TodayScheduleCell.registerId
        case .todayScheduleInfo:
            return TodayScheduleInfoCell.registerId
        case .addLocation:
            return AddLocationButtonCell.registerId
        case .markedRecord:
            return MarkedRecordsCell.registerId
        }
    }
    
    func numberOfSections(_ scheduleData: [TodaySchedule]) -> Int {
        return scheduleData.count + 2
    }
    
    func numberOfRows(_ section: Int, scheduleData: [TodaySchedule], isExpand: Bool) -> Int {
        if scheduleData.count > section && isExpand {
            return scheduleData[section].location.count + 1
        } else {
            return 1
        }
    }
    
    func configureTodayScheduleCell(_ cell: TodayScheduleCell, section: Int, scheduleData: [TodaySchedule], isExpand: Bool) {
        
        let schedule = scheduleData[section]
        let title = schedule.title
        let backgroundColor = schedule.color
        
        cell.configure(with: title, backgroundColor: backgroundColor, isExpanded: isExpand)
    }
    
    func configureTodayScheduleInfoCell(_ cell: TodayScheduleInfoCell, indexPath: IndexPath, scheduleData: [TodaySchedule]) {
        
        let schedule = scheduleData[indexPath.section]
        let index = "\(indexPath.row)"
        let location = schedule.location[indexPath.row - 1]
        let time = schedule.time[indexPath.row - 1]
        
        cell.configure(order: index, location: location, time: time)
    }
    
    func rowHeight(_ indexPath: IndexPath, scheduleData: [TodaySchedule]) -> CGFloat {
        if scheduleData.count > indexPath.section {
            switch indexPath.row {
            case 0:
                return 38
            default:
                return 50 + 10
            }
        } else if scheduleData.count == indexPath.section {
            return 53
        } else {
            return 259
        }
    }
    
    func footerHeight(_ section: Int, scheduleData: [TodaySchedule]) -> CGFloat {
        if (scheduleData.count - 1) > section {
            return 13
        } else if (scheduleData.count - 1) == section {
            return 10
        } else if scheduleData.count == section {
            return 27
        } else {
            return 0
        }
    }
}
