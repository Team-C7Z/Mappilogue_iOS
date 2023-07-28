//
//  NewCategoryCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/28.
//

import UIKit

class NewCategoryCell: BaseCollectionViewCell {
    static let registerId = "\(NewCategoryCell.self)"
    
    private let newCategoryLabel = UILabel()
    private let editImage = UIImageView()
    private let categoryCountLabel = UILabel()
    private let checkCategoryImage = UIImageView()
  
    override func setupProperty() {
        super.setupProperty()
        
        newCategoryLabel.text = "새로운 카테고리"
        newCategoryLabel.textColor = .color1C1C1C
        newCategoryLabel.font = .body02
        
        editImage.image = UIImage(named: "editCategory")
        
        categoryCountLabel.text = "(0)"
        categoryCountLabel.textColor = .color9B9791
        categoryCountLabel.font = .body02
        
        checkCategoryImage.image = UIImage(named: "unCheck")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(newCategoryLabel)
        contentView.addSubview(editImage)
        contentView.addSubview(categoryCountLabel)
        contentView.addSubview(checkCategoryImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        newCategoryLabel.snp.makeConstraints {
            $0.centerY.leading.equalTo(contentView)
        }
        
        editImage.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(newCategoryLabel.snp.trailing).offset(4)
            $0.width.equalTo(12)
            $0.height.equalTo(11)
        }
        
        categoryCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(editImage.snp.trailing).offset(8)
        }
        
        checkCategoryImage.snp.makeConstraints {
            $0.centerY.trailing.equalTo(contentView)
            $0.width.height.equalTo(24)
        }
    }
}
