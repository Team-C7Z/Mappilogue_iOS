//
//  PopBar.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

public class PopBar: UIView {
    public var onPopButtonTapped: (() -> Void)?
    
    private let popButton = UIButton()
    private let titleLabel = UILabel()
    
    public init() {
        super.init(frame: CGRect.zero)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {
        popButton.setImage(Icons.icon(named: .pop), for: .normal)
        popButton.addTarget(self, action: #selector(popButtonTapped), for: .touchUpInside)
        titleLabel.font = .title02
    }
    
    func setupHierarchy() {
        addSubview(popButton)
        addSubview(titleLabel)
    }
    
    func setupLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(88)
        }
        
        popButton.snp.makeConstraints {
            $0.leading.equalTo(self).offset(16)
            $0.bottom.equalTo(self).offset(-10)
            $0.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalTo(self)
            $0.bottom.equalTo(self).offset(-10)
        }
    }
    
    public func configure(title: String) {
        titleLabel.text = title
    }
    
    @objc func popButtonTapped() {
        onPopButtonTapped?()
    }
}
