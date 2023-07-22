//
//  ScheduleCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class ScheduleCell: BaseTableViewCell {
    static let registerId = "\(ScheduleCell.self)"
    
    private let scheduleColorView = UIView()
    private let scheduleLabel = UILabel()
    private let scheduleTimeLabel = UILabel()
    private let scheduleLocationLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        scheduleColorView.layer.cornerRadius = 4
        
        scheduleLabel.textColor = .color1C1C1C
        scheduleLabel.font = .body02
        
        scheduleTimeLabel.textColor = .color707070
        scheduleTimeLabel.font = .caption03
        
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
    
    func configure(with schedule: Schedule) {
        scheduleLabel.text = schedule.title
        scheduleColorView.backgroundColor = schedule.color
        scheduleTimeLabel.text = schedule.time
        scheduleLocationLabel.text = ", \(schedule.location)"
    }
}
