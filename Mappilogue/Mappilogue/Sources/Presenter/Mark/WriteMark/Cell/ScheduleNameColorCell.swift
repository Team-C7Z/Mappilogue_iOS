//
//  ScheduleNameColorCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class ScheduleNameColorCell: BaseTableViewCell {
    static let registerId = "\(ScheduleNameColorCell.self)"

    private let lineView = UIView()
    private let scheduleTitleLabel = UILabel()
    private let colorSelectionButton = ColorSelectionButton(textColor: .color1C1C1C, color: .colorCAEDA8, isColorSelection: false)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        lineView.backgroundColor = .colorEAE6E1
        
        scheduleTitleLabel.text = "제주 여행 🎁"
        scheduleTitleLabel.textColor = .colorC9C6C2
        scheduleTitleLabel.font = .title02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(lineView)
        contentView.addSubview(scheduleTitleLabel)
        contentView.addSubview(colorSelectionButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(contentView)
            $0.height.equalTo(1)
        }

        scheduleTitleLabel.snp.makeConstraints {
            $0.leading.centerY.equalTo(contentView)
        }
        
        colorSelectionButton.snp.makeConstraints {
            $0.trailing.equalTo(contentView).offset(-4)
            $0.centerY.equalTo(contentView)
            $0.width.equalTo(60)
            $0.height.equalTo(28)
            
        }
    }
}
