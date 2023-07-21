//
//  AddScheduleSection.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/14.
//

import Foundation
import UIKit

enum AddScheduleSection: Int, CaseIterable {
    case titleColor
    case duration
    case notificationRepeat
    case locationTime
    case addLocation
    
    func numberOfRows(isColorSelection: Bool, locationCount: Int) -> Int {
        switch self {
        case .titleColor:
            return isColorSelection ? 2 : 1
        case .notificationRepeat:
            return 2
        case .locationTime:
            return locationCount + 1
        default:
            return 1
        }
    }
    
    func cellIdentifier(_ isColorSelection: Bool, row: Int) -> String {
        switch self {
        case .titleColor:
            switch row {
            case 0:
                return ScheduleTitleColorCell.registerId
            case 1:
                return ColorSelectionCell.registerId
            default:
                return ""
            }
        case .duration:
            return ScheduleDurationCell.registerId
        case .notificationRepeat:
            return NotificationRepeatCell.registerId
        case .locationTime:
            switch row {
            case 0:
                return DeleteLocationCell.registerId
            default:
                return LocationTimeCell.registerId
            }
        case .addLocation:
            return AddLocationButtonCell.registerId
        }
    }
    
    func configureScheduleTitleColorCell(_ cell: ScheduleTitleColorCell, color: UIColor, isColorSelection: Bool) {
        cell.configure(with: color, isColorSelection: isColorSelection)
    }
    
    func configureScheduleDurationColorCell(_ cell: ScheduleDurationCell, startDate: SelectedDate, endDate: SelectedDate) {
        cell.configure(startDate: startDate, endDate: endDate)
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
    
    func configureLocationTimeCell(_ cell: LocationTimeCell, index: Int, schedule: LocationTime, isDeleteMode: Bool) {
        cell.configure(with: index, schedule: schedule, isDeleteMode: isDeleteMode)
    }
    
    func rowHeight(row: Int) -> CGFloat {
        switch self {
        case .titleColor:
            switch row {
            case 0:
                return 58
            case 1:
                return 186
            default:
                return 0
            }
        case .duration:
            return 81
        case .notificationRepeat:
            return 48
        case .locationTime:
            switch row {
            case 0:
                return 32
            default:
                return 104
            }
        case .addLocation:
            return 53
        }
    }
    
    var footerHeight: CGFloat {
        switch self {
        case .notificationRepeat:
            return 16
        case .locationTime:
            return 12
        default:
            return 0
        }
    }
}
