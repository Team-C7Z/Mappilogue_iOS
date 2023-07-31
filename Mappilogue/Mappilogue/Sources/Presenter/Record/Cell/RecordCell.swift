//
//  RecordCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/30.
//

import UIKit

class RecordCell: BaseCollectionViewCell {
    static let registerId = "\(RecordCell.self)"
    
    private let recordImage = UIImageView()
    private let markView = MarkView(radius: 12, width: 14, height: 13)
    
    private let textView = UIView()
    private let recordTitleLabel = UILabel()
    private let recordDateLabel = UILabel()
    private let separatorImage = UIImageView()
    private let recordLocationLabel = UILabel()
    private let categoryImage = UIImageView()
    private let cateogryLabel = UILabel()
    
    override func prepareForReuse() {
        super.prepareForReuse()
  
        categoryImage.image = nil
        cateogryLabel.text = ""
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        recordImage.backgroundColor = .yellow
        recordImage.layer.cornerRadius = 12
        
        markView.backgroundColor = .red
        
        recordTitleLabel.textColor = .color000000
        recordTitleLabel.font = .title02
        
        recordDateLabel.textColor = .color707070
        recordDateLabel.font = .caption01

        separatorImage.image = UIImage(named: "separator")

        recordLocationLabel.textColor = .color707070
        recordLocationLabel.font = .caption01

        cateogryLabel.textColor = .color707070
        cateogryLabel.font = .caption02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(recordImage)
        recordImage.addSubview(markView)
        
        contentView.addSubview(textView)
        textView.addSubview(recordTitleLabel)
        textView.addSubview(recordDateLabel)
        textView.addSubview(separatorImage)
        textView.addSubview(recordLocationLabel)
        textView.addSubview(categoryImage)
        textView.addSubview(cateogryLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        recordImage.snp.makeConstraints {
            $0.leading.centerY.equalTo(contentView)
            $0.width.height.equalTo(64)
        }
        
        markView.snp.makeConstraints {
            $0.trailing.bottom.equalTo(recordImage).offset(-6)
            $0.width.height.equalTo(24)
        }
        
        textView.snp.makeConstraints {
            $0.leading.equalTo(recordImage.snp.trailing).offset(16)
            $0.centerY.trailing.equalTo(contentView)
        }
        
        recordTitleLabel.snp.makeConstraints {
            $0.top.equalTo(textView)
            $0.leading.trailing.equalTo(textView)
        }
        
        recordDateLabel.snp.makeConstraints {
            $0.top.equalTo(recordTitleLabel.snp.bottom).offset(4)
            $0.leading.equalTo(recordTitleLabel)
        }

        separatorImage.snp.makeConstraints {
            $0.leading.equalTo(recordDateLabel.snp.trailing).offset(6)
            $0.centerY.equalTo(recordDateLabel)
            $0.width.height.equalTo(2)
        }

        recordLocationLabel.snp.makeConstraints {
            $0.leading.equalTo(separatorImage.snp.trailing).offset(6)
            $0.centerY.equalTo(recordDateLabel)
        }

        categoryImage.snp.makeConstraints {
            $0.centerY.equalTo(cateogryLabel)
            $0.leading.equalTo(recordTitleLabel)
            $0.width.height.equalTo(16)
        }

        cateogryLabel.snp.makeConstraints {
            $0.top.equalTo(recordDateLabel.snp.bottom).offset(7)
            $0.leading.equalTo(categoryImage.snp.trailing).offset(6)
            $0.bottom.equalTo(textView)
        }
    }
    
    func configure(with record: Record) {
        markView.backgroundColor = record.color
        recordTitleLabel.text = record.title
        recordDateLabel.text = record.date
        recordLocationLabel.text = record.location
        if let category = record.category {
            categoryImage.image = UIImage(named: "category")
            cateogryLabel.text = category
        }

        contentView.layoutIfNeeded()
    }
}
