//
//  TodayScheduleInfoCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/29.
//

import UIKit

class TodayScheduleInfoCell: BaseTableViewCell {
    static let registerId = "\(TodayScheduleInfoCell.self)"

    private let outerView = UIView()
    private let locationLabel = UILabel()
    private let separatorImage = UIImageView()
    private let timeLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        outerView.layer.cornerRadius = 12
        outerView.backgroundColor = .colorF5F3F0
        
        locationLabel.textColor = .color1C1C1C
        locationLabel.font = .title02
        locationLabel.numberOfLines = 1
        locationLabel.lineBreakMode = .byTruncatingTail
        
        separatorImage.image = UIImage(named: "separator")
        separatorImage.tintColor = .color9B9791
        
        timeLabel.textColor = .color9B9791
        timeLabel.font = .body02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(outerView)
        outerView.addSubview(locationLabel)
        outerView.addSubview(separatorImage)
        outerView.addSubview(timeLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        outerView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(contentView)
            $0.height.equalTo(48)
        }
        
        locationLabel.snp.makeConstraints {
            $0.top.equalTo(outerView).offset(8)
            $0.leading.equalTo(outerView).offset(12)
            $0.centerY.equalTo(outerView)
            $0.trailing.lessThanOrEqualTo(contentView).offset(-81)
        }
        
        separatorImage.snp.makeConstraints {
            $0.leading.equalTo(locationLabel.snp.trailing).offset(6)
            $0.centerY.equalTo(outerView)
            $0.width.height.equalTo(3)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(separatorImage.snp.trailing).offset(6)
            $0.trailing.equalTo(outerView).offset(-12)
            $0.centerY.equalTo(outerView)
        }
    }
    
    func configure(location: String, time: String) {
        locationLabel.text = location
        timeLabel.text = time

        self.layoutSubviews()
    }
}
