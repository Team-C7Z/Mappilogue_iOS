//
//  ScheduleCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/10.
//

import UIKit

class ScheduleCell: BaseCollectionViewCell {
    static let registerId = "\(ScheduleCell.self)"
    
    private let scheduleLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.layer.cornerRadius = 4
        scheduleLabel.font = .caption03
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(scheduleLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scheduleLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(4)
            $0.centerY.equalTo(contentView)
        }
    }
    
    func configure(with schedule: String, color: UIColor) {
        scheduleLabel.setTextWithLineHeight(text: schedule, lineHeight: UILabel.caption03)
        contentView.backgroundColor = color
        
        scheduleLabel.clipsToBounds = false

    }
}
