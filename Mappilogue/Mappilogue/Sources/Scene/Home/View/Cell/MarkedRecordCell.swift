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
    private let markView = MarkView(frame: CGRect(x: 0, y: 0, width: 28, height: 28))
    private let markedRecordButtonImage = UIImageView()
    private let markedRecordDateLabel = UILabel()
    private let markedRecordLocationLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.backgroundColor = .colorEAE6E1
        contentView.layer.cornerRadius = 12
        
        markedRecordImage.layer.cornerRadius = 12
        markedRecordImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        markedRecordImage.layer.masksToBounds = true
        
        markView.configure(heartWidth: 16, heartHeight: 15)
    
        markedRecordDateLabel.textColor = .color707070
        markedRecordDateLabel.font = .body02
        
        markedRecordLocationLabel.textColor = .color1C1C1C
        markedRecordLocationLabel.font = .title02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(markedRecordImage)
        markedRecordImage.addSubview(markView)
        contentView.addSubview(markedRecordDateLabel)
        contentView.addSubview(markedRecordLocationLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        markedRecordImage.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView)
            $0.height.equalTo(148)
        }
        
        markView.snp.makeConstraints {
            $0.top.equalTo(markedRecordImage).offset(10)
            $0.trailing.equalTo(markedRecordImage).offset(-10)
            $0.width.height.equalTo(28)
        }
        
        markedRecordDateLabel.snp.makeConstraints {
            $0.top.equalTo(markedRecordImage.snp.bottom).offset(9)
            $0.leading.equalTo(markedRecordImage).offset(14)
        }
        
        markedRecordLocationLabel.snp.makeConstraints {
            $0.top.equalTo(markedRecordImage.snp.bottom).offset(30)
            $0.leading.equalTo(markedRecordImage).offset(14)
        }
    }
    
    func configure(_ markedRecord: MarkedRecord) {
        markedRecordImage.image = UIImage(named: "markedRecordTest")
        markedRecordDateLabel.text = markedRecord.date
        markedRecordLocationLabel.text = markedRecord.location
        markView.backgroundColor = markedRecord.color
    }
}
