//
//  TimePickerViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/18.
//

import UIKit

class TimePickerViewController: BaseViewController {
    private let timePickerOuterView = UIView()
    private let cancelButton = UIButton()
    private let selectedTimeButton = UIButton()

    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .color404040.withAlphaComponent(0.1)
        
        timePickerOuterView.layer.cornerRadius = 12
        timePickerOuterView.backgroundColor = .colorF9F8F7
        
        cancelButton.setImage(UIImage(named: "cancel"), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        selectedTimeButton.setImage(UIImage(named: "selectedTime"), for: .normal)
        selectedTimeButton.addTarget(self, action: #selector(selectedTimeButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(timePickerOuterView)
        timePickerOuterView.addSubview(cancelButton)
        timePickerOuterView.addSubview(selectedTimeButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        timePickerOuterView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view)
            $0.width.height.equalTo(232)
        }
        
        cancelButton.snp.makeConstraints {
            $0.bottom.equalTo(timePickerOuterView).offset(-19)
            $0.leading.equalTo(timePickerOuterView).offset(15)
            $0.width.height.equalTo(24)
        }
        
        selectedTimeButton.snp.makeConstraints {
            $0.bottom.equalTo(timePickerOuterView).offset(-19)
            $0.trailing.equalTo(timePickerOuterView).offset(-15)
            $0.width.height.equalTo(24)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, !timePickerOuterView.frame.contains(touch.location(in: view)) else {
            return
        }

        dismiss(animated: false)
    }
    
    @objc func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: false)
    }
    
    @objc func selectedTimeButtonTapped(_ sender: UIButton) {
        dismiss(animated: false)
    }

}
