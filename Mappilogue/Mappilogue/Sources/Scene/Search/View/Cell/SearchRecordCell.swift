//
//  SearchRecordCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/29.
//

import UIKit
import MappilogueKit

class SearchRecordCell: BaseCollectionViewCell {
    static let registerId = "\(SearchRecordCell.self)"
    
    private let markView = MarkView(frame: CGRect(x: 0, y: 0, width: 19, height: 19))
    private let recordTitleLabel = UILabel()
    private let recordDateLabel = UILabel()
    private let separatorImage = UIImageView()
    private let recordLocationLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()

        markView.configure(heartWidth: 11.08, heartHeight: 10.29)
        
        recordTitleLabel.textColor = .black1C1C1C
        recordTitleLabel.font = .title02
        
        recordDateLabel.textColor = .gray707070
        recordDateLabel.font = .caption01
        
        separatorImage.image = Images.image(named: .imageSeparator)
    
        recordLocationLabel.textColor = .gray707070
        recordLocationLabel.font = .caption01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(markView)
        contentView.addSubview(recordTitleLabel)
        contentView.addSubview(recordDateLabel)
        contentView.addSubview(separatorImage)
        contentView.addSubview(recordLocationLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()

        markView.snp.makeConstraints {
            $0.leading.centerY.equalTo(contentView)
            $0.width.height.equalTo(19)
        }
        
        recordTitleLabel.snp.makeConstraints {
            $0.top.trailing.equalTo(contentView)
            $0.leading.equalTo(markView.snp.trailing).offset(8)
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
        markView.backgroundColor = record.color
        recordTitleLabel.text = record.title
        recordDateLabel.text = record.date
        recordLocationLabel.text = record.location
    }
}
