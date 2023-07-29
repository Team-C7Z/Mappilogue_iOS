//
//  SearchMarkCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/29.
//

import UIKit

class SearchMarkCell: BaseCollectionViewCell {
    static let registerId = "\(SearchMarkCell.self)"
    
    private let markView = UIView()
    private let markImage = UIImageView()
    private let markTitleLabel = UILabel()
    private let markDateLabel = UILabel()
    private let separatorImage = UIImageView()
    private let markLocationLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        markView.layer.cornerRadius = 19 / 2
        markImage.image = UIImage(named: "mark")
        markImage.layer.applyShadow()

        markTitleLabel.textColor = .color1C1C1C
        markTitleLabel.font = .title02
        
        markDateLabel.textColor = .color707070
        markDateLabel.font = .caption01
        
        separatorImage.image = UIImage(named: "separator")
    
        markLocationLabel.textColor = .color707070
        markLocationLabel.font = .caption01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(markView)
        markView.addSubview(markImage)
        contentView.addSubview(markTitleLabel)
        contentView.addSubview(markDateLabel)
        contentView.addSubview(separatorImage)
        contentView.addSubview(markLocationLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()

        markView.snp.makeConstraints {
            $0.leading.centerY.equalTo(contentView)
            $0.width.height.equalTo(19)
        }
        
        markImage.snp.makeConstraints {
            $0.centerX.centerY.equalTo(markView)
            $0.width.equalTo(11)
            $0.height.equalTo(10.2)
        }
        
        markTitleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView)
            $0.leading.equalTo(markView.snp.trailing).offset(8)
        }
        
        markDateLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(24)
            $0.leading.equalTo(markTitleLabel)
        }
        
        separatorImage.snp.makeConstraints {
            $0.centerY.equalTo(markDateLabel)
            $0.leading.equalTo(markDateLabel.snp.trailing).offset(6)
            $0.width.height.equalTo(2)
        }
        
        markLocationLabel.snp.makeConstraints {
            $0.centerY.equalTo(markDateLabel)
            $0.leading.equalTo(separatorImage.snp.trailing).offset(6)
        }
    }
    
    func configure(with mark: Mark) {
        markView.backgroundColor = mark.color
        markTitleLabel.text = mark.title
        markDateLabel.text = mark.date
        markLocationLabel.text = mark.location
    }
}
