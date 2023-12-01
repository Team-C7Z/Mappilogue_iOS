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
    private let lineViewTop = UIView()
    private let lineViewBottom = UIView()
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .grayF9F8F7
        
        locationTitleLabel.textColor = .gray707070
        locationTitleLabel.font = .body02
        
        moveImage.image = UIImage(named: "moveWrite")
        
        lineViewTop.backgroundColor = .grayEAE6E1
        lineViewBottom.backgroundColor = .grayEAE6E1
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        addSubview(lineViewTop)
        addSubview(mainLocationView)
        addSubview(locationTitleLabel)
        addSubview(moveImage)
        addSubview(lineViewBottom)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        lineViewTop.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self)
            $0.height.equalTo(1)
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
        
        lineViewBottom.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(self)
            $0.height.equalTo(1)
        }

    }
    
    func configure(_ title: String) {
        locationTitleLabel.text = title
    }
}
