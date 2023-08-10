//
//  ScheduleDateHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/10.
//

import UIKit

class ScheduleDateHeaderView: BaseCollectionReusableView {
    static let registerId = "\(ScheduleDateHeaderView.self)"
    
    private let dateLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    override func setupProperty() {
        super.setupProperty()

        dateLabel.textColor = .color707070
        dateLabel.font = .title02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(dateLabel)
    }
    
    override func setupLayout() {
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(self).offset(16)
            $0.centerY.equalTo(self)
        }
    }
    
    func configure(_ date: String) {
        dateLabel.text = date
    }
}
