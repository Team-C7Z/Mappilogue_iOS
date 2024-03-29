//
//  ImagePickerCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/19.
//

import UIKit
import Photos
import MappilogueKit

class ImagePickerCell: BaseCollectionViewCell {
    static let registerId = "\(ImagePickerCell.self)"
    
    let imageManager = PHCachingImageManager()
    let options = PHImageRequestOptions()
    
    private let cameraImage = UIImageView()
    private let pickerImage = UIImageView()
    private let countView = UIView()
    private let countLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()

        contentView.backgroundColor = .grayEAE6E1
        contentView.layer.borderColor = UIColor.green2EBD3D.cgColor
        
        cameraImage.image = UIImage(named: "record_camera")
        cameraImage.isHidden = true
        
        pickerImage.contentMode = .scaleAspectFill
        pickerImage.clipsToBounds = true
        options.deliveryMode = .highQualityFormat
        
        countLabel.textColor = .whiteFFFFFF
        countLabel.font = .title02
        
        countView.backgroundColor = .green2EBD3D
        countView.layer.cornerRadius = 12
        countView.isHidden = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(cameraImage)
        contentView.addSubview(pickerImage)
        contentView.addSubview(countView)
        countView.addSubview(countLabel)
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
        
        countView.snp.makeConstraints {
            $0.top.leading.equalTo(pickerImage).offset(12)
            $0.width.height.equalTo(24)
        }
        
        countLabel.snp.makeConstraints {
            $0.center.equalTo(countView)
        }
    }
    
    func configure(_ asset: PHAsset?, isSelected: Bool, count: Int?) {
        let size = CGSize(width: self.frame.width * UIScreen.main.scale, height: self.frame.height * UIScreen.main.scale)
        
        if let asset {
            imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: options) { image, _ in
                DispatchQueue.main.async {
                    self.pickerImage.image = image
                }
            }
        } else {
            pickerImage.image = Images.image(named: .buttonCamera)
        }
        
        countView.isHidden = !isSelected
        if let count {
            countLabel.text = "\(count)"
        } else {
            countView.isHidden = true
        }
        contentView.layer.borderWidth = isSelected ? 4 : 0
    }
}
