//
//  DismissSaveBar.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

class DismissSaveBar: UIView {
    private let dismissButton = UIButton()
    private let titleLabel = UILabel()
    private let saveButton = UIButton()
    
    init(title: String) {
        super.init(frame: CGRect.zero)
        
        setupProperty(title)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty(_ title: String) {
        dismissButton.setImage(Icons.icon(named: .dismiss), for: .normal)
        titleLabel.text = title
        saveButton.setImage(Icons.icon(named: .save), for: .normal)
    }
    
    func setupHierarchy() {
        addSubview(dismissButton)
        addSubview(titleLabel)
        addSubview(saveButton)
    }
    
    func setupLayout() {
        dismissButton.snp.makeConstraints {
            $0.leading.equalTo(self).offset(16)
            $0.bottom.equalTo(self).offset(10)
            $0.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.bottom.equalTo(self).offset(-10)
        }
        
        saveButton.snp.makeConstraints {
            $0.trailing.equalTo(self).offset(-17)
            $0.bottom.equalTo(self).offset(-10)
            $0.width.height.equalTo(24)
        }
    }
}
