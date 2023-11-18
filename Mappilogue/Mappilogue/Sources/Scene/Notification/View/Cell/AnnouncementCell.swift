//
//  AnnouncementCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/13.
//

import UIKit

class AnnouncementCell: BaseTableViewCell {
    static let registerId = "\(AnnouncementCell.self)"
 
    weak var delegate: ExpandCellDelegate?
    
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let expandButton = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        titleLabel.textColor = .color000000
        titleLabel.font = .body03
        
        dateLabel.textColor = .color707070
        dateLabel.font = .caption02
        
        expandButton.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
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
    
    func configure(_ announcement: AnnouncementData, isExpanded: Bool) {
        titleLabel.text = announcement.title
        dateLabel.text = announcement.date
        expandButton.setImage(UIImage(named: isExpanded ? "notification_close" : "notification_expand"), for: .normal)
    }
    
    @objc private func expandButtonTapped() {
        delegate?.expandButtonTapped(in: self)
    }
}
