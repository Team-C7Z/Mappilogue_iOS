//
//  DeleteLocationCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/17.
//

import UIKit

class DeleteLocationCell: BaseTableViewCell {
    static let registerId = "\(DeleteLocationCell.self)"
    
    private let deleteSelectedButton = UIButton()
    private let deleteSelectedImage = UIImageView()
    private let deleteSelectedLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        deleteSelectedImage.image = UIImage(named: "deleteLocation")
        deleteSelectedLabel.text = "선택삭제"
        deleteSelectedLabel.textColor = .color707070
        deleteSelectedLabel.font = .body02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(deleteSelectedButton)
        deleteSelectedButton.addSubview(deleteSelectedImage)
        deleteSelectedButton.addSubview(deleteSelectedLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        deleteSelectedButton.snp.makeConstraints {
            $0.top.trailing.equalTo(contentView)
            $0.width.equalTo(71)
            $0.height.equalTo(32)
        }
        
        deleteSelectedImage.snp.makeConstraints {
            $0.trailing.equalTo(deleteSelectedLabel.snp.leading).offset(-6)
            $0.centerY.equalTo(deleteSelectedButton)
        }
        
        deleteSelectedLabel.snp.makeConstraints {
            $0.trailing.centerY.equalTo(deleteSelectedButton)
        }
    }
}
