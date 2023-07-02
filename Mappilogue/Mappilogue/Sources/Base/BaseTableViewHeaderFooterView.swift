//
//  BaseTableViewHeaderFooterView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/30.
//

import UIKit

class BaseTableViewHeaderFooterView: UITableViewHeaderFooterView, BaseViewProtocol {
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {}
    
    func setupHierarchy() {}
    
    func setupLayout() {}

}
