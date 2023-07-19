//
//  DeleteAlertViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/19.
//

import UIKit

enum AlertType {
    case cancel
    case delete
}

class DeleteAlertViewController: BaseViewController {
    private let alertView = UIView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let cancelButton = UIButton()
    private let deleteButton = UIButton()
    
    var titleText: String?
    var messageText: String?
    var onDeleteTapped: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .color404040.withAlphaComponent(0.1)
        
        alertView.layer.cornerRadius = 12
        alertView.backgroundColor = .colorF9F8F7
        
        titleLabel.text = "이 일정을 삭제할까요?"
        titleLabel.textColor = .color000000
        titleLabel.font = .title02
        
        messageLabel.textColor = .color000000
        messageLabel.font = .body02
        
        cancelButton.layer.cornerRadius = 12
        cancelButton.backgroundColor = .colorF5F3F0
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.color1C1C1C, for: .normal)
        cancelButton.titleLabel?.font = .body02
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        deleteButton.layer.cornerRadius = 12
        deleteButton.backgroundColor = .colorF14C4C
        deleteButton.setTitle("삭제", for: .normal)
        deleteButton.setTitleColor(.colorFFFFFF, for: .normal)
        deleteButton.titleLabel?.font = .body03
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(alertView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(messageLabel)
        alertView.addSubview(cancelButton)
        alertView.addSubview(deleteButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        alertView.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(270)
            $0.height.equalTo(messageText == nil ? 140 : 160)
        }
        
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
        
        deleteButton.snp.makeConstraints {
            $0.bottom.equalTo(alertView).offset(-10)
            $0.trailing.equalTo(alertView).offset(-10)
            $0.width.equalTo(120)
            $0.height.equalTo(42)
        }
    }
    
    @objc func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: false)
    }
    
    @objc func deleteButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            self.onDeleteTapped?()
        }
    }
}
