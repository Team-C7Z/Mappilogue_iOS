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
        
        frame = frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
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
            $0.leading.centerY.equalTo(self)
        }
    }
    
    func configure(_ date: String) {
        dateLabel.text = date
    }
}
