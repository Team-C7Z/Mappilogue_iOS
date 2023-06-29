//
//  AddScheduleButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/29.
//

import UIKit

class AddScheduleButtonCell: BaseCollectionViewCell {
    static let registerId = "\(AddScheduleButtonCell.self)"
    
    private let addScheduleButton = AddButton(text: "일정 추가하기", backgroundColor: .color43B54E)
    
    override func setupHierarchy() {
        super.setupProperty()
        
        addSubview(addScheduleButton)
    }
    
    override func setupLayout() {
        super.setupProperty()
        
        addScheduleButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(53)
        }
    }
    
}
