//
//  AddScheduleButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class AddScheduleButton: UIButton {
    init() {
        super.init(frame: .zero)
        
        setImage(UIImage(named: "addSchedule"), for: .normal)
        frame.size = .init(width: 56, height: 56)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
