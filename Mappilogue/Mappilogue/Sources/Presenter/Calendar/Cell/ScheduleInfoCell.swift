//
//  ScheduleInfoCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class ScheduleInfoCell: BaseCollectionViewCell {
    static let registerId = "\(ScheduleInfoCell.self)"
    
    private let scheduleColorView = UIView()
    private let scheduleLabel = UILabel()
    private let scheduleTimeLabel = UILabel()
    private let scheduleLocationLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        scheduleColorView.layer.cornerRadius = 4
        scheduleColorView.backgroundColor = .colorE6C3F2
        
        scheduleLabel.text = "미술관 가기"
        scheduleLabel.textColor = .color1C1C1C
        scheduleLabel.font = .body02
        
        scheduleTimeLabel.text = "01:00 PM"
        scheduleTimeLabel.textColor = .color707070
        scheduleTimeLabel.font = .caption03
        
        scheduleLocationLabel.text = ", 국립현대미술관"
        scheduleLocationLabel.textColor = .color707070
        scheduleLocationLabel.font = .caption03
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(scheduleColorView)
        contentView.addSubview(scheduleLabel)
        contentView.addSubview(scheduleTimeLabel)
        contentView.addSubview(scheduleLocationLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scheduleColorView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(9)
            $0.leading.equalTo(contentView)
            $0.width.height.equalTo(20)
        }
        
        scheduleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(8)
            $0.leading.equalTo(scheduleColorView.snp.trailing).offset(8)
        }
        
        scheduleTimeLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(29)
            $0.leading.equalTo(scheduleColorView.snp.trailing).offset(8)
        }
        
        scheduleLocationLabel.snp.makeConstraints {
            $0.centerY.equalTo(scheduleTimeLabel)
            $0.leading.equalTo(scheduleTimeLabel.snp.trailing)
        }
    }
    
//    func configure(with schedule: String, color: UIColor, isScheduleContinuous: Bool, continuousDay: Int) {
//        if !isScheduleContinuous {
//            scheduleLabel.setTextWithLineHeight(text: schedule, lineHeight: UILabel.caption03)
//            scheduleColorView.backgroundColor = color
//            frame.size.width = contentView.bounds.width * CGFloat(continuousDay)
//        }
//    }
}