//
//  BaseCollectionReusableView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/28.
//

import UIKit

class BaseCollectionReusableView: UICollectionReusableView, BaseViewProtocol {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func setupProperty() {}
    
    func setupHierarchy() {}
    
    func setupLayout() {}
    
}
