//
//  SearchRecordCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/29.
//

import UIKit

class SearchRecordCell: BaseCollectionViewCell {
    static let registerId = "\(SearchRecordCell.self)"
    
    private let recordView = UIView()
    private let recordImage = UIImageView()
    private let recordTitleLabel = UILabel()
    private let recordDateLabel = UILabel()
    private let separatorImage = UIImageView()
    private let recordLocationLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        recordView.layer.cornerRadius = 19 / 2
        recordImage.image = UIImage(named: "record")
        recordImage.layer.applyShadow()

        recordTitleLabel.textColor = .color1C1C1C
        recordTitleLabel.font = .title02
        
        recordDateLabel.textColor = .color707070
        recordDateLabel.font = .caption01
        
        separatorImage.image = UIImage(named: "separator")
    
        recordLocationLabel.textColor = .color707070
        recordLocationLabel.font = .caption01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(recordView)
        recordView.addSubview(recordImage)
        contentView.addSubview(recordTitleLabel)
        contentView.addSubview(recordDateLabel)
        contentView.addSubview(separatorImage)
        contentView.addSubview(recordLocationLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()

        recordView.snp.makeConstraints {
            $0.leading.centerY.equalTo(contentView)
            $0.width.height.equalTo(19)
        }
        
        recordImage.snp.makeConstraints {
            $0.centerX.centerY.equalTo(recordView)
            $0.width.equalTo(11)
            $0.height.equalTo(10.2)
        }
        
        recordTitleLabel.snp.makeConstraints {
            $0.top.trailing.equalTo(contentView)
            $0.leading.equalTo(recordView.snp.trailing).offset(8)
        }
        
        recordDateLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(24)
            $0.leading.equalTo(recordTitleLabel)
        }
        
        separatorImage.snp.makeConstraints {
            $0.centerY.equalTo(recordDateLabel)
            $0.leading.equalTo(recordDateLabel.snp.trailing).offset(6)
            $0.width.height.equalTo(2)
        }
        
        recordLocationLabel.snp.makeConstraints {
            $0.centerY.equalTo(recordDateLabel)
            $0.leading.equalTo(separatorImage.snp.trailing).offset(6)
        }
    }
    
    func configure(with record: Record) {
        recordView.backgroundColor = record.color
        recordTitleLabel.text = record.title
        recordDateLabel.text = record.date
        recordLocationLabel.text = record.location
    }
}
