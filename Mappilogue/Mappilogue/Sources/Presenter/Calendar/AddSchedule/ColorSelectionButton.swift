//
//  ColorSelectionButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class ColorSelectionButton: UIButton {
    private let colorSelectionLabel = UILabel()
    private let colorSelectionArrowImage = UIImageView()
    
    init() {
        super.init(frame: .zero)
        
        layer.cornerRadius = 14
        backgroundColor = .color1C1C1C
        
        colorSelectionLabel.text = "색상"
        colorSelectionLabel.textColor = .colorFFFFFF
        colorSelectionLabel.font = .caption01
        
        colorSelectionArrowImage.image = UIImage(named: "colorSelection")
        
        addSubview(colorSelectionLabel)
        addSubview(colorSelectionArrowImage)
        
        colorSelectionLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(11)
        }
        
        colorSelectionArrowImage.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-12)
            $0.width.equalTo(10)
            $0.height.equalTo(5)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
