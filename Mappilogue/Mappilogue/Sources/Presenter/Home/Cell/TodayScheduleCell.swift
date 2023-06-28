//
//  TodayScheduleCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/27.
//

import UIKit

class TodayScheduleCell: BaseCollectionViewCell {
    static let registerId = "\(TodayScheduleCell.self)"
    
    private let todayScheduleLabel = UILabel().then {
        $0.text = "아빠랑 데이트🏃"
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
  
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)

    }
    
}
