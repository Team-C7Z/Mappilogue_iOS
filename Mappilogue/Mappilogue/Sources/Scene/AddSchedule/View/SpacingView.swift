//
//  SpacingView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/17.
//

import UIKit

class SpacingView: BaseView {
    private let spacingLabel = UILabel()
    private let spacingStackView = UIStackView()
    private let spacingTextField = UITextField()
    private let spacingDateLabel = UILabel()
    
    override func setupProperty() {
        super.setupProperty()
        
        backgroundColor = .colorF9F8F7
        
        spacingStackView.axis = .horizontal
        spacingStackView.distribution = .fillEqually
        spacingStackView.spacing = 0
        
        spacingLabel.text = "간격"
        spacingLabel.textColor = .color707070
        spacingLabel.font = .body02
        
        setupSpacingTextField()
        
        spacingDateLabel.text = "주"
        spacingTextField.textColor = .color1C1C1C
        spacingTextField.font = .title02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(spacingStackView)
        addSubview(spacingLabel)
        
        [spacingTextField, spacingDateLabel].forEach {
            spacingStackView.addArrangedSubview($0)
        }
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        spacingLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.centerX.equalToSuperview()
        }

        spacingStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(41)
            $0.centerX.equalToSuperview()
        }
    }
    
    private func setupSpacingTextField() {
        spacingTextField.text = "1"
        spacingTextField.textColor = .color1C1C1C
        spacingTextField.font = .title02
        spacingTextField.keyboardType = .numberPad
        spacingTextField.textAlignment = .center
        spacingTextField.tintColor = .color2EBD3D
        spacingTextField.delegate = self
        spacingTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        spacingTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        spacingTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }

}

extension SpacingView: UITextFieldDelegate {
    @objc func textFieldDidBeginEditing(_ textField: UITextField) {
        spacingTextField.text = ""
    }
    
    @objc func textFieldEditingChanged(_ textField: UITextField) {
        if let spacing = spacingTextField.text, spacing.count > 2 {
            spacingTextField.text = String(spacing.prefix(2))
        }
    }
    
    @objc func textFieldDidEndEditing(_ textField: UITextField) {
        if let spacing = spacingTextField.text, spacing.isEmpty {
            spacingTextField.text = "1"
        }
    }
}
