//
//  EmptyRecordCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/26.
//

import UIKit

class EmptyRecordCell: BaseCollectionViewCell {
    static let registerId = "\(EmptyRecordCell.self)"
    
    let stackView = UIStackView()
    private let emptyRecordLabel = UILabel()
    private let emptyRecordSubLabel = UILabel()

    override func setupProperty() {
        super.setupProperty()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        
        emptyRecordLabel.text = "표시할 기록이 없어요"
        emptyRecordLabel.textColor = .color707070
        emptyRecordLabel.font = .title02
        
        emptyRecordSubLabel.text = "캘린더에 등록했던 일정에서 기록을 만들어 보세요"
        emptyRecordSubLabel.textColor = .color707070
        emptyRecordSubLabel.font = .caption01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(emptyRecordLabel)
        stackView.addArrangedSubview(emptyRecordSubLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(contentView)
        }
    }
}
