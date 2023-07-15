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
    case addLocation
    
    func numberOfRows(_ isColorSelection: Bool) -> Int {
        switch self {
        case .titleColor:
            return isColorSelection ? 2 : 1
        case .notificationRepeat:
            return 2
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
        case .addLocation:
            return AddLocationButtonCell.registerId
        }
    }
    
    func configureScheduleTitleColorCell(_ cell: ScheduleTitleColorCell, color: UIColor, isColorSelection: Bool) {
        cell.configure(with: color, isColorSelection: isColorSelection)
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
    
    func rowHeight(row: Int) -> CGFloat {
        switch self {
        case .titleColor:
            switch row {
            case 0:
                return 48
            case 1:
                return 186
            default:
                return 0
            }
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
