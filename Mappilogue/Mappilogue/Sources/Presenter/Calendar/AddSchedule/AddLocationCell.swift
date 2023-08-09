//
//  AddLocationCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/07.
//

import UIKit

class AddLocationCell: BaseCollectionViewCell {
    static let registerId = "\(AddLocationCell.self)"
    
    var onAddLocationButtonTapped: (() -> Void)?
    
    private let addLocationButton = AddButton(text: "장소 추가하기", backgroundColor: .color1C1C1C)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
            $0.centerY.equalTo(self)
            $0.leading.equalTo(self).offset(16)
            $0.trailing.equalTo(self).offset(-16)
        }
    }
    
    @objc private func addLocationButtonTapped() {
        onAddLocationButtonTapped?()
    }
}
