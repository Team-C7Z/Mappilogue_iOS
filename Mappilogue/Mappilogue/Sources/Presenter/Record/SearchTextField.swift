//
//  SearchTextField.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/29.
//

import UIKit

class SearchTextField: UITextField {
    private let searchImage = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupProperty() {
        placeholder = "장소 또는 기록 검색"
        addLeftPadding()
        layer.cornerRadius = 12
        layer.applyShadow()
        backgroundColor = .colorF9F8F7
        font = .body01
        returnKeyType = .search
        
        searchImage.image = UIImage(named: "record_search")
    }
    
    private func setupHierarchy() {
        addSubview(searchImage)
    }
    
    private func setupLayout() {
        searchImage.snp.makeConstraints {
            $0.trailing.equalTo(self).offset(-7)
            $0.centerY.equalTo(self)
            $0.width.height.equalTo(28)
        }
    }
}
