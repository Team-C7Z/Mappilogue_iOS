//
//  AddScheduleButtonCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/29.
//

import UIKit

class AddScheduleButtonCell: BaseTableViewCell {
    static let registerId = "\(AddScheduleButtonCell.self)"
    
    weak var delegate: AddScheduleDelegate?
    
    private let addScheduleButton = AddButton(text: "일정 추가하기", backgroundColor: .color43B54E)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        addScheduleButton.addTarget(self, action: #selector(addScheduleButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        contentView.addSubview(addScheduleButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        addScheduleButton.snp.makeConstraints {
            $0.edges.equalTo(contentView)
            $0.height.equalTo(53)
        }
    }
    
    @objc func addScheduleButtonTapped(_ sender: UIButton) {
        delegate?.addScheduleButtonTapped()
    }
}

protocol AddScheduleDelegate: AnyObject {
    func addScheduleButtonTapped()
}
