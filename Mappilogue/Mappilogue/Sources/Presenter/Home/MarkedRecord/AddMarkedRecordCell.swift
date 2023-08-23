//
//  AddMarkedRecordCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/03.
//

import UIKit

class AddMarkedRecordCell: BaseCollectionViewCell {
    static let registerId = "\(AddMarkedRecordCell.self)"
    
    private let addMarkedRecordButton = UIButton()

    override func setupProperty() {
        super.setupProperty()
        
        contentView.backgroundColor = .colorF5F3F0
        contentView.layer.cornerRadius = 12
        
        addMarkedRecordButton.setImage(UIImage(named: "home_addMarkedRecord"), for: .normal)
        addMarkedRecordButton.isUserInteractionEnabled = false
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(addMarkedRecordButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
      
        addMarkedRecordButton.snp.makeConstraints {
            $0.centerX.centerY.equalTo(contentView)
            $0.width.height.equalTo(44)
        }
    }
}
