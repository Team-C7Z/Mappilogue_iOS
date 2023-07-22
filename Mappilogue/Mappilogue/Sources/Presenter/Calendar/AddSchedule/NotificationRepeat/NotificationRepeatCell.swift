//
//  NotificationRepeatCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class NotificationRepeatCell: BaseTableViewCell {
    static let registerId = "\(NotificationRepeatCell.self)"
    
    private let notificationRepeatView = UIView()
    private let image = UIImageView()
    private let label = UILabel()
    private let moveImage = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()

        contentView.backgroundColor = .colorEAE6E1
        
        notificationRepeatView.backgroundColor = .colorF9F8F7
        
        label.textColor = .color707070
        label.font = .body02
        
        moveImage.image = UIImage(named: "move")
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
    
        contentView.addSubview(notificationRepeatView)
        notificationRepeatView.addSubview(image)
        notificationRepeatView.addSubview(label)
        notificationRepeatView.addSubview(moveImage)
    }
    
    override func setupLayout() {
        super.setupLayout()

        notificationRepeatView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(1)
            $0.leading.bottom.trailing.equalTo(contentView)
        }
        
        image.snp.makeConstraints {
            $0.leading.equalTo(notificationRepeatView).offset(0.5)
            $0.centerY.equalTo(notificationRepeatView)
            $0.width.height.equalTo(16)
        }
        
        label.snp.makeConstraints {
            $0.leading.equalTo(image.snp.trailing).offset(8)
            $0.centerY.equalTo(notificationRepeatView)
        }
        
        moveImage.snp.makeConstraints {
            $0.trailing.centerY.equalTo(notificationRepeatView)
        }
    }
    
    func configure(imageName: String, title: String) {
        image.image = UIImage(named: imageName)
        label.text = title
    }
}
