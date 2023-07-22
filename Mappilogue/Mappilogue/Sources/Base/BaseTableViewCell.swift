//
//  BaseTableViewCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/30.
//

import UIKit
import SnapKit

class BaseTableViewCell: UITableViewCell, BaseViewProtocol {

    override func awakeFromNib() {
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        backgroundColor = .colorF9F8F7
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    func setupProperty() {}
    
    func setupHierarchy() {}
    
    func setupLayout() {}

}
