//
//  EmptyScheduleCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/29.
//

import UIKit

class EmptyScheduleCell: BaseTableViewCell {
    static let registerId = "\(EmptyScheduleCell.self)"
    
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
        
        emptyScheduleLabel.text = "오늘은 등록된 일정이 없어요"
        emptyScheduleLabel.textColor = .color707070
        emptyScheduleLabel.textAlignment = .center
        emptyScheduleLabel.font = UIFont.pretendard(.medium, size: 16)
        
        emptyScheduleSubLabel.text = "아래 버튼을 눌러 일정을 추가해 보세요!"
        emptyScheduleSubLabel.textColor = .color404040
        emptyScheduleSubLabel.textAlignment = .center
        emptyScheduleSubLabel.font = UIFont.pretendard(.medium, size: 12)
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
}
    
