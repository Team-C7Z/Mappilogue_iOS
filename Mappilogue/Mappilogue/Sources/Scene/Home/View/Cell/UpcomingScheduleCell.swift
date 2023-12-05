//
//  UpcomingScheduleCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/30.
//

import UIKit
import MappilogueKit

class UpcomingScheduleCell: BaseTableViewCell {
    static let registerId = "\(UpcomingScheduleCell.self)"
    
    private let outerView = UIView()
    private let upcomingScheduleDateLabel = UILabel()
    private let separatorImage = UIImageView()
    private let upcomingScheduleTimeLabel = UILabel()
    private let upcomingScheduleLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        outerView.layer.cornerRadius = 12
        outerView.backgroundColor = .grayF5F3F0
        
        upcomingScheduleTimeLabel.textColor = .black1C1C1C
        upcomingScheduleDateLabel.font = .caption02
        
        separatorImage.tintColor = .black1C1C1C
        
        upcomingScheduleTimeLabel.textColor = .black1C1C1C
        upcomingScheduleTimeLabel.font = .caption01
        
        upcomingScheduleLabel.textColor = .black1C1C1C
        upcomingScheduleLabel.font = .title02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(outerView)
        outerView.addSubview(upcomingScheduleDateLabel)
        outerView.addSubview(separatorImage)
        outerView.addSubview(upcomingScheduleTimeLabel)
        outerView.addSubview(upcomingScheduleLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        outerView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(contentView)
            $0.height.equalTo(76)
        }
        
        upcomingScheduleDateLabel.snp.makeConstraints {
            $0.top.equalTo(outerView).offset(16)
            $0.leading.equalTo(outerView).offset(14)
        }
        
        separatorImage.snp.makeConstraints {
            $0.leading.equalTo(upcomingScheduleDateLabel.snp.trailing).offset(5)
            $0.centerY.equalTo(upcomingScheduleDateLabel)
            $0.width.height.equalTo(2)
        }
        
        upcomingScheduleTimeLabel.snp.makeConstraints {
            $0.leading.equalTo(separatorImage.snp.trailing).offset(5)
            $0.centerY.equalTo(separatorImage)
        }
        
        upcomingScheduleLabel.snp.makeConstraints {
            $0.top.equalTo(outerView).offset(37)
            $0.leading.equalTo(outerView).offset(14)
            $0.trailing.lessThanOrEqualTo(outerView).offset(-20)
        }
    }
    
    func configure(_ schedule: UpcomingSchedule) {
        upcomingScheduleDateLabel.text = schedule.date
        if let time = schedule.time {
            upcomingScheduleTimeLabel.text = "\(time) 시작"
            separatorImage.image = Images.image(named: .imageSeparator)
        } else {
            upcomingScheduleTimeLabel.text = ""
        }
        
        upcomingScheduleLabel.text = schedule.title
    }
    
}
