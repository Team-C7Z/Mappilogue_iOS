//
//  ScheduleTitleColorCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class ScheduleTitleColorCell: BaseTableViewCell {
    static let registerId = "\(ScheduleTitleColorCell.self)"
    
    weak var delegate: ColorSelectionDelegate?
    
    private let scheduleNameTextField = UITextField()
    private let colorSelectionButton = ColorSelectionButton()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()

        scheduleNameTextField.font = .title02
        scheduleNameTextField.placeholder = "일정 제목을 적어 주세요"
        
        colorSelectionButton.addTarget(self, action: #selector(colorSelectionButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
    
        contentView.addSubview(scheduleNameTextField)
        contentView.addSubview(colorSelectionButton)
    }
    
    override func setupLayout() {
        super.setupLayout()

        scheduleNameTextField.snp.makeConstraints {
            $0.top.leading.equalTo(contentView)
            $0.width.equalTo(275)
            $0.height.equalTo(48)
        }
        
        colorSelectionButton.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(9)
            $0.trailing.equalTo(contentView)
            $0.width.equalTo(60)
            $0.height.equalTo(28)
        }
    }
    
    func configure(with color: UIColor) {
        colorSelectionButton.backgroundColor = color
    }
    
    @objc func colorSelectionButtonTapped(_ sender: UIButton) {
        delegate?.colorSelectionButtonTapped()
    }
}

protocol ColorSelectionDelegate: AnyObject {
    func colorSelectionButtonTapped()
}