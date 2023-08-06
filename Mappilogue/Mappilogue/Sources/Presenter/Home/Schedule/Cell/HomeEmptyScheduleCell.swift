//
//  HomeEmptyScheduleCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/29.
//

import UIKit

class HomeEmptyScheduleCell: BaseTableViewCell {
    static let registerId = "\(HomeEmptyScheduleCell.self)"
    
    private let stackView = UIStackView()
    private let emptyScheduleLabel = UILabel()
    private let emptyScheduleSubLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.backgroundColor = .colorF5F3F0
        contentView.layer.cornerRadius = 12
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        
        emptyScheduleLabel.font = .title02
        emptyScheduleLabel.textColor = .color707070
        emptyScheduleLabel.textAlignment = .center
        
        emptyScheduleSubLabel.text = "아래 버튼을 눌러 일정을 추가해 보세요!"
        emptyScheduleSubLabel.font = .caption02
        emptyScheduleSubLabel.textColor = .color404040
        emptyScheduleSubLabel.textAlignment = .center
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(emptyScheduleLabel)
        stackView.addArrangedSubview(emptyScheduleSubLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(contentView)
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
