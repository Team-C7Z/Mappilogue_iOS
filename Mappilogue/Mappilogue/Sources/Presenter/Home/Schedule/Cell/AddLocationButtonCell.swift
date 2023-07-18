//
//  AddLocationButtonCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/29.
//

import UIKit

class AddLocationButtonCell: BaseTableViewCell {
    static let registerId = "\(AddLocationButtonCell.self)"
    
    weak var delegate: AddLocationDelegate?
    
    private let addScheduleButton = AddButton(text: "장소 추가하기", backgroundColor: .color1C1C1C)
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        addScheduleButton.addTarget(self, action: #selector(addLocationButtonTapped), for: .touchUpInside)
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
    
    @objc func addLocationButtonTapped(_ sender: UIButton) {
        delegate?.addLocationButtonTapped()
    }
}

protocol AddLocationDelegate: AnyObject {
    func addLocationButtonTapped()
}
