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
    
    private let outerView = UIView()
    private let todayScheduleLabel = UILabel()
    private let expandButton = UIButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        outerView.layer.cornerRadius = 12
        
        todayScheduleLabel.textColor = .black1C1C1C
        todayScheduleLabel.textAlignment = .center
        todayScheduleLabel.font = .title02
 
        expandButton.addTarget(self, action: #selector(expandButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(outerView)
        contentView.addSubview(todayScheduleLabel)
        contentView.addSubview(expandButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        outerView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(contentView)
            $0.height.equalTo(38)
        }
        
        todayScheduleLabel.snp.makeConstraints {
            $0.leading.equalTo(outerView).offset(14)
            $0.centerY.equalTo(outerView)
        }
        
        expandButton.snp.makeConstraints {
            $0.trailing.equalTo(outerView).offset(-14)
            $0.centerY.equalTo(outerView)
            $0.width.height.equalTo(24)
        }
    }
    
    func configure(_ schedule: TodaySchedule, isExpanded: Bool) {
        todayScheduleLabel.text = schedule.title
        outerView.backgroundColor = schedule.color
        expandButton.setImage(UIImage(named: isExpanded ? "home_hideSchedule" : "home_showSchedule"), for: .normal)
    }
    
    @objc private func expandButtonTapped(_ sender: UIButton) {
        delegate?.expandButtonTapped(in: self)
    }
}
