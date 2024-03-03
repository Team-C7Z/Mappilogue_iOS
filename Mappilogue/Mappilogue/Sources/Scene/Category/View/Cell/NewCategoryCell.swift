//
//  NewCategoryCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/28.
//

import UIKit
import MappilogueKit

class NewCategoryCell: BaseCollectionViewCell {
    static let registerId = "\(NewCategoryCell.self)"
    
    private var isTextFiledEditMode: Bool = false
    
    private let categoryLabel = UITextField()
    private let categoryCountLabel = UILabel()
    private let checkCategoryButton = UIButton()
  
    override func setupProperty() {
        super.setupProperty()
        
        categoryLabel.autocorrectionType = .no
        categoryLabel.spellCheckingType = .no
        categoryLabel.textColor = .black1C1C1C
        categoryLabel.font = .body02
        categoryLabel.returnKeyType = .done
        categoryLabel.tintColor = .green2EBD3D
        
        categoryCountLabel.textColor = .gray9B9791
        categoryCountLabel.font = .body02
        
        checkCategoryButton.setImage(Images.image(named: .buttonUncheck), for: .normal)
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
    
    func configure(with category: Category) {
        categoryLabel.text = category.title
        categoryCountLabel.text = "(\(category.markCount))"
    }
    
    @objc func checkCategoryButtonTapped(_ button: UIButton) {
        button.isSelected = !button.isSelected
        button.setImage(Images.image(named: button.isSelected ? .buttonCheck : .buttonUncheck), for: .normal)
    }
}
