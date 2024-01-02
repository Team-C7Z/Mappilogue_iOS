//
//  AlertView.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit
import SnapKit

public class AlertView: UIView {
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    public let cancelButton = UIButton()
    public let doneButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupProperty() {
        layer.cornerRadius = 12
        backgroundColor = .grayF9F8F7
        
        titleLabel.textColor = .color000000
        titleLabel.font = .title02
        
        messageLabel.textColor = .gray707070
        messageLabel.font = .body02
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        cancelButton.layer.cornerRadius = 12
        cancelButton.backgroundColor = .grayF5F3F0
        cancelButton.setTitleColor(.black1C1C1C, for: .normal)
        cancelButton.titleLabel?.font = .body02
        
        doneButton.layer.cornerRadius = 12
        doneButton.setTitleColor(.whiteFFFFFF, for: .normal)
        doneButton.titleLabel?.font = .body03
    }
    
    func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(messageLabel)
        addSubview(cancelButton)
        addSubview(doneButton)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self).offset(32)
            $0.centerX.equalTo(self)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(self).offset(56)
            $0.centerX.equalTo(self)
        }
        
        cancelButton.snp.makeConstraints {
            $0.bottom.equalTo(self).offset(-10)
            $0.leading.equalTo(self).offset(10)
            $0.width.equalTo(120)
            $0.height.equalTo(42)
        }
        
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(self).offset(-10)
            $0.trailing.equalTo(self).offset(-10)
            $0.width.equalTo(120)
            $0.height.equalTo(42)
        }
    }
    
    public func configureAlert(with alert: Alert) {
        titleLabel.text = alert.titleText
        messageLabel.text = alert.messageText
        cancelButton.setTitle(alert.cancelText, for: .normal)
        doneButton.setTitle(alert.doneText, for: .normal)
        doneButton.backgroundColor = alert.buttonColor
        self.snp.makeConstraints {
            $0.width.equalTo(270)
            $0.height.equalTo(alert.alertHeight)
        }
    }
}
