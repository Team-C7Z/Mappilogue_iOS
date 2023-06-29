//
//  TodayScheduleCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/27.
//

import UIKit

protocol ExpandCellDelegate: AnyObject {
    func expandButtonTapped(in cell: UITableViewCell)
}

class TodayScheduleCell: BaseTableViewCell {
    static let registerId = "\(TodayScheduleCell.self)"
    
    weak var delegate: ExpandCellDelegate?
    
    private var isExpanded: Bool = true
    
    private let todayScheduleLabel = UILabel()
    private let expandButton = UIButton()
    private let expandButtonImage = UIImageView()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.layer.cornerRadius = 12
        
        todayScheduleLabel.textColor = .color1C1C1C
        todayScheduleLabel.textAlignment = .center
        todayScheduleLabel.font = UIFont.pretendard(.medium, size: 16)
        
        expandButton.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
        
        expandButtonImage.image = UIImage(named: "hide")
        expandButtonImage.contentMode = .scaleAspectFill
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(todayScheduleLabel)
        contentView.addSubview(expandButton)
        expandButton.addSubview(expandButtonImage)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        todayScheduleLabel.snp.makeConstraints {
            $0.leading.equalTo(contentView).offset(14)
            $0.centerY.equalTo(contentView)
        }
        
        expandButton.snp.makeConstraints {
            $0.trailing.equalTo(contentView).offset(-7)
            $0.centerY.equalTo(contentView)
            $0.width.height.equalTo(24)
        }
        
        expandButtonImage.snp.makeConstraints {
            $0.centerX.centerY.equalTo(expandButton)
            $0.width.equalTo(14)
            $0.height.equalTo(7)
        }
    }
    
    func configure(with title: String, backgroundColor: UIColor) {
        todayScheduleLabel.text = title
        contentView.backgroundColor = backgroundColor
    }
    
    @objc private func expandButtonTapped(_ sender: UIButton) {
        expandButtonImage.image = isExpanded ? UIImage(named: "open") : UIImage(named: "hide")
        isExpanded = !isExpanded
        
        delegate?.expandButtonTapped(in: self)
    }
}
