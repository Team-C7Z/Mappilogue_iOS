//
//  AddLocationCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/07.
//

import UIKit
import MappilogueKit

class AddLocationFooterView: BaseCollectionReusableView {
    static let registerId = "\(AddLocationFooterView.self)"
    
    var onAddLocationButtonTapped: (() -> Void)?
    
    private let addLocationButton = AddButton(title: "일정 추가하기")
    
    override func setupProperty() {
        super.setupProperty()

        addLocationButton.addTarget(self, action: #selector(addLocationButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(addLocationButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        addLocationButton.snp.makeConstraints {
            $0.top.equalTo(self)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
        }
    }
    
    @objc private func addLocationButtonTapped() {
        onAddLocationButtonTapped?()
    }
}
