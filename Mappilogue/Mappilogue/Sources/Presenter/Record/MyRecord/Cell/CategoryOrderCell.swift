//
//  CategoryOrderCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/03.
//

import UIKit

class CategoryOrderCell: BaseCollectionViewCell {
    static let registerId = "\(CategoryOrderCell.self)"
    
    private let categoryLabel = UILabel()
    private let categoryCountLabel = UILabel()
    private let editImage = UIImageView()
    private let lineView = UIView()
    
    override func setupProperty() {
        super.setupProperty()
        
        lineView.backgroundColor = .colorEAE6E1
        
        categoryLabel.textColor = .color1C1C1C
        categoryLabel.font = .body02

        categoryCountLabel.textColor = .color9B9791
        categoryCountLabel.font = .body02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(categoryLabel)
        contentView.addSubview(categoryCountLabel)
        contentView.addSubview(editImage)
        contentView.addSubview(lineView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        categoryLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(8)
            $0.leading.equalTo(contentView)
        }
        
        categoryCountLabel.snp.makeConstraints {
            $0.leading.equalTo(categoryLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(categoryLabel)
        }
        
        editImage.snp.makeConstraints {
            $0.trailing.centerY.equalTo(contentView)
            $0.width.equalTo(28)
            $0.height.equalTo(28)
        }
        
        lineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(contentView)
            $0.height.equalTo(1)
        }
    }
    
    func configure(with category: CategoryData, isTotal: Bool) {
        categoryLabel.text = category.title
        categoryCountLabel.text = "(\(category.count))"
        editImage.image = isTotal ? nil : UIImage(named: "editCategory")
    }
}
