//
//  ScheduleTitleCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/10.
//

import UIKit

class ScheduleTitleCell: BaseCollectionViewCell {
    static let registerId = "\(ScheduleTitleCell.self)"
    
    private let scheduleColorView = UIView()
    private let scheduleLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
  
        scheduleColorView.backgroundColor = .clear
        scheduleLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        
    }

    override func setupProperty() {
        super.setupProperty()
        
        scheduleColorView.layer.cornerRadius = 4
        scheduleLabel.font = .caption03

    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(scheduleColorView)
        scheduleColorView.addSubview(scheduleLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scheduleColorView.snp.makeConstraints {
            $0.width.height.equalTo(self)
        }
        
        scheduleLabel.snp.makeConstraints {
            $0.leading.equalTo(scheduleColorView).offset(4)
            $0.centerY.equalTo(scheduleColorView)
        }
    }
    
    func configure(with schedule: String, color: UIColor, scheduleCount: Int?, row: Int) {

        if let scheduleCount {
            let count = min(scheduleCount, 7 - row)
          
            scheduleLabel.text = schedule
            scheduleColorView.backgroundColor = color
            frame.size.width = contentView.bounds.width * CGFloat(count)
        } else {
            scheduleColorView.backgroundColor = .blue
            frame.size.width = 0
        }
    }
}
