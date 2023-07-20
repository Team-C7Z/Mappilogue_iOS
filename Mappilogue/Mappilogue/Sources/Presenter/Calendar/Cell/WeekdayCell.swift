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
        
        contentView.backgroundColor = .colorFFFFFF
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
        weekdayLabel.text = weekday
        weekdayLabel.textColor = isSaturday ? .color3C58EE : isSunday ? .colorF14C4C : .color1C1C1C
    }
}
