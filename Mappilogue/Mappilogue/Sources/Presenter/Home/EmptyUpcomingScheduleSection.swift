//
//  EmptyUpcomingScheduleSection.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/14.
//

import Foundation
import UIKit

enum EmptyUpcomingScheduleSection: Int, CaseIterable {
    case emptySchedule
    case addSchedule
    case markedRecord
    
    var numberOfRows: Int {
        return 1
    }
    
    var cellIdentifier: String {
        switch self {
        case .emptySchedule:
            return HomeEmptyScheduleCell.registerId
        case .addSchedule:
            return AddScheduleButtonCell.registerId
        case .markedRecord:
            return MarkedRecordsCell.registerId
        }
    }
    
    func configureCell(_ cell: UITableViewCell) {
        guard let emptyScheduleCell = cell as? HomeEmptyScheduleCell else { return }
        emptyScheduleCell.configure(scheduleType: .upcoming)
    }
    
    var rowHeight: CGFloat {
        switch self {
        case .emptySchedule:
            return 130
        case .addSchedule:
            return 53
        case .markedRecord:
            return 259
        }
    }
              
    var footerHeight: CGFloat {
        switch self {
        case .emptySchedule:
            return 10
        case .addSchedule:
            return 27
        case .markedRecord:
            return 0
        }
    }
}
