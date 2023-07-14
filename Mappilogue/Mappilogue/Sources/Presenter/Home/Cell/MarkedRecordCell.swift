//
//  MarkedRecordCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/03.
//

import UIKit

class MarkedRecordCell: BaseCollectionViewCell {
    static let registerId = "\(MarkedRecordCell.self)"
    
    private let markedRecordImage = UIImageView()
    private let markedRecordButton = UIButton()
    private let markedRecordButtonImage = UIImageView()
    private let markedRecordDateLabel = UILabel()
    private let markedRecordLocationLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.backgroundColor = .colorF5F3F0
        contentView.layer.cornerRadius = 12
        
        markedRecordImage.layer.cornerRadius = 12
        markedRecordImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        markedRecordImage.layer.masksToBounds = true
        markedRecordImage.image = UIImage(named: "markedRecordTest")
        
        markedRecordButton.layer.cornerRadius = 28 / 2
        markedRecordButton.backgroundColor = .colorC9C6C2
        
        markedRecordButtonImage.image = UIImage(named: "markedRecord")
        markedRecordImage.contentMode = .scaleAspectFill
    
        markedRecordDateLabel.textColor = .color707070
        markedRecordDateLabel.font = .body02
        
        markedRecordLocationLabel.textColor = .color1C1C1C
        markedRecordLocationLabel.font = .title02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(markedRecordImage)
        markedRecordImage.addSubview(markedRecordButton)
        markedRecordButton.addSubview(markedRecordButtonImage)
        contentView.addSubview(markedRecordDateLabel)
        contentView.addSubview(markedRecordLocationLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        markedRecordImage.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView)
            $0.height.equalTo(148)
        }
        
        markedRecordButton.snp.makeConstraints {
            $0.top.equalTo(markedRecordImage).offset(10)
            $0.trailing.equalTo(markedRecordImage).offset(-10)
            $0.width.height.equalTo(28)
        }
        
        markedRecordButtonImage.snp.makeConstraints {
            $0.centerX.centerY.equalTo(markedRecordButton)
            $0.width.height.equalTo(18)
        }
        
        markedRecordDateLabel.snp.makeConstraints {
            $0.top.equalTo(markedRecordImage.snp.bottom).offset(9)
            $0.leading.equalTo(markedRecordImage).offset(14)
        }
        
        markedRecordLocationLabel.snp.makeConstraints {
            $0.top.equalTo(markedRecordDateLabel.snp.bottom)
            $0.leading.equalTo(markedRecordImage).offset(14)
        }
    }
    
    func configure(image: String, date: String, location: String, color: UIColor) {
        markedRecordImage.image = UIImage(named: image)
        markedRecordDateLabel.text = date
        markedRecordLocationLabel.text = location
        markedRecordButton.backgroundColor = color
    }
}
