//
//  OnboardingCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/05.
//

import UIKit

class OnboardingCell: BaseCollectionViewCell {
    static let registerId = "\(OnboardingCell.self)"
    
    private let onboardingImage = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        onboardingImage.contentMode = .scaleToFill
        onboardingImage.layer.cornerRadius = 20
        onboardingImage.clipsToBounds = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(onboardingImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        onboardingImage.snp.makeConstraints {
            $0.top.bottom.equalTo(contentView)
            $0.leading.equalTo(contentView).offset(68)
            $0.trailing.equalTo(contentView).offset(-68)
        }
    }
    
    func configure(with image: String) {
        onboardingImage.image = UIImage(named: image)
        onboardingImage.layer.cornerRadius = 20
    }
}
