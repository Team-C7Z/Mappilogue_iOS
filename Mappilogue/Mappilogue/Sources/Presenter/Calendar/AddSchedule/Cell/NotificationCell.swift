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
    
    override func prepareForReuse() {
        super.prepareForReuse()

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
    }

    override func setupLayout() {
        super.setupLayout()
        
        notificationTimeLabel.snp.makeConstraints {
            $0.leading.centerY.equalTo(contentView)
        }
    }
    
    func configure(with title: String) {
        notificationTimeLabel.text = title
    }
}
