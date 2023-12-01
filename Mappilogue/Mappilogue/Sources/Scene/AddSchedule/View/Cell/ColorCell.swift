//
//  ColorCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/14.
//

import UIKit

class ColorCell: BaseCollectionViewCell {
    static let registerId = "\(ColorCell.self)"
    
    private let selectedColorImage = UIImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
  
        selectedColorImage.image = nil
        selectedColorImage.tintColor = .black1C1C1C
    }

    override func setupProperty() {
        super.setupProperty()
        
        contentView.layer.cornerRadius = 6
        
        selectedColorImage.contentMode = .scaleAspectFill
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(selectedColorImage)
    }

    override func setupLayout() {
        super.setupLayout()
        
        selectedColorImage.snp.makeConstraints {
            $0.centerX.centerY.equalTo(contentView)
            $0.width.equalTo(14)
            $0.height.equalTo(8)
        }
    }
    
    func configure(with color: UIColor, isColorSelected: Bool) {
        contentView.backgroundColor = color
        if color == .gray9B9791 || color == .gray404040 {
            selectedColorImage.tintColor = .whiteFFFFFF
        } else {
            selectedColorImage.tintColor = .black1C1C1C
        }
        
        if isColorSelected {
            selectedColorImage.image = UIImage(named: "selectedColor")
        }
    }
}
