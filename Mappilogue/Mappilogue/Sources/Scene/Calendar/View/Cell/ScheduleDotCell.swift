//
//  ScheduleDotCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/19.
//

import UIKit

class ScheduleDotCell: BaseCollectionViewCell {
    static let registerId = "\(ScheduleTitleCell.self)"
    
    private let dotView = UIView()
    
    override func prepareForReuse() {
        super.prepareForReuse()
  
        dotView.backgroundColor = nil
    }

    override func setupProperty() {
        super.setupProperty()
        
        dotView.layer.cornerRadius = 4
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(dotView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        dotView.snp.makeConstraints {
            $0.width.height.equalTo(8)
            $0.top.equalTo(self).offset(4)
            $0.centerX.equalTo(self)
        }
    }
    
    func configure(scheduleStatus: Bool) {
        if scheduleStatus {
            dotView.backgroundColor = .color2EBD3D
        }
    }
}
