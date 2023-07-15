//
//  NotificationCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/15.
//

import UIKit

class NotificationCell: BaseTableViewCell {
    static let registerId = "\(NotificationCell.self)"
    
    private let notificationTimeLabel = UILabel()
    private let selectedTimeImage = UIImageView()
    
    override func prepareForReuse() {
        super.prepareForReuse()

        selectedTimeImage.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }

    override func setupProperty() {
        super.setupProperty()
    
        notificationTimeLabel.font = .body02
        notificationTimeLabel.textColor = .color1C1C1C
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(notificationTimeLabel)
        contentView.addSubview(selectedTimeImage)
    }

    override func setupLayout() {
        super.setupLayout()
        
        notificationTimeLabel.snp.makeConstraints {
            $0.leading.centerY.equalTo(contentView)
        }
        
        selectedTimeImage.snp.makeConstraints {
            $0.trailing.centerY.equalTo(contentView)
            $0.width.height.equalTo(25)
        }
    }
    
    func configure(with title: String, isSelect: Bool) {
        notificationTimeLabel.text = title
        
        if isSelect {
            selectedTimeImage.image = UIImage(named: "completion")
        }
    }
}
