//
//  CalendarEmptyScheduleCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/23.
//

import UIKit

class CalendarEmptyScheduleCell: BaseCollectionViewCell {
    static let registerId = "\(CalendarEmptyScheduleCell.self)"
    
    private let stackView = UIStackView()
    private let emptyScheduleLabel = UILabel()
    private let emptyScheduleSubLabel = UILabel()

    override func setupProperty() {
        super.setupProperty()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        
        emptyScheduleLabel.text = "일정이 없어요"
        emptyScheduleLabel.textColor = .color707070
        emptyScheduleLabel.font = .title02
        
        emptyScheduleSubLabel.text = "일정 추가 버튼을 눌러 일정을 만들어 보세요"
        emptyScheduleSubLabel.textColor = .color707070
        emptyScheduleSubLabel.font = .caption01
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
            $0.centerX.equalTo(contentView)
            $0.top.equalTo(contentView).offset(116)
        }
    }
}
