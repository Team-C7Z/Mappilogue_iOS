//
//  AddButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/06/29.
//

import UIKit

class AddButton: UIButton {
    private let outerView = UIView()
    private let addImage = UIImageView()
    private let addLabel = UILabel()
    
    init(text: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        setupButton()
        
        addLabel.setTextWithLineHeight(text: text, lineHeight: UILabel.body03)
        setTitleColor(.colorFFFFFF, for: .normal)
        self.backgroundColor = backgroundColor
        
        layer.cornerRadius = 12
        
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
     }
    
    private func setupButton() {
        addImage.image = UIImage(named: "add")
        addLabel.textColor = .white
        addLabel.textAlignment = .center
        addLabel.font = .body03
    }
    
    private func setupHierarchy() {
        addSubview(outerView)
        outerView.addSubview(addImage)
        outerView.addSubview(addLabel)
    }
    
    private func setupLayout() {
        outerView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(93)
            $0.height.equalTo(10)
        }
        
        addImage.snp.makeConstraints {
            $0.leading.equalTo(outerView)
            $0.centerY.equalTo(outerView)
            $0.width.height.equalTo(10)
        }
        
        addLabel.snp.makeConstraints {
            $0.trailing.equalTo(outerView)
            $0.centerY.equalTo(outerView)
        }
    }
}
