//
//  SpacingButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/17.
//

import UIKit

class SpacingButton: UIButton {
    private let spacingLabel = UILabel()
    private let spacingStackView = UIStackView()
    private let spacingTextField = UITextField()
    private let spacingDateLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupProperty()
     }
    
    private func setupProperty() {
        backgroundColor = .colorFFFFFF
        
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
    
    private func setupHierarchy() {
        addSubview(spacingStackView)
        addSubview(spacingLabel)
        
        [spacingTextField, spacingDateLabel].forEach {
            spacingStackView.addArrangedSubview($0)
        }
    }
    
    private func setupLayout() {
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
        spacingTextField.delegate = self
        spacingTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        spacingTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        spacingTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
    }

}

extension SpacingButton: UITextFieldDelegate {
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
