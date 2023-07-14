//
//  ColorCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/14.
//

import UIKit

class ColorCell: BaseCollectionViewCell {
    static let registerId = "\(ColorCell.self)"

    override func setupProperty() {
        super.setupProperty()
        
        contentView.layer.cornerRadius = 6
    }
    
    func configure(color: UIColor) {
        contentView.backgroundColor = color
    }
}
