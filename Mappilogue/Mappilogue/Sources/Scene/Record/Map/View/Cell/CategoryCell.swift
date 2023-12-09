//
//  CategoryCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/31.
//

import UIKit

class CategoryCell: BaseCollectionViewCell {
    static let registerId = "\(CategoryCell.self)"

    private let categoryLabel = UILabel()
    private let xCategoryButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()
        
        layer.cornerRadius = 17
        layer.applyShadow()
        
        categoryLabel.text = "유진이랑 논 날"
        categoryLabel.textColor = .black1C1C1C
        categoryLabel.font = .caption02
        
        xCategoryButton.setImage(UIImage(named: "record_deleteCategoryMark"), for: .normal)
        xCategoryButton.isHidden = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
   
        contentView.addSubview(categoryLabel)
        contentView.addSubview(xCategoryButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        categoryLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(12)
        }
        
        xCategoryButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView).offset(-7)
            $0.width.height.equalTo(19)
        }
    }
    
    func configure(_ title: String, isSelected: Bool) {
        categoryLabel.text = title
        
        backgroundColor = isSelected ? .grayEAE6E1 : .grayF9F8F7
        xCategoryButton.isHidden = !isSelected
        
//        let categoryLabelSize = categoryLabel.sizeThatFits(CGSize(width: categoryLabel.bounds.width, height: CGFloat.greatestFiniteMagnitude))
//        let cellWidth = categoryLabelSize.width + 12 + 12
//        frame.size.width = cellWidth
//        frame.size.height = 32
    }
}
