//
//  UpdateScheduleTitleColorView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/27.
//

import UIKit

class UpdateScheduleTitleColorView: BaseView {
    var delegate: ColorSelectionButtonDelegate?
    
    private let lineView = UIView()
    private let scheduleTitleTextField = UITextField()
    private var colorSelectionButton = ColorSelectionButton(textColor: .colorFFFFFF, color: .color1C1C1C)
    
    override func setupProperty() {
        super.setupProperty()
        
        lineView.backgroundColor = .colorEAE6E1

        scheduleTitleTextField.textColor = .colorC9C6C2
        scheduleTitleTextField.font = .title02
        scheduleTitleTextField.placeholder = "일정 제목을 적어 주세요"
        scheduleTitleTextField.returnKeyType = .done
        scheduleTitleTextField.delegate = self
        
        colorSelectionButton.addTarget(self, action: #selector(colorSelectionButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(lineView)
        addSubview(scheduleTitleTextField)
        addSubview(colorSelectionButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        lineView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self)
            $0.height.equalTo(1)
        }

        scheduleTitleTextField.snp.makeConstraints {
            $0.leading.centerY.equalTo(self)
            $0.height.equalTo(48)
        }
        
        colorSelectionButton.snp.makeConstraints {
            $0.trailing.equalTo(self).offset(-4)
            $0.centerY.equalTo(self)
            $0.width.equalTo(60)
            $0.height.equalTo(28)
        }
    }
    
    func configure(with scheduleTitle: String, color: UIColor, isColorSelection: Bool) {
        scheduleTitleTextField.text = scheduleTitle
        if color == .color1C1C1C || color == .color9B9791 || color == .color404040 {
            colorSelectionButton.configure(textColor: .colorFFFFFF, color: color, isColorSelection: isColorSelection)
        } else {
            colorSelectionButton.configure(textColor: .color1C1C1C, color: color, isColorSelection: isColorSelection)
        }
    }
    
    @objc func colorSelectionButtonTapped(_ button: UIButton) {
        button.isSelected = !button.isSelected
        delegate?.colorSelectionButtonTapped(button.isSelected)
    }
}

extension UpdateScheduleTitleColorView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        scheduleTitleTextField.resignFirstResponder()
        return true
    }
}

protocol ColorSelectionButtonDelegate: AnyObject {
    func colorSelectionButtonTapped(_ isSelected: Bool)
}
