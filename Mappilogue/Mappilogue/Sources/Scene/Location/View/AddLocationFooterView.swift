//
//  AddLocationCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/07.
//

import UIKit

class AddLocationFooterView: BaseCollectionReusableView {
    static let registerId = "\(AddLocationFooterView.self)"
    
    var onAddLocationButtonTapped: (() -> Void)?
    
    private let addLocationButton = AddButton(text: "장소 추가하기", backgroundColor: .black1C1C1C)
    
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
