//
//  UpcomingScheduleCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/30.
//

import UIKit

class UpcomingScheduleCell: BaseTableViewCell {
    static let registerId = "\(UpcomingScheduleCell.self)"
    
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
        
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor = .colorF5F3F0
        
        upcomingScheduleDateLabel.font = .pretendard(.medium, size: 12)
        upcomingScheduleTimeLabel.font = .pretendard(.regular, size: 12)
        upcomingScheduleLabel.font = .pretendard(.medium, size: 16)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(upcomingScheduleDateLabel)
        contentView.addSubview(separatorImage)
        contentView.addSubview(upcomingScheduleTimeLabel)
        contentView.addSubview(upcomingScheduleLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        upcomingScheduleDateLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(16)
            $0.leading.equalTo(contentView).offset(14)
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
            $0.top.equalTo(contentView).offset(37)
            $0.leading.equalTo(contentView).offset(14)
            $0.trailing.lessThanOrEqualTo(contentView).offset(-20)
        }
    }
    
    func configure(with title: String, date: String, time: String) {
        upcomingScheduleDateLabel.text = date
        upcomingScheduleTimeLabel.text = "\(time) 시작"
        upcomingScheduleLabel.text = title
    }
    
}
