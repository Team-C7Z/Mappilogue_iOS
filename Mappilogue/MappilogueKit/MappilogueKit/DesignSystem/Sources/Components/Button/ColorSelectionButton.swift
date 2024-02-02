//
//  ColorSelectionButton.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/04.
//

import UIKit

public class ColorSelectionButton: UIButton {
    private let colorSelectionLabel = UILabel()
    private let colorSelectionArrowImage = UIImageView()
    
    public init(textColor: UIColor, color: UIColor) {
        super.init(frame: .zero)

        colorSelectionLabel.textColor = textColor
        backgroundColor = color
        colorSelectionArrowImage.image = UIImage(named: "opendColorSelection")
        colorSelectionArrowImage.tintColor = .whiteFFFFFF
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
    
    public func configure(textColor: UIColor, color: UIColor) {
        colorSelectionLabel.textColor = textColor
        backgroundColor = color
        colorSelectionArrowImage.tintColor = .whiteFFFFFF
        colorSelectionArrowImage.tintColor = textColor
    }
    
    public func switchColorSelectionButton(_ isColorSelection: Bool) {
        colorSelectionArrowImage.image = UIImage(named: !isColorSelection ? "opendColorSelection" : "closedColorSelection")
        
//        if isColorSelection {
//            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
//                self.colorSelectionArrowImage.transform = CGAffineTransform(rotationAngle: -CGFloat.pi / (1/3))
//            })
//        } else {
//            UIView.animate(withDuration: 0.3, delay: 0, options: .curveLinear, animations: {
//                self.colorSelectionArrowImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi / (1/3))
//            })
//        }
    }
}
