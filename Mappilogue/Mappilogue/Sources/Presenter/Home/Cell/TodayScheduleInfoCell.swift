//
//  TodayScheduleInfoCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/29.
//

import UIKit

class TodayScheduleInfoCell: BaseCollectionViewCell {
    static let registerId = "\(TodayScheduleInfoCell.self)"
    
    private let scheduleIndexView = UIView()
    private let scheduleIndexLabel = UILabel()
    private let scheduleInfoView = UIView()
    private let locationLabel = UILabel()
    private let separatorImage = UIImageView()
    private let timeLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        layer.cornerRadius = 12
        backgroundColor = .colorEAE6E1
        
        scheduleIndexView.layer.cornerRadius = 26 / 2
        scheduleIndexView.backgroundColor = .color1C1C1C
        
        scheduleIndexLabel.textColor = .colorFFFFFF
        scheduleIndexLabel.font = UIFont.pretendard(.medium, size: 16)
        
        scheduleInfoView.layer.cornerRadius = 12
        scheduleInfoView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        scheduleInfoView.backgroundColor = .colorF5F3F0
        
        locationLabel.textColor = .color1C1C1C
        locationLabel.font = UIFont.pretendard(.medium, size: 16)
        locationLabel.lineBreakMode = .byTruncatingTail
        
        separatorImage.image = UIImage(named: "separator")
        separatorImage.tintColor = .color9B9791
        
        timeLabel.textColor = .color9B9791
        timeLabel.font = UIFont.pretendard(.regular, size: 14)
    }
    
    override func setupHierarchy() {
        super.setupProperty()
        
        addSubview(scheduleIndexView)
        scheduleIndexView.addSubview(scheduleIndexLabel)
        
        addSubview(scheduleInfoView)
        scheduleInfoView.addSubview(locationLabel)
        scheduleInfoView.addSubview(separatorImage)
        scheduleInfoView.addSubview(timeLabel)
    }
    
    override func setupLayout() {
        super.setupProperty()
        
        scheduleIndexView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(15)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(26)
        }
        
        scheduleIndexLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(scheduleIndexView)
        }
        
        scheduleInfoView.snp.makeConstraints {
            $0.top.trailing.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(55)
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
    
    func configure(with order: String, location: String, time: String) {
        scheduleIndexLabel.text = order
        locationLabel.text = location
        timeLabel.text = time
    }
}
