//
//  AddScheduleSection.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/14.
//

import Foundation

enum AddScheduleSection: Int, CaseIterable {
    case titleColor
    case duration
    case notificationRepeat
    case addLocation
    
    var numberOfRows: Int {
        switch self {
        case .notificationRepeat:
            return 2
        default:
            return 1
        }
    }
    
    var cellIdentifier: String {
        switch self {
        case .titleColor:
            return ScheduleTitleColorCell.registerId
        case .duration:
            return ScheduleDurationCell.registerId
        case .notificationRepeat:
            return NotificationRepeatCell.registerId
        case .addLocation:
            return AddLocationButtonCell.registerId
        }
    }
    
    func configureNotificationRepeatCell(_ cell: NotificationRepeatCell, row: Int) {
        switch row {
        case 0:
            cell.configure(imageName: "notification", title: "알림")
        case 1:
            cell.configure(imageName: "repeat", title: "반복")
        default:
            break
        }
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .titleColor:
            return 48
        case .duration:
            return 81
        case .notificationRepeat:
            return 48
        case .addLocation:
            return 53
        }
    }
    
    var footerHeight: CGFloat {
        return self == .notificationRepeat ? 16 : 0
    }
}
