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
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupButton()
     }
    
    init(text: String, backgroundColor: UIColor) {
        super.init(frame: .zero)
        setupButton()
        
        addLabel.text = text
        setTitleColor(.colorFFFFFF, for: .normal)
        self.backgroundColor = backgroundColor
        
        layer.cornerRadius = 12
        
        setupHierarchy()
        setupLayout()
    }
    
    private func setupButton() {
        addImage.image = UIImage(named: "add")
        addLabel.textColor = .white
        addLabel.textAlignment = .center
        addLabel.font = UIFont.pretendard(.semiBold, size: 14)
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
