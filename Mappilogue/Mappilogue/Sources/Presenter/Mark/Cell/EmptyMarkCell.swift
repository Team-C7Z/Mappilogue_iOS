//
//  EmptyMarkCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/26.
//

import UIKit

class EmptyMarkCell: BaseTableViewCell {
    static let registerId = "\(EmptyMarkCell.self)"
    
    let stackView = UIStackView()
    private let emptyMarkLabel = UILabel()
    private let emptyMarkSubLabel = UILabel()

    override func setupProperty() {
        super.setupProperty()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        
        emptyMarkLabel.text = "표시할 기록이 없어요"
        emptyMarkLabel.textColor = .color707070
        emptyMarkLabel.font = .title02
        
        emptyMarkSubLabel.text = "캘린더에 등록했던 일정에서 기록을 만들어 보세요"
        emptyMarkSubLabel.textColor = .color707070
        emptyMarkSubLabel.font = .caption01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(emptyMarkLabel)
        stackView.addArrangedSubview(emptyMarkSubLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(contentView)
        }
    }
}
