//
//  MarkedRecordsCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/02.
//

import UIKit

class MarkedRecordsCell: BaseTableViewCell {
    static let registerId = "\(MarkedRecordsCell.self)"
    
    private var markedRecordsLabel = UILabel()
  //  private var collectionView = UICollectionView()

    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()

        markedRecordsLabel.text = "마크한 기록"
        markedRecordsLabel.textColor = .color1C1C1C
        markedRecordsLabel.font = .pretendard(.medium, size: 20)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(markedRecordsLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
    
        markedRecordsLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
    }

}
