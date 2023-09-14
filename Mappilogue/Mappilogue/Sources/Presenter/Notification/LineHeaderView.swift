//
//  LineHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/13.
//

import UIKit

class LineHeaderView: BaseTableViewHeaderFooterView {
    static let registerId = "\(LineHeaderView.self)"
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.backgroundColor = .colorEAE6E1
    }
}
