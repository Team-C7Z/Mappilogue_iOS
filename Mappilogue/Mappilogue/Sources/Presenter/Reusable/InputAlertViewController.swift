//
//  InputAlertViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/01.
//

import UIKit

class InputAlertViewController: BaseViewController {
    var onCancelTapped: (() -> Void)?
    var onCompletionTapped: ((String) -> Void)?
    
    private let alertView = UIView()
    private let titleLabel = UILabel()
    private let inputTextField = UITextField()
    private let cancelButton = UIButton()
    private let completionButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .color404040.withAlphaComponent(0.1)
        
        alertView.layer.cornerRadius = 12
        alertView.backgroundColor = .colorF9F8F7
        
        titleLabel.text = "카테고리 이름을 설정해 주세요"
        titleLabel.textColor = .color000000
        titleLabel.font = .title02
        
        inputTextField.textColor = .color1C1C1C
        inputTextField.font = .body02
        inputTextField.backgroundColor = .colorF5F3F0
        inputTextField.placeholder = "새로운 카테고리"
        inputTextField.layer.cornerRadius = 12
        inputTextField.addLeftPadding()
        inputTextField.delegate = self
        inputTextField.becomeFirstResponder()
    
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.layer.cornerRadius = 12
        cancelButton.backgroundColor = .colorF5F3F0
        cancelButton.setTitleColor(.color1C1C1C, for: .normal)
        cancelButton.titleLabel?.font = .body02
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        completionButton.setTitle("확인", for: .normal)
        completionButton.layer.cornerRadius = 12
        completionButton.backgroundColor = .color2EBD3D
        completionButton.setTitleColor(.colorFFFFFF, for: .normal)
        completionButton.titleLabel?.font = .body03
        completionButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(alertView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(inputTextField)
        alertView.addSubview(cancelButton)
        alertView.addSubview(completionButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        alertView.snp.makeConstraints {
            $0.top.equalTo(view).offset(226)
            $0.centerX.equalTo(view)
            $0.width.equalTo(310)
            $0.height.equalTo(192)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(32)
            $0.centerX.equalTo(alertView)
        }
        
        inputTextField.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(80)
            $0.leading.equalTo(alertView).offset(16)
            $0.trailing.equalTo(alertView).offset(-16)
            $0.height.equalTo(36)
        }
 
        cancelButton.snp.makeConstraints {
            $0.bottom.equalTo(alertView).offset(-10)
            $0.leading.equalTo(alertView).offset(16)
            $0.width.equalTo(134)
            $0.height.equalTo(42)
        }
        
        completionButton.snp.makeConstraints {
            $0.bottom.equalTo(alertView).offset(-10)
            $0.trailing.equalTo(alertView).offset(-16)
            $0.width.equalTo(134)
            $0.height.equalTo(42)
        }
    }
    
    @objc private func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            self.onCancelTapped?()
        }
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        guard let text = inputTextField.text else { return }
        
        dismiss(animated: false) {
            self.onCompletionTapped?(text)
        }
    }
}

extension InputAlertViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
