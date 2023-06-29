//
//  TodayScheduleCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/27.
//

import UIKit

class TodayScheduleCell: BaseCollectionViewCell {
    static let registerId = "\(TodayScheduleCell.self)"
    
    private let todayScheduleLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        layer.cornerRadius = 12
        
        todayScheduleLabel.textColor = .color1C1C1C
        todayScheduleLabel.textAlignment = .center
        todayScheduleLabel.font = UIFont.pretendard(.medium, size: 16)
    }
    
    override func setupHierarchy() {
        super.setupProperty()
        
        addSubview(todayScheduleLabel)
    }
    
    override func setupLayout() {
        super.setupProperty()
        
        todayScheduleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(14)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(with title: String, backgroundColor: UIColor) {
        todayScheduleLabel.text = title
        self.backgroundColor = backgroundColor
    }
}
