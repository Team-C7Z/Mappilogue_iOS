//
//  ScheduleTitleColorView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class ScheduleTitleColorButton: BaseButton {
    private let lineView = UIView()
    private let scheduleTitleLabel = UILabel()
    private var colorSelectionButton = ColorSelectionButton(textColor: .color1C1C1C, color: .colorCAEDA8)
    
    override func setupProperty() {
        super.setupProperty()
        
        lineView.backgroundColor = .colorEAE6E1

        scheduleTitleLabel.textColor = .colorC9C6C2
        scheduleTitleLabel.font = .title02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(lineView)
        addSubview(scheduleTitleLabel)
        addSubview(colorSelectionButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self)
            $0.height.equalTo(1)
        }

        scheduleTitleLabel.snp.makeConstraints {
            $0.leading.centerY.equalTo(self)
        }
        
        colorSelectionButton.snp.makeConstraints {
            $0.trailing.equalTo(self).offset(-4)
            $0.centerY.equalTo(self)
            $0.width.equalTo(60)
            $0.height.equalTo(28)
        }
    }
    
    func configure(with scheduleTitle: String, color: UIColor) {
        print(color)
        scheduleTitleLabel.text = scheduleTitle
        if color == .color1C1C1C || color == .color9B9791 || color == .color404040 {
            colorSelectionButton.configure(textColor: .colorFFFFFF, color: color, isColorSelection: true)
        } else {
            colorSelectionButton.configure(textColor: .color1C1C1C, color: color, isColorSelection: true)
        }
    }
}
