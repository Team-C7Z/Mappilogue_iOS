//
//  PopMenuBar.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

public class PopMenuBar: UIView {
    public var onPopButtonTapped: (() -> Void)?
    
    private let popButton = UIButton()
    private let titleLabel = UILabel()
    private let menuButton = UIButton()
    
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
        titleLabel.font = .title02
        menuButton.setImage(Icons.icon(named: .notificationDefault), for: .normal)
    }
    
    func setupHierarchy() {
        addSubview(popButton)
        addSubview(titleLabel)
        addSubview(menuButton)
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
        
        menuButton.snp.makeConstraints {
            $0.trailing.equalTo(self).offset(-10)
            $0.bottom.equalTo(self).offset(-6)
            $0.width.height.equalTo(32)
        }
    }
    
    public func configure(title: String) {
        titleLabel.text = title
    }
}
