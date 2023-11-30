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
        
        onboardingImage.contentMode = .scaleAspectFit
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
            $0.edges.equalTo(contentView)
        }
    }
    
    func configure(with image: String) {
        onboardingImage.image = UIImage(named: image)
        onboardingImage.layer.cornerRadius = 20
    }
}
