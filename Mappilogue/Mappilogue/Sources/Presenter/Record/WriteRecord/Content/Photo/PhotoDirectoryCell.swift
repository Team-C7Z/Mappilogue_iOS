//
//  PhotoDirectoryCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/20.
//

import UIKit
import Photos

class PhotoDirectoryCell: BaseCollectionViewCell {
    static let registerId = "\(PhotoDirectoryCell.self)"
    
    let imageManager = PHCachingImageManager()
    let options = PHImageRequestOptions()
    
    private let photoDirectoryImage = UIImageView()
    private let photoDirectoryTitle = UILabel()
    private let photoDirectoryCountLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        photoDirectoryImage.backgroundColor = .gray
    
        photoDirectoryTitle.textColor = .color1C1C1C
        photoDirectoryTitle.font = .body01
        
        photoDirectoryCountLabel.textColor = .colorC9C6C2
        photoDirectoryCountLabel.font = .caption01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(photoDirectoryImage)
        addSubview(photoDirectoryTitle)
        addSubview(photoDirectoryCountLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        photoDirectoryImage.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(8)
            $0.width.height.equalTo(56)
        }
        
        photoDirectoryTitle.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(15)
            $0.leading.equalTo(photoDirectoryImage.snp.trailing).offset(16)
        }
        
        photoDirectoryCountLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(39)
            $0.leading.equalTo(photoDirectoryImage.snp.trailing).offset(16)
        }
    }
    
    func configure(_ mainImage: PHAsset?, title: String, count: Int) {
        if let mainImage = mainImage {
            imageManager.requestImage(for: mainImage, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options) { imag, _ in
                self.photoDirectoryImage.image = imag
            }
        }
   
        photoDirectoryTitle.text = title
        photoDirectoryCountLabel.text = "\(count)"
    }
}
