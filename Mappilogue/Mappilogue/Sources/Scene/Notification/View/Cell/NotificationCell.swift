//
//  NotificationCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/13.
//

import UIKit

class NotificationCell: BaseTableViewCell {
    static let registerId = "\(NotificationCell.self)"
    
    var index: Int = 0
    var onRemove: ((Int) -> Void)?
    
    private let colorView = UIView()
    private let dateLabel = UILabel()
    private let timeLabel = UILabel()
    private let titleLabel = UILabel()
    private let removeButton = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        colorView.layer.cornerRadius = 2

        dateLabel.textColor = .black1C1C1C
        dateLabel.font = .caption02
        
        timeLabel.textColor = .black1C1C1C
        timeLabel.font = .caption02
        
        titleLabel.textColor = .color000000
        titleLabel.font = .body02
        
        removeButton.setImage(UIImage(named: "notification_remove"), for: .normal)
        removeButton.addTarget(self, action: #selector(removeButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        contentView.addSubview(colorView)
        contentView.addSubview(dateLabel)
        contentView.addSubview(timeLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(removeButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        colorView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(20)
            $0.width.height.equalTo(14)
        }
        
        dateLabel.snp.makeConstraints {
            $0.centerY.equalTo(colorView)
            $0.leading.equalTo(colorView.snp.trailing).offset(8)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(dateLabel)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(3)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(46)
            $0.leading.equalTo(contentView)
        }
        
        removeButton.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(16)
            $0.trailing.equalTo(contentView)
            $0.width.height.equalTo(22)
        }
    }
    
    func configure(_ notification: NotificationData, index: Int) {
        self.index = index
        
        colorView.backgroundColor = notification.color
        dateLabel.text = notification.date
        timeLabel.text = notification.time
        titleLabel.text = notification.text
    }
    
    @objc func removeButtonTapped() {
        onRemove?(index)
    }
}
