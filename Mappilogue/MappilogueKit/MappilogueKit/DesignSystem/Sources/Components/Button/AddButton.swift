//
//  AddButton.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

public class AddButton: UIButton {
    private let imageLabelView = UIView()
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
        
        imageLabelView.isUserInteractionEnabled = false
        
        addImage.image = Images.image(named: .buttonAdd)
        
        addLabel.text = title
        addLabel.textColor = .whiteFFFFFF
        addLabel.textAlignment = .center
        addLabel.font = .body03
    }
    
    private func setupHierarchy() {
        addSubview(imageLabelView)
        imageLabelView.addSubview(addImage)
        imageLabelView.addSubview(addLabel)
    }
    
    private func setupLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(53)
        }
        
        imageLabelView.snp.makeConstraints {
            $0.center.height.equalTo(self)
            $0.width.equalTo(93)
        }
        
        addImage.snp.makeConstraints {
            $0.leading.centerY.equalTo(imageLabelView)
            $0.width.height.equalTo(10)
        }
        
        addLabel.snp.makeConstraints {
            $0.trailing.centerY.equalTo(imageLabelView)
        }
    }
}
