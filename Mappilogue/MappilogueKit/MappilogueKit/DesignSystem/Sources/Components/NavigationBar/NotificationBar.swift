//
//  NotificationBar.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit

public class NotificationBar: UIView {
    public var onNotificationButtonTapped: (() -> Void)?
    
    private let titleLabel = UILabel()
    private let notificationButton = UIButton()
    
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
        titleLabel.font = .title02
        notificationButton.setImage(Icons.icon(named: .notificationDefault), for: .normal)
        notificationButton.addTarget(self, action: #selector(notificationButtonTapped), for: .touchUpInside)
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(notificationButton)
    }
    
    func setupLayout() {
        self.snp.makeConstraints {
            $0.height.equalTo(88)
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
    
    public func configure(title: String) {
        titleLabel.text = title
    }
    
    @objc func notificationButtonTapped() {
        onNotificationButtonTapped?()
    }
}
