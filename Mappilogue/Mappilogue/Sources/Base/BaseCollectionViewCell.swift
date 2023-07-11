//
//  BaseCollectionViewCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/27.
//

import UIKit

class BaseCollectionViewCell: UICollectionViewCell, BaseViewProtocol {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
      
    func setupProperty() {}
    
    func setupHierarchy() {}
    
    func setupLayout() {}
}
