//
//  SearchTextField.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/04.
//

import UIKit

public class SearchTextField: UITextField {
    private let searchImage = UIImageView()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupProperty() {
        autocorrectionType = .no
        spellCheckingType = .no
        
        placeholder = "장소 또는 기록 검색"
        addLeftPadding()
        layer.cornerRadius = 12
        layer.applyShadow()
        backgroundColor = .grayF9F8F7
        tintColor = .green2EBD3D
        font = .body01
        returnKeyType = .search
        
        searchImage.image = Images.image(named: .imageSearch)
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
