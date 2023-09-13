//
//  AnnouncementCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/13.
//

import UIKit

class AnnouncementCell: BaseTableViewCell {
    static let registerId = "\(AnnouncementCell.self)"
 
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let expandButton = UIButton()
    private let contentTextView = UITextView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.text = "기록 어플 ‘맵필로그’ 런칭 안내"
        titleLabel.textColor = .color000000
        titleLabel.font = .body03
        
        dateLabel.text = "2023년 9월 13일"
        dateLabel.textColor = .color707070
        dateLabel.font = .caption02
        
        expandButton.setImage(UIImage(named: "notification_expand"), for: .normal)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(expandButton)

    }
    
    override func setupLayout() {
        super.setupLayout()
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(16)
            $0.leading.equalTo(contentView)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(41)
            $0.leading.equalTo(contentView)
        }
        
        expandButton.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(21)
            $0.trailing.equalTo(contentView)
            $0.width.height.equalTo(32)
        }
    }
}
