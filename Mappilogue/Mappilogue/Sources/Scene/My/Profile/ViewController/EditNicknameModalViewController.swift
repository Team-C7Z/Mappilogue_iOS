//
//  EditNicknameModalViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/09/06.
//

import UIKit

class EditNicknameModalViewController: BaseViewController {
    var viewModel = ProfileViewModel()
    var onChangeTapped: ((String) -> Void)?
    
    private let alertView = UIView()
    private let inputTextField = UITextField()
    private let stackView = UIStackView()
    private let messageImage = UIImageView()
    private let messageLabel = UILabel()
    private let closeButton = UIButton()
    private let changeButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .gray404040.withAlphaComponent(0.1)
        
        alertView.layer.cornerRadius = 12
        alertView.backgroundColor = .grayF9F8F7
        
        inputTextField.textColor = .black1C1C1C
        inputTextField.font = .body02
        inputTextField.backgroundColor = .grayF5F3F0
        inputTextField.placeholder = "1~8자의 한글 또는 영문"
        inputTextField.layer.cornerRadius = 12
        inputTextField.addLeftPadding()
        inputTextField.tintColor = .green2EBD3D
        inputTextField.returnKeyType = .done
        inputTextField.delegate = self
        inputTextField.becomeFirstResponder()
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 8
        stackView.isHidden = true
        
        messageImage.image = UIImage(named: "my_validNicname")
        
        messageLabel.text = "초성이나 특수문자는 넣을 수 없어요"
        messageLabel.textColor = .gray707070
        messageLabel.font = .caption01
    
        closeButton.setTitle("닫기", for: .normal)
        closeButton.layer.cornerRadius = 12
        closeButton.backgroundColor = .grayF5F3F0
        closeButton.setTitleColor(.black1C1C1C, for: .normal)
        closeButton.titleLabel?.font = .body02
        closeButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        changeButton.setTitle("바꾸기", for: .normal)
        changeButton.layer.cornerRadius = 12
        changeButton.backgroundColor = .green2EBD3D
        changeButton.setTitleColor(.whiteFFFFFF, for: .normal)
        changeButton.titleLabel?.font = .body03
        changeButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(alertView)
        alertView.addSubview(inputTextField)
        alertView.addSubview(stackView)
        stackView.addArrangedSubview(messageImage)
        stackView.addArrangedSubview(messageLabel)
        alertView.addSubview(closeButton)
        alertView.addSubview(changeButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        alertView.snp.makeConstraints {
            $0.top.equalTo(view).offset(265)
            $0.centerX.equalTo(view)
            $0.width.equalTo(270)
            $0.height.equalTo(153)
        }

        inputTextField.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(32)
            $0.leading.equalTo(alertView).offset(16)
            $0.trailing.equalTo(alertView).offset(-16)
            $0.height.equalTo(36)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(inputTextField.snp.bottom).offset(9)
            $0.centerX.equalTo(alertView)
        }
        
        messageImage.snp.makeConstraints {
            $0.width.height.equalTo(16)
        }
        
        closeButton.snp.makeConstraints {
            $0.bottom.equalTo(alertView).offset(-10)
            $0.leading.equalTo(alertView).offset(10)
            $0.width.equalTo(120)
            $0.height.equalTo(42)
        }
        
        changeButton.snp.makeConstraints {
            $0.bottom.equalTo(alertView).offset(-10)
            $0.trailing.equalTo(alertView).offset(-10)
            $0.width.equalTo(120)
            $0.height.equalTo(42)
        }
    }
    
    func configure(_ textFieldText: String) {
        inputTextField.text = textFieldText
    }
    
    @objc private func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: false)
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        guard let text = inputTextField.text else { return }
            
        if isValidNickname(text) && !text.isEmpty {
            dismiss(animated: false) {
                self.updateNickname(text)
                self.onChangeTapped?(text)
            }
        } else {
            alertView.snp.updateConstraints {
                $0.height.equalTo(179)
            }
            stackView.isHidden = false
        }
    }
    
    private func isValidNickname(_ text: String) -> Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[가-힣0-9a-zA-Z]*$", options: .caseInsensitive)
            if let _ = regex.firstMatch(in: text, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, text.count)) {
                return true
            }
        } catch {
            print(error.localizedDescription)
            return false
        }
        return false
    }
    
    private func updateNickname(_ nickname: String) {
        viewModel.updateNickname(nickname: nickname)
    }
}

extension EditNicknameModalViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
    
        if text.count > 8 {
            textField.text = String(text.prefix(8))
        }
    }
}
