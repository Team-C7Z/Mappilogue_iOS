//
//  ScheduleTitleColorView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit
import MappilogueKit

class ScheduleTitleColorView: BaseView {
    var onNameEntered: ((String) -> Void)?
    var onColorSelectionButtonTapped: ((Bool) -> Void)?
    
    private let scheduleTitleTextField = ScheduleTitleTextField()
    private var colorSelectionButton = ColorSelectionButton(textColor: .whiteFFFFFF, color: .black1C1C1C)
    
    override func setupProperty() {
        super.setupProperty()

        backgroundColor = .grayF9F8F7
        
        scheduleTitleTextField.delegate = self
        
        colorSelectionButton.addTarget(self, action: #selector(colorSelectionButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
    
        addSubview(scheduleTitleTextField)
        addSubview(colorSelectionButton)
    }
    
    override func setupLayout() {
        super.setupLayout()

        self.snp.makeConstraints {
            $0.height.equalTo(48)
        }
        
        scheduleTitleTextField.snp.makeConstraints {
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
    
    func configure(_ isAdd: Bool, title: String, colorId: Int, color: UIColor, isColorSelection: Bool) {
        scheduleTitleTextField.text = title
        scheduleTitleTextField.textColor = isAdd ? .black1C1C1C : .grayC9C6C2
        
        if color == .black1C1C1C || color == .gray9B9791 || color == .gray404040 {
            colorSelectionButton.configure(textColor: .whiteFFFFFF, color: color, isColorSelection: isColorSelection)
        } else {
            colorSelectionButton.configure(textColor: .black1C1C1C, color: color, isColorSelection: isColorSelection)
        }
    }
    
    @objc func colorSelectionButtonTapped(_ button: UIButton) {
        button.isSelected = !button.isSelected
        onColorSelectionButtonTapped?(button.isSelected)
    }
}

extension ScheduleTitleColorView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        scheduleTitleTextField.resignFirstResponder()
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        onNameEntered?(scheduleTitleTextField.text ?? "")
    }
}
