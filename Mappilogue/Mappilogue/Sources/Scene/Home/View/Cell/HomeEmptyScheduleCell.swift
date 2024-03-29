//
//  HomeEmptyScheduleCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/29.
//

import UIKit

class HomeEmptyScheduleCell: BaseTableViewCell {
    static let registerId = "\(HomeEmptyScheduleCell.self)"
    
    private let emptyScheduleLabel = UILabel()
    private let emptyScheduleSubLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 16, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.backgroundColor = .grayF5F3F0
        contentView.layer.cornerRadius = 12
        
        emptyScheduleLabel.font = .title02
        emptyScheduleLabel.textColor = .gray707070
        emptyScheduleLabel.textAlignment = .center
        
        emptyScheduleSubLabel.text = "아래 버튼을 눌러 일정을 추가해 보세요!"
        emptyScheduleSubLabel.font = .caption02
        emptyScheduleSubLabel.textColor = .gray404040
        emptyScheduleSubLabel.textAlignment = .center
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(emptyScheduleLabel)
        contentView.addSubview(emptyScheduleSubLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        emptyScheduleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(41)
            $0.centerX.equalTo(contentView)
        }
        
        emptyScheduleSubLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(66)
            $0.centerX.equalTo(contentView)
        }
    }
    
    func configure(scheduleType: ScheduleType) {
        switch scheduleType {
        case .today:
            emptyScheduleLabel.text = "오늘은 등록된 일정이 없어요"
        case .upcoming:
            emptyScheduleLabel.text = "다가오는 일정이 없어요"
        }
    }
}
