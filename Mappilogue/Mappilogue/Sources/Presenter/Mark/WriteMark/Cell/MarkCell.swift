//
//  MarkCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class MarkCell: BaseCollectionViewCell {
    static let registerId = "\(MarkCell.self)"
    
    private let scheduleColorView = UIView()
    private let scheduleTitleLabel = UILabel()
    private let scheduleTimeLabel = UILabel()
    private let scheduleLocationLabel = UILabel()
    private let writeButton = UIButton()
    
    override func prepareForReuse() {
        super.prepareForReuse()
  
    }

    override func setupProperty() {
        super.setupProperty()
   
        scheduleColorView.layer.cornerRadius = 4
        scheduleColorView.backgroundColor = .orange
        
        scheduleTitleLabel.text = "제주 여행 🍊"
        scheduleTitleLabel.textColor = .color1C1C1C
        scheduleTitleLabel.font = .body02
        
        scheduleTimeLabel.text = "7:00 AM"
        scheduleTimeLabel.textColor = .color707070
        scheduleTimeLabel.font = .caption03
        
        scheduleLocationLabel.text = ", 김포국제공항"
        scheduleLocationLabel.textColor = .color707070
        scheduleLocationLabel.font = .caption03
        
        writeButton.setImage(UIImage(named: "moveMark"), for: .normal)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(scheduleColorView)
        contentView.addSubview(scheduleTitleLabel)
        contentView.addSubview(scheduleTimeLabel)
        contentView.addSubview(scheduleLocationLabel)
        contentView.addSubview(writeButton)
    }

    override func setupLayout() {
        super.setupLayout()
        
        scheduleColorView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(9)
            $0.leading.equalTo(contentView)
            $0.width.height.equalTo(20)
        }
        
        scheduleTitleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(8)
            $0.leading.equalTo(scheduleColorView.snp.trailing).offset(8)
            $0.trailing.equalTo(contentView).offset(-16)
        }
        
        scheduleTimeLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(29)
            $0.leading.equalTo(contentView).offset(28)
        }
        
        scheduleLocationLabel.snp.makeConstraints {
            $0.centerY.equalTo(scheduleTimeLabel)
            $0.leading.equalTo(scheduleTimeLabel.snp.trailing)
        }
        
        writeButton.snp.makeConstraints {
            $0.trailing.centerY.equalTo(contentView)
            $0.width.equalTo(8)
            $0.height.equalTo(16)
        }
    }
    
    func configure(with schedule: Schedule) {
        scheduleColorView.backgroundColor = schedule.color
        scheduleTitleLabel.text = schedule.title
        scheduleTimeLabel.text = schedule.time
        scheduleLocationLabel.text = schedule.location
    }
}
