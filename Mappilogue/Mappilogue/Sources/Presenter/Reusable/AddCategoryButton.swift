//
//  AddCategoryButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/24.
//

import UIKit

class AddCategoryButton: UIButton {
    let addCategoryImage = UIImageView()
    let addCategoryLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        setupButton()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
        setupHierarchy()
        setupLayout()
    }
    
    private func setupButton() {
        layer.cornerRadius = 16
        layer.applyShadow()
        backgroundColor = .colorF9F8F7
        
        addCategoryImage.image = UIImage(named: "addCategory")
        addCategoryLabel.text = "카테고리 추가"
        addCategoryLabel.textColor = .color1C1C1C
        addCategoryLabel.font = .caption02
    }
    
    private func setupHierarchy() {
        addSubview(addCategoryImage)
        addSubview(addCategoryLabel)
    }
    
    private func setupLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(108)
            $0.height.equalTo(32)
        }
        
        addCategoryImage.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.leading.equalTo(self).offset(12)
            $0.width.height.equalTo(10)
        }
        
        addCategoryLabel.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.leading.equalTo(addCategoryImage.snp.trailing).offset(8)
        }
    }
}
