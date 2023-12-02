//
//  AlertViewController.swift
//  MappilogueKit
//
//  Created by hyemi on 2023/12/02.
//

import UIKit
import SnapKit

public class AlertViewController: UIViewController {
    public var onCancelTapped: (() -> Void)?
    public var onDoneTapped: (() -> Void)?
    
    private let alertView = UIView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let cancelButton = UIButton()
    private let doneButton = UIButton()
    
    override public func viewDidLoad() {
        super.viewDidLoad()

        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    func setupProperty() {
        view.backgroundColor = .gray404040.withAlphaComponent(0.1)
        
        alertView.layer.cornerRadius = 12
        alertView.backgroundColor = .grayF9F8F7
        
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
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        doneButton.layer.cornerRadius = 12
        doneButton.setTitleColor(.whiteFFFFFF, for: .normal)
        doneButton.titleLabel?.font = .body03
        doneButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    func setupHierarchy() {
        view.addSubview(alertView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(messageLabel)
        alertView.addSubview(cancelButton)
        alertView.addSubview(doneButton)
    }
    
    func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(32)
            $0.centerX.equalTo(alertView)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(56)
            $0.centerX.equalTo(alertView)
        }
        
        cancelButton.snp.makeConstraints {
            $0.bottom.equalTo(alertView).offset(-10)
            $0.leading.equalTo(alertView).offset(10)
            $0.width.equalTo(120)
            $0.height.equalTo(42)
        }
        
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(alertView).offset(-10)
            $0.trailing.equalTo(alertView).offset(-10)
            $0.width.equalTo(120)
            $0.height.equalTo(42)
        }
    }
    
    @objc private func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            self.onCancelTapped?()
        }
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            self.onDoneTapped?()
        }
    }
    
    public func configureAlert(with alert: Alert) {
        titleLabel.text = alert.titleText
        messageLabel.text = alert.messageText
        cancelButton.setTitle(alert.cancelText, for: .normal)
        doneButton.setTitle(alert.doneText, for: .normal)
        doneButton.backgroundColor = alert.buttonColor
        alertView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(270)
            $0.height.equalTo(alert.alertHeight)
        }
    }
}
