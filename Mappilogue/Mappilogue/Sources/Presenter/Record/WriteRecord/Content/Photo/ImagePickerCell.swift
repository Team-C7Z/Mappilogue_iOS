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
    
    private let cameraImage = UIImageView()
    private let pickerImage = UIImageView()
    
    override func setupProperty() {
        super.setupProperty()

        contentView.backgroundColor = .colorEAE6E1
        contentView.layer.borderColor = UIColor.color2EBD3D.cgColor
        
        cameraImage.image = UIImage(named: "record_camera")
        cameraImage.isHidden = true
        
        pickerImage.contentMode = .scaleAspectFill
        pickerImage.clipsToBounds = true
        options.deliveryMode = .highQualityFormat
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(cameraImage)
        contentView.addSubview(pickerImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        cameraImage.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(52)
            $0.centerX.equalTo(contentView)
            $0.width.equalTo(36)
            $0.height.equalTo(30)
        }
        
        pickerImage.snp.makeConstraints {
            $0.width.height.equalTo(contentView)
        }
    }
    
    func configure(_ asset: PHAsset?, isCamera: Bool, isSelected: Bool) {
        if isCamera {
            cameraImage.isHidden = false
        } else {
            guard let asset = asset else { return }
            
            imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options) { image, _ in
                DispatchQueue.main.async {
                    self.pickerImage.image = image
                    
                    self.contentView.layer.borderWidth = isSelected ? 4 : 0
                }
            }
        }
    }
}
