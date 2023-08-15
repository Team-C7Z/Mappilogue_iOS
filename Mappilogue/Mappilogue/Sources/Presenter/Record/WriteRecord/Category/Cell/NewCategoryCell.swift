//
//  NewCategoryCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/28.
//

import UIKit

class NewCategoryCell: BaseCollectionViewCell {
    static let registerId = "\(NewCategoryCell.self)"
    
    private var isTextFiledEditMode: Bool = false
    
    private let categoryLabel = UITextField()
    private let categoryCountLabel = UILabel()
    private let checkCategoryButton = UIButton()
  
    override func setupProperty() {
        super.setupProperty()
        
        categoryLabel.textColor = .color1C1C1C
        categoryLabel.font = .body02
        categoryLabel.returnKeyType = .done
        
        categoryCountLabel.textColor = .color9B9791
        categoryCountLabel.font = .body02
        
        checkCategoryButton.setImage(UIImage(named: "common_unCheck"), for: .normal)
        checkCategoryButton.addTarget(self, action: #selector(checkCategoryButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(categoryLabel)
        contentView.addSubview(categoryCountLabel)
        contentView.addSubview(checkCategoryButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        categoryLabel.snp.makeConstraints {
            $0.centerY.leading.equalTo(contentView)
        }
        
        categoryCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(categoryLabel.snp.trailing).offset(4)
        }
        
        checkCategoryButton.snp.makeConstraints {
            $0.centerY.trailing.equalTo(contentView)
            $0.width.height.equalTo(24)
        }
    }
    
    func configure(with category: CategoryData) {
        categoryLabel.text = category.title
        categoryCountLabel.text = "(\(category.count))"
    }
    
    @objc func checkCategoryButtonTapped(_ button: UIButton) {
        button.isSelected = !button.isSelected
        button.setImage(UIImage(named: button.isSelected ? "common_check" : "common_unCheck"), for: .normal)
    }
}
