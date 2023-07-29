//
//  EmptySearchCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/29.
//

import UIKit

class EmptySearchCell: BaseTableViewCell {
    static let registerId = "\(EmptySearchCell.self)"
    
    let stackView = UIStackView()
    private let emptyLabel = UILabel()
    private let emptySubLabel = UILabel()

    override func setupProperty() {
        super.setupProperty()
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.spacing = 4
        
        emptyLabel.text = "검색 결과가 없어요"
        emptyLabel.textColor = .color707070
        emptyLabel.font = .title02
        
        emptySubLabel.text = "잘못 입력한 부분이 있는지 다시 한 번 확인해 보세요"
        emptySubLabel.textColor = .color707070
        emptySubLabel.font = .caption01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(emptyLabel)
        stackView.addArrangedSubview(emptySubLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(contentView)
        }
    }
}
