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

        contentView.layer.borderColor = UIColor.green2EBD3D.cgColor
        
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
    
    func configure(_ asset: PHAsset, isSelected: Bool) {
        let size = CGSize(width: self.frame.width * UIScreen.main.scale, height: self.frame.height * UIScreen.main.scale)
        
        imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: options) { image, _ in
            DispatchQueue.main.async {
                self.pickerImage.image = image
            }
        }
        
        contentView.layer.borderWidth = isSelected ? 4 : 0

    }
}
