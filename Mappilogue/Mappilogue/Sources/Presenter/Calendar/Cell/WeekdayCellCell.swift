//
//  WeekdayCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/07.
//

import UIKit

class WeekdayCell: BaseCollectionViewCell {
    static let registerId = "\(WeekdayCell.self)"
    
    private let weekdayLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        weekdayLabel.font = .caption02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(weekdayLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        weekdayLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(contentView)
        }
    }
    
    func configure(with weekday: String, isSaturday: Bool, isSunday: Bool) {
        weekdayLabel.setTextWithLineHeight(text: weekday, lineHeight: UILabel.caption02)
        
        if isSaturday {
            weekdayLabel.textColor = .color3C58EE
        } else if isSunday {
            weekdayLabel.textColor = .colorF14C4C
        } else {
            weekdayLabel.textColor = .color1C1C1C
        }
    }
}
