//
//  ContentImageCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/09.
//

import UIKit

class ContentImageCell: BaseCollectionViewCell {
    static let registerId = "\(ContentImageCell.self)"
    
    private let contentImageView = UIImageView()
    private let removeImageButton = UIButton()
    private let mainImageButton = UIButton()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    override func setupProperty() {
        super.setupProperty()
    
        contentView.layer.cornerRadius = 12
        contentView.layer.borderColor = UIColor.color2EBD3D.cgColor
        
        removeImageButton.setImage(UIImage(named: "record_removeImage"), for: .normal)
        
        mainImageButton.layer.cornerRadius = 23 / 2
        mainImageButton.backgroundColor = .color2EBD3D
        mainImageButton.setTitle("대표", for: .normal)
        mainImageButton.setTitleColor(.colorFFFFFF, for: .normal)
        mainImageButton.titleLabel?.font = .caption03
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        addSubview(contentImageView)
        addSubview(removeImageButton)
        addSubview(mainImageButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        contentImageView.snp.makeConstraints {
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
    
    func configure(_ image: UIImage, isMain: Bool, isSelected: Bool) {
        
    }
}
