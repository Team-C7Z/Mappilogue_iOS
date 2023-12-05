//
//  ScheduleDateCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/10/29.
//

import UIKit

class ScheduleDateCell: BaseCollectionViewCell {
    static let registerId = "\(ScheduleDateCell.self)"

    private let dateLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentView.backgroundColor = .grayEAE6E1
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.layer.cornerRadius = 20
        
        dateLabel.text = "5월 10일"
        dateLabel.font = .title02
        dateLabel.textColor = .whiteFFFFFF
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(dateLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
    
        dateLabel.snp.makeConstraints {
            $0.centerX.centerY.equalTo(contentView)
        }
    }
    
    func configure(_ date: String, isSelected: Bool) {
        dateLabel.text = date
        contentView.backgroundColor = isSelected ? .black1C1C1C : .grayEAE6E1
    }
}
