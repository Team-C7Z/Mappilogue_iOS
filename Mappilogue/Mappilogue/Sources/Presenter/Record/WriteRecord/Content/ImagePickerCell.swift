//
//  ImagePickerCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/19.
//

import UIKit

class ImagePickerCell: BaseCollectionViewCell {
    static let registerId = "\(ImagePickerCell.self)"
    
    private let image = UIImageView()
    
    override func setupProperty() {
        super.setupProperty()
                
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(image)
        
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        image.snp.makeConstraints {
            $0.width.height.equalTo(contentView)
        }
    }
    
    func configure(_ image: UIImage) {
        
    }
    
}
