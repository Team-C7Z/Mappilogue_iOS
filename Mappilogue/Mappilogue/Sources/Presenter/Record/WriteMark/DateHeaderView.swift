//
//  DateHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class DateHeaderView: BaseCollectionReusableView {
    static let registerId = "\(DateHeaderView.self)"
    
    private let dateLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
      
        dateLabel.text = "7월 10일"
        dateLabel.textColor = .color000000
        dateLabel.font = .subtitle01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(dateLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(self).offset(16)
            $0.top.equalTo(self)
        }
    }
    
    func configure(month: Int, day: Int) {
        dateLabel.text = "\(month)월 \(day)일"
    }
}
