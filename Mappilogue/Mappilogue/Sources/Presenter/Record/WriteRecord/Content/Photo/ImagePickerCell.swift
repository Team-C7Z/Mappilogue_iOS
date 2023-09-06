//
//  ImagePickerCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/19.
//

import UIKit
import Photos

class ImagePickerCell: BaseCollectionViewCell {
    static let registerId = "\(ImagePickerCell.self)"
    
    let imageManager = PHCachingImageManager()
    let options = PHImageRequestOptions()
    
    private let pickerImage = UIImageView()
    
    override func setupProperty() {
        super.setupProperty()

        contentView.layer.borderColor = UIColor.color2EBD3D.cgColor
        
        pickerImage.contentMode = .scaleAspectFill
        pickerImage.clipsToBounds = true
        options.deliveryMode = .highQualityFormat
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(pickerImage)
        
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        pickerImage.snp.makeConstraints {
            $0.width.height.equalTo(contentView)
        }
    }
    
    func configure(_ image: PHAsset, isSelected: Bool) {
        imageManager.requestImage(for: image, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options) { imag, _ in
            DispatchQueue.main.async {
                self.pickerImage.image = imag
            }
        }
        
        contentView.layer.borderWidth = isSelected ? 4 : 0
    }
}
