//
//  TimePickerViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/18.
//

import UIKit
import MappilogueKit

class TimePickerViewController: BaseViewController {
    var selectedTime: String = ""
    var onSelectedTime: ((String) -> Void)?
    
    private let timePickerOuterView = UIView()
    private let deleteTimeButton = UIButton()
    private let deleteTimeImage = UIImageView()
    private let deleteTimeLabel = UILabel()
    private let timePicker = UIDatePicker()
    private let cancelButton = UIButton()
    private let selectedTimeButton = UIButton()

    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .gray404040.withAlphaComponent(0.1)
        
        timePickerOuterView.layer.cornerRadius = 12
        timePickerOuterView.backgroundColor = .grayF9F8F7
        
        deleteTimeButton.addTarget(self, action: #selector(deleteTimeButtonTapped), for: .touchUpInside)
        
        deleteTimeImage.image = Images.image(named: .imageDelete)
        deleteTimeImage.tintColor = .redF14C4C
        
        deleteTimeLabel.text = "시간삭제"
        deleteTimeLabel.textColor = .gray707070
        deleteTimeLabel.font = .caption02
        
        cancelButton.setImage(UIImage(named: "cancel"), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        selectedTimeButton.setImage(Images.image(named: .buttonCheckTime), for: .normal)
        selectedTimeButton.addTarget(self, action: #selector(selectedTimeButtonTapped), for: .touchUpInside)
        
        setTimePicker()
        
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(timePickerOuterView)
        timePickerOuterView.addSubview(deleteTimeButton)
        deleteTimeButton.addSubview(deleteTimeImage)
        deleteTimeButton.addSubview(deleteTimeLabel)
        
        timePickerOuterView.addSubview(timePicker)
        
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
        
        timePicker.snp.makeConstraints {
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
    
    func setTimePicker() {
        timePicker.datePickerMode = .time
        timePicker.preferredDatePickerStyle = .wheels
        timePicker.locale = Locale(identifier: "en_US_POSIX")
        timePicker.addTarget(self, action: #selector(timePickerValueDidChange), for: .valueChanged)

        timePicker.date = selectedTime.formatTohmmaStringToDate()
    }
    
    @objc private func deleteTimeButtonTapped(_ sender: UIButton) {
        selectedTime = "설정 안 함"
        dismiss(animated: false) {
            self.onSelectedTime?(self.selectedTime)
        }
    }
    
    @objc private func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: false)
    }
    
    @objc private func selectedTimeButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            self.onSelectedTime?(self.selectedTime)
        }
    }
    
    @objc private func timePickerValueDidChange(_ timePicker: UIDatePicker) {
        selectedTime = timePicker.date.formatTohmmaDateToString()
    }
}
