//
//  AddNewCategoryCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/28.
//

import UIKit

class AddNewCategoryCell: BaseCollectionViewCell {
    static let registerId = "\(AddNewCategoryCell.self)"
    
    private let addCategoryLabel = UILabel()
    private let addCategoryImage = UIImageView()
  
    override func setupProperty() {
        super.setupProperty()
        
        addCategoryLabel.text = "카테고리 추가"
        addCategoryLabel.textColor = .black1C1C1C
        addCategoryLabel.font = .body02
        
        addCategoryImage.image = UIImage(named: "addCategory2")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(addCategoryLabel)
        contentView.addSubview(addCategoryImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        addCategoryLabel.snp.makeConstraints {
            $0.centerY.leading.equalTo(contentView)
        }
        
        addCategoryImage.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView).offset(-1)
            $0.width.height.equalTo(16)
        }
    }
}
