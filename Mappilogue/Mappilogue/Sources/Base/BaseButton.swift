//
//  BaseButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/28.
//

import UIKit

class BaseButton: UIButton {
    init() {
        super.init(frame: .zero)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {}
    
    func setupHierarchy() {}
    
    func setupLayout() {}
}
