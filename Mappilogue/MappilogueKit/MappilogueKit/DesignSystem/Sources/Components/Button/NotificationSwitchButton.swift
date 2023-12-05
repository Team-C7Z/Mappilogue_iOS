//
//  NotificationSwitchButton.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/04.
//

import UIKit

public class NotificationSwitchButton: UIButton {
    public var onSwitchTapped: (() -> Void)?
    
    private let thumbView = UIView()
    
    public init() {
        super.init(frame: .zero)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {
        layer.cornerRadius = 16
        backgroundColor = .grayEAE6E1
  
        thumbView.layer.cornerRadius = 12
        thumbView.layer.applyShadow()
        thumbView.backgroundColor = .gray9B9791
        thumbView.isUserInteractionEnabled = false
        
        addTarget(self, action: #selector(updateSwitchDesign), for: .touchUpInside)
    }
    
    func setupHierarchy() {
        addSubview(thumbView)
    }
    
    func setupLayout() {
        self.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.height.equalTo(32)
        }
        
        thumbView.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.leading.equalTo(self).offset(4)
            $0.centerY.equalTo(self)
        }
    }
    
    @objc func updateSwitchDesign() {
        isSelected.toggle()
        configure(isSelected)
        onSwitchTapped?()
    }
    
    public func configure(_ isSelected: Bool) {
        backgroundColor = isSelected ? .green2EBD3D : .grayEAE6E1
        thumbView.backgroundColor = isSelected ? .whiteFFFFFF : .gray9B9791
        
        thumbView.snp.updateConstraints {
            $0.leading.equalTo(self).offset(isSelected ? 36 : 4)
        }
    
        self.layoutIfNeeded()
    }
}
