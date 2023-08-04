//
//  CategorySelectionCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/04.
//

import UIKit

class CategorySelectionCell: BaseCollectionViewCell {
    static let registerId = "\(CategorySelectionCell.self)"

    private let categoryLabel = UILabel()
    private let categoryImage = UIImageView()
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.layer.cornerRadius = 16
        contentView.layer.applyShadow()
        contentView.backgroundColor = .colorF9F8F7
        
        categoryLabel.textColor = .color1C1C1C
        categoryLabel.font = .caption02
        
        categoryImage.image = UIImage(named: "deleteMapCategory")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
   
        contentView.addSubview(categoryLabel)
        contentView.addSubview(categoryImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        categoryLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(12)
            $0.centerY.equalTo(contentView)
        }
        
        categoryImage.snp.makeConstraints {
            $0.leading.equalTo(categoryLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(contentView)
            $0.width.height.equalTo(8)
        }
    }
    
    func configure(_ title: String, isSelection: Bool) {
        categoryLabel.text = title
        categoryImage.image = UIImage(named: isSelection ? "deleteCategory" : "addCategory")
        contentView.backgroundColor = isSelection ? .colorF9F8F7 : .colorEAE6E1
    }
}
