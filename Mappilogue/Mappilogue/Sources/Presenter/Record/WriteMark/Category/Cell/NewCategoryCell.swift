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
    
    private let categoryTextField = UITextField()
    private let editButton = UIButton()
    private let categoryCountLabel = UILabel()
    private let checkCategoryButton = UIButton()
  
    override func setupProperty() {
        super.setupProperty()
        
        categoryTextField.textColor = .color1C1C1C
        categoryTextField.font = .body02
        categoryTextField.returnKeyType = .done
        categoryTextField.delegate = self
        
        editButton.setImage(UIImage(named: "editCategory"), for: .normal)
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
        
        categoryCountLabel.textColor = .color9B9791
        categoryCountLabel.font = .body02
        
        checkCategoryButton.setImage(UIImage(named: "unCheck"), for: .normal)
        checkCategoryButton.addTarget(self, action: #selector(checkCategoryButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(categoryTextField)
        contentView.addSubview(editButton)
        contentView.addSubview(categoryCountLabel)
        contentView.addSubview(checkCategoryButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        categoryTextField.snp.makeConstraints {
            $0.centerY.leading.equalTo(contentView)
        }
        
        editButton.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(categoryTextField.snp.trailing).offset(4)
            $0.width.equalTo(12)
            $0.height.equalTo(11)
        }
        
        categoryCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.leading.equalTo(editButton.snp.trailing).offset(8)
        }
        
        checkCategoryButton.snp.makeConstraints {
            $0.centerY.trailing.equalTo(contentView)
            $0.width.height.equalTo(24)
        }
    }
    
    func configure(with category: CategoryData) {
        categoryTextField.text = category.title
        categoryCountLabel.text = "(\(category.count))"
    }
    
    @objc func editButtonTapped(_ button: UIButton) {
        isTextFiledEditMode = !isTextFiledEditMode
        categoryTextField.becomeFirstResponder()
    }
    
    @objc func checkCategoryButtonTapped(_ button: UIButton) {
        button.isSelected = !button.isSelected
        button.setImage(UIImage(named: button.isSelected ? "check" : "unCheck"), for: .normal)
    }
}

extension NewCategoryCell: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return isTextFiledEditMode ? true : false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
