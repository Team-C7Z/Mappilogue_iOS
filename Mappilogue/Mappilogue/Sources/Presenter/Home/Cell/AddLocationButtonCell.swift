//
//  AddLocationButtonCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/29.
//

import UIKit

class AddLocationButtonCell: BaseCollectionViewCell {
    static let registerId = "\(AddLocationButtonCell.self)"
    
    private let addScheduleButton = AddButton(text: "장소 추가하기", backgroundColor: .color1C1C1C)
    
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
