//
//  WeekdayCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/07.
//

import UIKit

class WeekdayCell: BaseCollectionViewCell {
    static let registerId = "\(WeekdayCell.self)"
    
    private let weekdayLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        weekdayLabel.font = .caption02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(weekdayLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        weekdayLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(contentView)
        }
    }
    
    func configure(with weekday: String) {
        weekdayLabel.setTextWithLineHeight(text: weekday, lineHeight: UILabel.caption02)
    }
}
