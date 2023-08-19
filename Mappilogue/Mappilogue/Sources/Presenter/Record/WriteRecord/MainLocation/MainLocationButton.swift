//
//  MainLocationButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class MainLocationButton: BaseButton {
    private let mainLocationView = MainLocatonView()
    private let locationTitleLabel = UILabel()
    private let moveImage = UIImageView()
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .colorF9F8F7
        
        locationTitleLabel.textColor = .color707070
        locationTitleLabel.font = .body02
        
        moveImage.image = UIImage(named: "moveWrite")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        addSubview(mainLocationView)
        addSubview(locationTitleLabel)
        addSubview(moveImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }

        mainLocationView.snp.makeConstraints {
            $0.leading.centerY.equalTo(self)
        }
        
        locationTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.trailing.equalTo(self).offset(-20)
        }
        
        moveImage.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.trailing.equalTo(self).offset(-1)
            $0.width.equalTo(7)
            $0.height.equalTo(14)
        }
    }
    
    func configure(_ title: String) {
        locationTitleLabel.text = title
    }
}
