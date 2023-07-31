//
//  CategoryCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/31.
//

import UIKit

class CategoryCell: BaseCollectionViewCell {
    static let registerId = "\(CategoryCell.self)"

    private let addCategoryImage = UIImageView()
    private let categoryLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        layer.cornerRadius = 17
        layer.applyShadow()
        backgroundColor = .colorF9F8F7
        
        categoryLabel.text = "유진이랑 논 날"
        categoryLabel.textColor = .color1C1C1C
        categoryLabel.font = .caption02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
   
        contentView.addSubview(categoryLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        categoryLabel.snp.makeConstraints {
            $0.center.equalTo(contentView)
        }
    }
    
    func configure(with title: String) {
        categoryLabel.text = title
    }
}
