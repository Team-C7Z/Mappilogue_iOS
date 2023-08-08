//
//  AddScheduleTitleColorView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class AddScheduleTitleColorView: BaseView {
    var onNameEntered: ((String) -> Void)?
    var onColorSelectionButtonTapped: ((Bool) -> Void)?
    
    private let scheduleNameTextField = UITextField()
    private var colorSelectionButton = ColorSelectionButton(textColor: .colorFFFFFF, color: .color1C1C1C)
    
    override func setupProperty() {
        super.setupProperty()

        backgroundColor = .colorF9F8F7
        
        scheduleNameTextField.font = .title02
        scheduleNameTextField.placeholder = "일정 제목을 적어 주세요"
        scheduleNameTextField.returnKeyType = .done
        scheduleNameTextField.delegate = self
        
        colorSelectionButton.addTarget(self, action: #selector(colorSelectionButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
    
        addSubview(scheduleNameTextField)
        addSubview(colorSelectionButton)
    }
    
    override func setupLayout() {
        super.setupLayout()

        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        scheduleNameTextField.snp.makeConstraints {
            $0.leading.centerY.equalTo(self)
            $0.width.equalTo(275)
            $0.height.equalTo(48)
        }
        
        colorSelectionButton.snp.makeConstraints {
            $0.trailing.centerY.equalTo(self)
            $0.width.equalTo(60)
            $0.height.equalTo(28)
        }
    }
    
    func configure(with scheduleTitle: String, color: UIColor, isColorSelection: Bool) {
        scheduleNameTextField.text = scheduleTitle
        
        if color == .color1C1C1C || color == .color9B9791 || color == .color404040 {
            colorSelectionButton.configure(textColor: .colorFFFFFF, color: color, isColorSelection: isColorSelection)
        } else {
            colorSelectionButton.configure(textColor: .color1C1C1C, color: color, isColorSelection: isColorSelection)
        }
    }
    
    @objc func colorSelectionButtonTapped(_ button: UIButton) {
        button.isSelected = !button.isSelected
        onColorSelectionButtonTapped?(button.isSelected)
    }
}

extension AddScheduleTitleColorView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        scheduleNameTextField.resignFirstResponder()
        onNameEntered?(scheduleNameTextField.text ?? "")
        return true
    }

}
