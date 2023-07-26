//
//  AlertViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/26.
//

import UIKit

enum AlertType {
    case cancel
    case done
}

struct Alert {
    var titleText: String
    var messageText: String?
    var cancelText: String
    var doneText: String
    var buttonColor: UIColor
    var alertHeight: CGFloat
}

class AlertViewController: BaseViewController {
    var onDeleteTapped: (() -> Void)?
    
    private let alertView = UIView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let cancelButton = UIButton()
    private let doneButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .color404040.withAlphaComponent(0.1)
        
        alertView.layer.cornerRadius = 12
        alertView.backgroundColor = .colorF9F8F7
        
        titleLabel.textColor = .color000000
        titleLabel.font = .title02
        
        messageLabel.textColor = .color000000
        messageLabel.font = .body02
        
        cancelButton.layer.cornerRadius = 12
        cancelButton.backgroundColor = .colorF5F3F0
        cancelButton.setTitleColor(.color1C1C1C, for: .normal)
        cancelButton.titleLabel?.font = .body02
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        doneButton.layer.cornerRadius = 12
        doneButton.setTitleColor(.colorFFFFFF, for: .normal)
        doneButton.titleLabel?.font = .body03
        doneButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(alertView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(messageLabel)
        alertView.addSubview(cancelButton)
        alertView.addSubview(doneButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
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
        dismiss(animated: false)
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            self.onDeleteTapped?()
        }
    }
    
    func configureAlert(with alert: Alert) {
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
