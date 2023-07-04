//
//  TodayScheduleInfoCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/29.
//

import UIKit

class TodayScheduleInfoCell: BaseTableViewCell {
    static let registerId = "\(TodayScheduleInfoCell.self)"
    
    private let scheduleIndexView = UIView()
    private let scheduleIndexLabel = UILabel()
    private let scheduleInfoView = UIView()
    private let locationLabel = UILabel()
    private let separatorImage = UIImageView()
    private let timeLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .colorEAE6E1
        
        scheduleIndexView.layer.cornerRadius = 26 / 2
        scheduleIndexView.backgroundColor = .color1C1C1C
        
        scheduleIndexLabel.textColor = .colorFFFFFF
        scheduleIndexLabel.font = .title02
        
        scheduleInfoView.layer.cornerRadius = 12
        scheduleInfoView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        scheduleInfoView.backgroundColor = .colorF5F3F0
        
        locationLabel.textColor = .color1C1C1C
        locationLabel.font = .title02
        locationLabel.lineBreakMode = .byTruncatingTail
        
        separatorImage.image = UIImage(named: "separator")
        separatorImage.tintColor = .color9B9791
        
        timeLabel.textColor = .color9B9791
        timeLabel.font = .body02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(scheduleIndexView)
        scheduleIndexView.addSubview(scheduleIndexLabel)
        
        contentView.addSubview(scheduleInfoView)
        scheduleInfoView.addSubview(locationLabel)
        scheduleInfoView.addSubview(separatorImage)
        scheduleInfoView.addSubview(timeLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scheduleIndexView.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(15)
            $0.centerY.equalTo(contentView)
            $0.width.height.equalTo(26)
        }
        
        scheduleIndexLabel.snp.makeConstraints {
            $0.center.equalTo(scheduleIndexView)
        }
        
        scheduleInfoView.snp.makeConstraints {
            $0.top.trailing.bottom.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(55)
        }
        
        locationLabel.snp.makeConstraints {
            $0.leading.equalTo(scheduleInfoView).offset(14)
            $0.centerY.equalTo(scheduleInfoView)
            $0.trailing.lessThanOrEqualTo(scheduleInfoView).offset(-83)
        }
        
        separatorImage.snp.makeConstraints {
            $0.leading.equalTo(locationLabel.snp.trailing).offset(6)
            $0.centerY.equalTo(scheduleInfoView)
            $0.width.height.equalTo(3)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(separatorImage.snp.trailing).offset(6)
            $0.trailing.lessThanOrEqualTo(scheduleInfoView).offset(-7)
            $0.centerY.equalTo(scheduleInfoView)
        }
    }
    
    func configure(order: String, location: String, time: String) {
        scheduleIndexLabel.setTextWithLineHeight(text: order, lineHeight: UILabel.title02)
        locationLabel.setTextWithLineHeight(text: location, lineHeight: UILabel.title02)
        timeLabel.setTextWithLineHeight(text: time, lineHeight: UILabel.body02)
    }
}
