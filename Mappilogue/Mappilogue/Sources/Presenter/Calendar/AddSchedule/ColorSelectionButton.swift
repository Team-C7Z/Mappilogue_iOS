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
    
    init(textColor: UIColor, color: UIColor, isColorSelection: Bool) {
        super.init(frame: .zero)

        colorSelectionLabel.textColor = textColor
        backgroundColor = color
        colorSelectionArrowImage.image = UIImage(named: isColorSelection ? "closedColorSelection" : "openColorSelection")
        colorSelectionArrowImage.tintColor = textColor
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    func setupProperty() {
        layer.cornerRadius = 14
        
        colorSelectionLabel.text = "색상"
        colorSelectionLabel.font = .caption01
    }
    
    func setupHierarchy() {
        addSubview(colorSelectionLabel)
        addSubview(colorSelectionArrowImage)
    }
    
    func setupLayout() {
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
}
