//
//  ContentImageCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/09.
//

import UIKit
import Photos

class ContentImageCell: BaseCollectionViewCell {
    static let registerId = "\(ContentImageCell.self)"
    
    let imageManager = PHCachingImageManager()
    let options = PHImageRequestOptions()
    
    private var index: Int = -1
    var onRemoveImage: ((Int) -> Void)?
    var onMainImage: ((Int) -> Void)?
    
    private let contentImage = UIImageView()
    private let removeImageButton = UIButton()
    private let mainImageButton = UIButton()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func setupProperty() {
        super.setupProperty()
    
        layer.cornerRadius = 12
        layer.borderColor = UIColor.color2EBD3D.cgColor
        
        contentImage.layer.cornerRadius = 12
        contentImage.contentMode = .scaleAspectFill
        contentImage.layer.masksToBounds = true
        
        removeImageButton.setImage(UIImage(named: "record_removeImage"), for: .normal)
        removeImageButton.addTarget(self, action: #selector(removeImageButtonTapped), for: .touchUpInside)
        
        mainImageButton.layer.cornerRadius = 23 / 2
        mainImageButton.setTitle("대표", for: .normal)
        mainImageButton.setTitleColor(.colorFFFFFF, for: .normal)
        mainImageButton.titleLabel?.font = .caption03
        mainImageButton.addTarget(self, action: #selector(mainImageButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        addSubview(contentImage)
        addSubview(removeImageButton)
        addSubview(mainImageButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        contentImage.snp.makeConstraints {
            $0.edges.equalTo(self)
        }
        
        removeImageButton.snp.makeConstraints {
            $0.top.equalTo(self).offset(4)
            $0.trailing.equalTo(self).offset(-4)
            $0.width.height.equalTo(22)
        }
        
        mainImageButton.snp.makeConstraints {
            $0.leading.equalTo(self).offset(8)
            $0.bottom.equalTo(self).offset(-8)
            $0.width.equalTo(34)
            $0.height.equalTo(23)
        }
    }
    
    func configure(_ asset: PHAsset, index: Int, isMain: Bool, isSelected: Bool) {
        let size = CGSize(width: self.frame.width * UIScreen.main.scale, height: self.frame.height * UIScreen.main.scale)
        
        imageManager.requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: options) { image, _ in
            DispatchQueue.main.async {
                self.contentImage.image = image
            }
        }
        
        self.index = index
        mainImageButton.backgroundColor = isMain ? .color2EBD3D : .colorEAE6E1
        layer.borderWidth = isSelected ? 2 : 0
        removeImageButton.isHidden = !isSelected
    }
    
    @objc func removeImageButtonTapped() {
        onRemoveImage?(index)
    }
    
    @objc func mainImageButtonTapped() {
        onMainImage?(index)
    }
}
