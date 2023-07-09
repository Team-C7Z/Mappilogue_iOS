//
//  DayCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/07.
//

import UIKit

class DayCell: BaseCollectionViewCell {
    static let registerId = "\(DayCell.self)"
    
    private let todayView = UIView()
    private let dayLabel = UILabel()
    private let lineView = UIView()
    
    override func setupProperty() {
        super.setupProperty()
        
        todayView.layer.cornerRadius = 21 / 2
        
        dayLabel.setTextWithLineHeight(text: "", lineHeight: UILabel.body02)
        dayLabel.font = .body02
        
        lineView.backgroundColor = .colorEAE6E1
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        todayView.addSubview(dayLabel)
        contentView.addSubview(todayView)
        contentView.addSubview(lineView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        todayView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(9)
            $0.centerX.equalTo(contentView)
            $0.width.height.equalTo(21)
        }
        
        dayLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(todayView)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(contentView)
            $0.height.equalTo(1)
        }
    }
    
    func configure(with day: String, isNotCurrentMonth: Bool, isSaturday: Bool, isSunday: Bool, isToday: Bool) {
        dayLabel.setTextWithLineHeight(text: day, lineHeight: UILabel.body02)
    
        if isToday {
            todayView.backgroundColor = .color2EBD3D
            
            dayLabel.textColor = .colorFFFFFF
            
        } else {
            todayView.backgroundColor = .clear
            
            if isNotCurrentMonth {
                dayLabel.textColor = .color9B9791
            } else if isSaturday {
                dayLabel.textColor = .color3C58EE
            } else if isSunday {
                dayLabel.textColor = .colorF14C4C
            } else {
                dayLabel.textColor = .color1C1C1C
            }
        }
    }
}
