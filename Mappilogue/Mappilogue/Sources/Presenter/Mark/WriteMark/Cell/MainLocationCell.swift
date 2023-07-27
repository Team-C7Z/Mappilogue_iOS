//
//  MainLocationCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class MainLocationCell: BaseTableViewCell {
    static let registerId = "\(MainLocationCell.self)"
    
    private let lineView = UIView()
    private let mainLocationView = MainLocatonView()
    private let locationTitleLabel = UILabel()
    private let moveImage = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        lineView.backgroundColor = .colorEAE6E1
        
        locationTitleLabel.text = "카멜리아힐"
        locationTitleLabel.textColor = .color707070
        locationTitleLabel.font = .body02
        
        moveImage.image = UIImage(named: "moveWrite")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(lineView)
        contentView.addSubview(mainLocationView)
        contentView.addSubview(locationTitleLabel)
        contentView.addSubview(moveImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView)
            $0.height.equalTo(1)
        }
        
        mainLocationView.snp.makeConstraints {
            $0.leading.centerY.equalTo(contentView)
        }
        
        locationTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView).offset(-20)
        }
        
        moveImage.snp.makeConstraints {
            $0.centerY.equalTo(contentView)
            $0.trailing.equalTo(contentView).offset(-1)
            $0.width.equalTo(7)
            $0.height.equalTo(14)
        }
    }
}
