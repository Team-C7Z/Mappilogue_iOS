//
//  CategoryView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class CategoryButton: BaseButton {
    let cateogoryLabel = UILabel()
    private let moveImage = UIImageView()
    private let lineView = UIView()
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .grayF9F8F7
        
        cateogoryLabel.text = "카테고리"
        cateogoryLabel.textColor = .black1C1C1C
        cateogoryLabel.font = .body02
 
        moveImage.image = UIImage(named: "moveWrite")
        
        lineView.backgroundColor = .grayEAE6E1
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(cateogoryLabel)
        addSubview(moveImage)
        addSubview(lineView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(41)
        }
        
        cateogoryLabel.snp.makeConstraints {
            $0.bottom.equalTo(self).offset(-10)
            $0.leading.equalTo(self)
        }
        
        moveImage.snp.makeConstraints {
            $0.trailing.equalTo(self).offset(-1)
            $0.bottom.equalTo(self).offset(-13)
            $0.width.equalTo(7)
            $0.height.equalTo(14)
        }
        
        lineView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(self)
            $0.height.equalTo(1)
        }
    }
}
