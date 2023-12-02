//
//  AddButton.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

public class AddButton: UIButton {
    private let outerView = UIView()
    private let addImage = UIImageView()
    private let addLabel = UILabel()
    
    public init(title: String) {
        super.init(frame: .zero)
        
        setupProperty(title)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
     }
    
    private func setupProperty(_ title: String) {
        backgroundColor = .black1C1C1C
        
        layer.cornerRadius = 12
        
        addImage.image = Images.image(named: .buttonAdd)
        
        addLabel.text = title
        addLabel.textColor = .whiteFFFFFF
        addLabel.textAlignment = .center
        addLabel.font = .body03
    }
    
    private func setupHierarchy() {
        addSubview(outerView)
        outerView.addSubview(addImage)
        outerView.addSubview(addLabel)
    }
    
    private func setupLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(53)
        }
        
        outerView.snp.makeConstraints {
            $0.center.height.equalTo(self)
            $0.width.equalTo(93)
        }
        
        addImage.snp.makeConstraints {
            $0.leading.centerY.equalTo(outerView)
            $0.width.height.equalTo(10)
        }
        
        addLabel.snp.makeConstraints {
            $0.trailing.centerY.equalTo(outerView)
        }
    }
}
