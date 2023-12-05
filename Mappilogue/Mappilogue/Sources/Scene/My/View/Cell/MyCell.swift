//
//  MyCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class MyCell: BaseCollectionViewCell {
    static let registerId = "\(MyCell.self)"
    
    private let myImage = UIImageView()
    private let myLabel = UILabel()
    private let lineView = UIView()
    
    override func setupProperty() {
        super.setupProperty()
        
        myLabel.textColor = .black1C1C1C
        myLabel.font = .body02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(myImage)
        contentView.addSubview(myLabel)
        contentView.addSubview(lineView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        myImage.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(14)
            $0.width.height.equalTo(16)
        }
        
        myLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(14)
            $0.leading.equalTo(myImage.snp.trailing).offset(8.5)
        }
        
        lineView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(contentView)
            $0.height.equalTo(1)
        }
    }
    
    func configure(myInfo: MyInfo, isLast: Bool) {
        myImage.image = UIImage(named: myInfo.image)
        myLabel.text = myInfo.title
        lineView.backgroundColor = isLast ? .clear : .grayEAE6E1
    }
}
