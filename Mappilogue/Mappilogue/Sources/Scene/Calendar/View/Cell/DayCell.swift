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
    
    override func prepareForReuse() {
        super.prepareForReuse()
  
        todayView.backgroundColor = .clear
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        todayView.layer.cornerRadius = 21 / 2
        
        dayLabel.font = .body02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        todayView.addSubview(dayLabel)
        contentView.addSubview(todayView)
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
    }
    
    func configure(with day: String, isCurrentMonth: Bool, isSaturday: Bool, isSunday: Bool, isToday: Bool) {
        dayLabel.text = day
        
        if isCurrentMonth {
            dayLabel.textColor = .black1C1C1C
            
            if isToday {
                todayView.backgroundColor = .green2EBD3D
                dayLabel.textColor = .whiteFFFFFF
            } else if isSaturday {
                dayLabel.textColor = .color3C58EE
            } else if isSunday {
                dayLabel.textColor = .redF14C4C
            }
        } else {
            dayLabel.textColor = .gray9B9791
        }
    }
}
