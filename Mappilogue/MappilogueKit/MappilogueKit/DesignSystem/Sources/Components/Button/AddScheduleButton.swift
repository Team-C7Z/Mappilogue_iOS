//
//  AddScheduleButton.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/03.
//

import UIKit

public class AddScheduleButton: UIButton {
    public init() {
        super.init(frame: .zero)
        
        setupProperty()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
     }
    
    private func setupProperty() {
        setImage(Images.image(named: .buttonAddSchedule), for: .normal)
    }
    
    private func setupLayout() {
        self.snp.makeConstraints {
            $0.width.height.equalTo(56)
        }
    }
}
