//
//  PopNotificationBar.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

public class PopNotificationBar: UIView {
    public var onPopButtonTapped: (() -> Void)?
    public var onNotificationButtonTapped: (() -> Void)?
    
    private let popButton = UIButton()
    private let titleLabel = UILabel()
    private let notificationButton = UIButton()
    
    public init(title: String) {
        super.init(frame: CGRect.zero)
        
        setupProperty(title)
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty(_ title: String) {
        popButton.setImage(Icons.icon(named: .pop), for: .normal)
        titleLabel.text = title
        titleLabel.font = .title02
        notificationButton.setImage(Icons.icon(named: .notificationDefault), for: .normal)
    }
    
    func setupHierarchy() {
        addSubview(popButton)
        addSubview(titleLabel)
        addSubview(notificationButton)
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
        
        notificationButton.snp.makeConstraints {
            $0.trailing.equalTo(self).offset(-16)
            $0.bottom.equalTo(self).offset(-7)
            $0.width.equalTo(26)
            $0.height.equalTo(29)
        }
    }
}
