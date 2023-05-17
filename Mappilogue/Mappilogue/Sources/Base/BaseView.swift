//
//  BaseView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/05/17.
//

import UIKit

protocol BaseViewProtocol {
    func setupProperty()
    func setupHierarchy()
    func setupLayout()
}

class BaseView: UIView, BaseViewProtocol {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
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
