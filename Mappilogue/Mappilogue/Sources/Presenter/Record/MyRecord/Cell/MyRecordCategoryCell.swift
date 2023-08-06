//
//  MyRecordCategoryCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/02.
//

import UIKit

class MyRecordCategoryCell: BaseTableViewCell {
    static let registerId = "\(MyRecordCategoryCell.self)"
    
    private let categoryLabel = UILabel()
    private let categoryCountLabel = UILabel()
    private let moveImage = UIImageView()
    private let lineView = UIView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        categoryLabel.textColor = .color1C1C1C
        categoryLabel.font = .body02

        categoryCountLabel.textColor = .color9B9791
        categoryCountLabel.font = .body02
        
        moveImage.image = UIImage(named: "moveWrite")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(categoryLabel)
        contentView.addSubview(categoryCountLabel)
        contentView.addSubview(moveImage)
        contentView.addSubview(lineView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        categoryLabel.snp.makeConstraints {
            $0.leading.centerY.equalTo(contentView)
        }
        
        categoryCountLabel.snp.makeConstraints {
            $0.leading.equalTo(categoryLabel.snp.trailing).offset(4)
            $0.centerY.equalTo(contentView)
        }
        
        moveImage.snp.makeConstraints {
            $0.trailing.centerY.equalTo(contentView)
            $0.width.equalTo(7)
            $0.height.equalTo(14)
        }
        
        lineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(contentView)
            $0.height.equalTo(1)
        }
    }
    
    func configure(with category: CategoryData, isLast: Bool) {
        categoryLabel.text = category.title
        categoryCountLabel.text = "(\(category.count))"
        lineView.backgroundColor = isLast ? .clear : .colorEAE6E1
    }
}
