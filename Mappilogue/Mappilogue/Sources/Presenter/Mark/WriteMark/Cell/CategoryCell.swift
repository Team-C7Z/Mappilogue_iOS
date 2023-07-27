//
//  CategoryCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class CategoryCell: BaseTableViewCell {
    static let registerId = "\(CategoryCell.self)"

    let cateogoryLabel = UILabel()
    private let moveImage = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        cateogoryLabel.text = "카테고리"
        cateogoryLabel.textColor = .color1C1C1C
        cateogoryLabel.font = .body02
 
        moveImage.image = UIImage(named: "moveWrite")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(cateogoryLabel)
        contentView.addSubview(moveImage)

    }
    
    override func setupLayout() {
        super.setupLayout()
        
        cateogoryLabel.snp.makeConstraints {
            $0.bottom.equalTo(contentView).offset(-10)
            $0.leading.equalTo(contentView)
        }
        
        moveImage.snp.makeConstraints {
            $0.trailing.equalTo(contentView).offset(-1)
            $0.bottom.equalTo(contentView).offset(-13)
            $0.width.equalTo(7)
            $0.height.equalTo(14)
        }
    }
}
