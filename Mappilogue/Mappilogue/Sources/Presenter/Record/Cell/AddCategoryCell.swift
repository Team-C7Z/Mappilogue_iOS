//
//  AddCategoryCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/31.
//

import UIKit

class AddCategoryCell: BaseCollectionViewCell {
    static let registerId = "\(AddCategoryCell.self)"

    private let addCategoryImage = UIImageView()
    private let addCategoryLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        layer.cornerRadius = 17
        layer.applyShadow()
        backgroundColor = .colorF9F8F7
        
        addCategoryImage.image = UIImage(named: "addCategory")
        addCategoryLabel.text = "카테고리 추가"
        addCategoryLabel.textColor = .color1C1C1C
        addCategoryLabel.font = .caption02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
   
        contentView.addSubview(addCategoryImage)
        contentView.addSubview(addCategoryLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        addCategoryImage.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(12)
            $0.width.height.equalTo(10)
        }
        
        addCategoryLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(addCategoryImage.snp.trailing).offset(8)
        }
    }
}
