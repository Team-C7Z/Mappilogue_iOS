//  CategorySettingCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/02.
//

import UIKit

class CategorySettingCell: BaseTableViewCell {
    static let registerId = "\(CategorySettingCell.self)"
    
    private let categoryImage = UIImageView()
    private let categoryLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        categoryImage.image = UIImage(named: "setting")
        
        categoryLabel.text = "카테고리 설정"
        categoryLabel.textColor = .color707070
        categoryLabel.font = .body02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(categoryImage)
        contentView.addSubview(categoryLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        categoryImage.snp.makeConstraints {
            $0.leading.centerY.equalTo(contentView)
            $0.width.height.equalTo(18)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.leading.equalTo(categoryImage.snp.trailing).offset(8)
            $0.centerY.equalTo(contentView)
        }
    }
}
