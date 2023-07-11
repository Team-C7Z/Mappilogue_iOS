//
//  ScheduleCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/10.
//

import UIKit

class ScheduleCell: BaseCollectionViewCell {
    static let registerId = "\(ScheduleCell.self)"
    
    private let scheduleColorView = UIView()
    private let scheduleLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.layer.cornerRadius = 4
        scheduleLabel.font = .caption03
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(scheduleColorView)
        scheduleColorView.addSubview(scheduleLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scheduleColorView.snp.makeConstraints {
            $0.width.height.equalTo(contentView)
        }
        
        scheduleLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(4)
            $0.centerY.equalTo(contentView)
        }
    }
    
    func configure(with schedule: String, color: UIColor, isScheduleContinuous: Bool, continuousDay: Int) {
        if !isScheduleContinuous {
            scheduleLabel.setTextWithLineHeight(text: schedule, lineHeight: UILabel.caption03)
            print(continuousDay, schedule)
            contentView.backgroundColor = color
            frame.size.width = contentView.bounds.width * CGFloat(continuousDay)
        }
    }
}
