//
//  TimePickerViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/18.
//

import UIKit

class TimePickerViewController: BaseViewController {
    private let timePickerOuterView = UIView()
    private let deleteTimeButton = UIButton()
    private let deleteTimeImage = UIImageView()
    private let deleteTimeLabel = UILabel()
    private let cancelButton = UIButton()
    private let selectedTimeButton = UIButton()
    
    var datePicker = UIDatePicker()

    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .color404040.withAlphaComponent(0.1)
        
        timePickerOuterView.layer.cornerRadius = 12
        timePickerOuterView.backgroundColor = .colorF9F8F7
        
        deleteTimeImage.image = UIImage(named: "deleteTime")
        
        deleteTimeLabel.text = "시간삭제"
        deleteTimeLabel.textColor = .color707070
        deleteTimeLabel.font = .caption02
        
        cancelButton.setImage(UIImage(named: "cancel"), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        selectedTimeButton.setImage(UIImage(named: "selectedTime"), for: .normal)
        selectedTimeButton.addTarget(self, action: #selector(selectedTimeButtonTapped), for: .touchUpInside)
        
        datePicker.datePickerMode = .time
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "en_US_POSIX")
        
        let initialTime = "09:00 AM"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        if let date = dateFormatter.date(from: initialTime) {
            datePicker.date = date
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(timePickerOuterView)
        timePickerOuterView.addSubview(deleteTimeButton)
        deleteTimeButton.addSubview(deleteTimeImage)
        deleteTimeButton.addSubview(deleteTimeLabel)
        
        timePickerOuterView.addSubview(datePicker)
        
        timePickerOuterView.addSubview(cancelButton)
        timePickerOuterView.addSubview(selectedTimeButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        timePickerOuterView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view)
            $0.width.equalTo(232)
            $0.height.equalTo(264)
        }
        
        deleteTimeButton.snp.makeConstraints {
            $0.top.equalTo(timePickerOuterView).offset(12)
            $0.trailing.equalTo(timePickerOuterView).offset(-20)
            $0.width.equalTo(58)
            $0.height.equalTo(32)
        }
        
        deleteTimeImage.snp.makeConstraints {
            $0.centerY.leading.equalTo(deleteTimeButton)
            $0.width.height.equalTo(14)
        }
        
        deleteTimeLabel.snp.makeConstraints {
            $0.centerY.equalTo(deleteTimeButton)
            $0.leading.equalTo(deleteTimeImage.snp.trailing).offset(2)
        }
        
        datePicker.snp.makeConstraints {
            $0.top.equalTo(timePickerOuterView).offset(56)
            $0.centerX.equalTo(timePickerOuterView)
            $0.width.equalTo(192)
            $0.height.equalTo(136)
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
