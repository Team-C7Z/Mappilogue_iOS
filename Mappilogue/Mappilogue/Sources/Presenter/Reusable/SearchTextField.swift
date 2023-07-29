//
//  SearchTextField.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/29.
//

import UIKit

class SearchTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.cornerRadius = 12
        backgroundColor = .colorF5F3F0
        placeholder = "장소 또는 기록 검색"
        font = .body01
        addLeftPadding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
