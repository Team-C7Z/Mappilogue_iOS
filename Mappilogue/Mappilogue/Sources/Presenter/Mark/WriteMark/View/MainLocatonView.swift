//
//  MainLocatonView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class MainLocatonView: BaseView {
    private let mainLocationImage = UIImageView()
    private let mainLocationLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        layer.cornerRadius = 14
        backgroundColor = .color2EBD3D
        
        mainLocationImage.image = UIImage(named: "mainLocation")
        
        mainLocationLabel.text = "대표 위치"
        mainLocationLabel.textColor = .colorFFFFFF
        mainLocationLabel.font = .caption02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(mainLocationImage)
        addSubview(mainLocationLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.width.equalTo(87)
            $0.height.equalTo(28)
        }
        
        mainLocationImage.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.leading.equalTo(self).offset(10)
            $0.width.equalTo(14)
            $0.height.equalTo(18)
        }
        
        mainLocationLabel.snp.makeConstraints {
            $0.centerY.equalTo(self)
            $0.leading.equalTo(mainLocationImage.snp.trailing).offset(8)
        }
    }
}
