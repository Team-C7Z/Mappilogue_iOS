//
//  LogoNotificationBar.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

public class LogoNotificationBar: UIView {
    public var onNotificationButtonTapped: (() -> Void)?
    
    private let logoImage = UIImageView()
    private let notificationButton = UIButton()
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {
        backgroundColor = .grayF9F8F7
        
        logoImage.image = Icons.icon(named: .logo)
        notificationButton.setImage(Icons.icon(named: .notificationDefault), for: .normal)
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
    }
    
    func setupHierarchy() {
        addSubview(logoImage)
        addSubview(notificationButton)
    }
    
    func setupLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(88)
        }
        
        logoImage.snp.makeConstraints {
            $0.leading.equalTo(self).offset(16)
            $0.bottom.equalTo(self).offset(-9)
            $0.width.equalTo(146.29)
            $0.height.equalTo(32)
        }
        
        notificationButton.snp.makeConstraints {
            $0.trailing.equalTo(self).offset(-16)
            $0.bottom.equalTo(self).offset(-7)
            $0.width.equalTo(26)
            $0.height.equalTo(29)
        }
    }
    
    @objc func notificationButtonTapped() {
        onNotificationButtonTapped?()
    }
}
