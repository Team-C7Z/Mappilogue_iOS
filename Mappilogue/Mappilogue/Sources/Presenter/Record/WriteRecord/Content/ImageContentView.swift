//
//  ImageContentView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/21.
//

import UIKit
import Photos

class ImageContentView: BaseView {
    var index: Int = 0
    var onRemoveImage: ((Int) -> Void)?
    
    private let contentImageButton = UIButton()
    private let contentImage = UIImageView()
    private let mainImageButton = UIButton()
    private let removeImageButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .colorF9F8F7
        
        contentImageButton.addTarget(self, action: #selector(contentImageButtonTapped), for: .touchUpInside)
        contentImageButton.layer.borderColor = UIColor.color2EBD3D.cgColor
        
        mainImageButton.layer.cornerRadius = 14
        mainImageButton.setTitle("대표 사진", for: .normal)
        mainImageButton.titleLabel?.font = .caption02
        mainImageButton.setTitleColor(.colorFFFFFF, for: .normal)
        mainImageButton.isHidden = true
        mainImageButton.addTarget(self, action: #selector(mainImageButtonTapped), for: .touchUpInside)
        
        removeImageButton.setImage(UIImage(named: "record_removeImage"), for: .normal)
        removeImageButton.isHidden = true
        removeImageButton.addTarget(self, action: #selector(removeImageButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(contentImageButton)
        contentImageButton.addSubview(contentImage)
        contentImageButton.addSubview(mainImageButton)
        contentImageButton.addSubview(removeImageButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(227+16)
        }
        
        contentImageButton.snp.makeConstraints {
            $0.leading.top.trailing.equalTo(self)
            $0.bottom.equalTo(self).offset(-16)
        }
        
        contentImage.snp.makeConstraints {
            $0.edges.equalTo(contentImageButton)
        }
        
        mainImageButton.snp.makeConstraints {
            $0.top.equalTo(contentImageButton).offset(12)
            $0.leading.equalTo(contentImageButton).offset(12)
            $0.width.equalTo(65)
            $0.height.equalTo(28)
        }
        
        removeImageButton.snp.makeConstraints {
            $0.top.equalTo(contentImageButton).offset(9)
            $0.trailing.equalTo(contentImageButton).offset(-12)
            $0.width.height.equalTo(34)
        }
    }
    
    func configure(_ index: Int, asset: PHAsset) {
        self.index = index
        displaySelectedImages(asset: asset)
    }
    
    func configureMainImage(_ isMain: Bool) {
        updateMainImageDesign(isMain)
    }
    
    private func displaySelectedImages(asset: PHAsset) {
        convertPHAssetToUIImage(asset) { image in
            self.contentImage.image = image
        }
    }
    
    private func convertPHAssetToUIImage(_ asset: PHAsset, completion: @escaping (UIImage?) -> Void) {
        let imageManager = PHImageManager.default()
        let options = PHImageRequestOptions()
        
        imageManager.requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .aspectFit, options: options) { image, _ in
            completion(image)
        }
    }
    
    @objc func contentImageButtonTapped(_ button: UIButton) {
        button.isSelected.toggle()
    
        contentImageButton.layer.borderWidth = button.isSelected ? 4 : 0
        mainImageButton.isHidden = !button.isSelected
        removeImageButton.isHidden = !button.isSelected
        updateMainImageDesign(button.isSelected)
    }
    
    @objc func mainImageButtonTapped(_ button: UIButton) {
        updateMainImageDesign(button.isSelected)
        
        button.isSelected.toggle()
    }
    
    func updateMainImageDesign(_ isMain: Bool) {
        mainImageButton.backgroundColor = isMain ? .color2EBD3D : .colorEAE6E1
    }
    
    @objc func removeImageButtonTapped(_ button: UIButton) {
        onRemoveImage?(index)
    }
}
