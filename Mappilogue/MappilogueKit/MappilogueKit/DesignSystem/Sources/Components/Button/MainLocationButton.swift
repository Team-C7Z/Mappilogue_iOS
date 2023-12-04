//
//  MainLocationButton.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/04.
//

import UIKit

public class MainLocationButton: UIButton {
    public init() {
        super.init(frame: .zero)
        
        setupProperty()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {
        setTitle("대표 위치", for: .normal)
        setTitleColor(.grayC9C6C2, for: .normal)
        titleLabel?.font = .caption02
        backgroundColor = .clear
        layer.borderWidth = 2
        layer.borderColor = UIColor.grayC9C6C2.cgColor
        layer.cornerRadius = 14
    }
}
