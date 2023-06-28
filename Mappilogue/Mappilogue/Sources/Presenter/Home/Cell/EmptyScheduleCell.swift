//
//  EmptyScheduleCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/29.
//

import UIKit

class EmptyScheduleCell: BaseCollectionViewCell {
    static let registerId = "\(EmptyScheduleCell.self)"
    
    private let stackView = UIStackView()
    private let emptyScheduleLabel = UILabel()
    private let emptyScheduleSubLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .colorF5F3F0
        layer.cornerRadius = 12
        
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
        super.setupProperty()
        
        addSubview(stackView)
        [emptyScheduleLabel, emptyScheduleSubLabel].forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    override func setupLayout() {
        super.setupProperty()
        
        stackView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
    
