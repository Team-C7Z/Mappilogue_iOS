//
//  CategorySelectionLabelCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/04.
//

import UIKit

class CategorySelectionLabelCell: BaseCollectionViewCell {
    static let registerId = "\(CategorySelectionLabelCell.self)"

    private let mapCategoryLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        mapCategoryLabel.text = "지도에서 표시할 카테고리"
        mapCategoryLabel.textColor = .gray707070
        mapCategoryLabel.font = .caption01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
   
        contentView.addSubview(mapCategoryLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        mapCategoryLabel.snp.makeConstraints {
            $0.top.leading.equalTo(contentView)
        }
    }
}
