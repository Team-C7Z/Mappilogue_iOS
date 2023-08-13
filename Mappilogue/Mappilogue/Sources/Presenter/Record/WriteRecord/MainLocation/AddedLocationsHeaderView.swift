//
//  AddedLocationsHeaderView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/02.
//

import UIKit

class AddedLocationsHeaderView: BaseCollectionReusableView {
    static let registerId = "\(AddedLocationsHeaderView.self)"

    private let locationHeaderLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.frame = self.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()

        locationHeaderLabel.text = "일정에서 추가한 장소"
        locationHeaderLabel.textColor = .color707070
        locationHeaderLabel.font = .caption01
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(locationHeaderLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        locationHeaderLabel.snp.makeConstraints {
            $0.top.equalTo(self).offset(16)
            $0.leading.equalTo(self)
        }
    }
}
