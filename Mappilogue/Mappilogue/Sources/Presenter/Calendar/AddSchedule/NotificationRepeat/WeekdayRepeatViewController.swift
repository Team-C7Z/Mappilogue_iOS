//
//  WeekdayRepeatViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/16.
//

import UIKit

class WeekdayRepeatViewController: BaseViewController {
    private var monthlyCalendar = MonthlyCalendar()
    private var selectedDate: SelectedDate = SelectedDate(year: 0, month: 0, day: 0)
    
    let weekday = ["월", "화", "수", "목", "금", "토", "일"]
    
    let years: [Int] = Array(1970...2050)
    let months: [Int] = Array(1...12)
    var days: [Int] = []
    
    var selectedWeekday: [String] = []
    var weekdayButton: [UIButton] = []
    
    private let weekdayStackView = UIStackView()
    private let mondayButtoun = UIButton()
    private let tuesdayButtoun = UIButton()
    private let wednesdayButton = UIButton()
    private let thursdayButton = UIButton()
    private let fridayButtoun = UIButton()
    private let saturdayButton = UIButton()
    private let sundayButtoun = UIButton()
    
    private let separatorView = UIView()
    private let spacingEndStackView = UIStackView()
    
    private let spacingButton = UIButton()
    private let spacingLabel = UILabel()
    private let spacingStackView = UIStackView()
    private let spacingTextField = UITextField()
    private let spacingDateLabel = UILabel()
    
    private let endButton = UIButton()
    private let endLabel = UILabel()
    private let endDateLabel = UILabel()
    
    private let datePickerOuterView = UIView()
    private let datePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboardWhenTappedAround()
        
        days = monthlyCalendar.getDays(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth)
        selectedDate = .init(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth, day: monthlyCalendar.currentDay)
        
        setSelectedDate()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        weekdayStackView.axis = .horizontal
        weekdayStackView.distribution = .equalSpacing
        
        weekdayButton = [mondayButtoun, tuesdayButtoun, wednesdayButton, thursdayButton, fridayButtoun, saturdayButton, sundayButtoun]
        for (index, button) in weekdayButton.enumerated() {
            button.setTitle(weekday[index], for: .normal)
            button.titleLabel?.font = .body01
            button.setTitleColor(.color1C1C1C, for: .normal)
            button.layer.cornerRadius = 18
            button.backgroundColor = .colorEAE6E1
            button.addTarget(self, action: #selector(weekdayButtonTapped), for: .touchUpInside)
            
            button.snp.makeConstraints {
                $0.width.height.equalTo(36)
            }
            
            weekdayStackView.addArrangedSubview(button)
        }
        
        separatorView.backgroundColor = .colorEAE6E1
        
        spacingEndStackView.axis = .horizontal
        spacingEndStackView.distribution = .fillEqually
        spacingEndStackView.spacing = 1
        
        spacingButton.backgroundColor = .colorFFFFFF
        endButton.backgroundColor = .colorFFFFFF
        
        spacingStackView.axis = .horizontal
        spacingStackView.distribution = .fillEqually
        spacingStackView.spacing = 0
        
        spacingLabel.text = "간격"
        spacingLabel.textColor = .color707070
        spacingLabel.font = .body02

        spacingTextField.text = "1"
        spacingTextField.textColor = .color1C1C1C
        spacingTextField.font = .title02
        spacingTextField.keyboardType = .numberPad
        spacingTextField.textAlignment = .center
        spacingTextField.delegate = self
        spacingTextField.addTarget(self, action: #selector(textFieldDidBeginEditing), for: .editingDidBegin)
        spacingTextField.addTarget(self, action: #selector(textFieldEditingChanged), for: .editingChanged)
        spacingTextField.addTarget(self, action: #selector(textFieldDidEndEditing), for: .editingDidEnd)
        
        spacingDateLabel.text = "주"
        spacingTextField.textColor = .color1C1C1C
        spacingTextField.font = .title02

        endLabel.text = "종료"
        endLabel.textColor = .color707070
        endLabel.font = .body02

        endDateLabel.text = "없음"
        endDateLabel.textColor = .color1C1C1C
        endDateLabel.font = .title02
        
        endButton.addTarget(self, action: #selector(endDateButtonTapped), for: .touchUpInside)
        
        datePickerOuterView.backgroundColor = .colorF5F3F0
        
        datePickerView.backgroundColor = .colorF5F3F0
        datePickerView.delegate = self
        datePickerView.dataSource = self
        datePickerOuterView.isHidden = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(weekdayStackView)
        view.addSubview(separatorView)
        separatorView.addSubview(spacingEndStackView)
        
        [spacingButton, endButton].forEach {
            spacingEndStackView.addArrangedSubview($0)
        }
        
        spacingButton.addSubview(spacingStackView)
        spacingButton.addSubview(spacingLabel)
        
        [spacingTextField, spacingDateLabel].forEach {
            spacingStackView.addArrangedSubview($0)
        }
        
        endButton.addSubview(endLabel)
        endButton.addSubview(endDateLabel)
        
        view.addSubview(datePickerOuterView)
        datePickerOuterView.addSubview(datePickerView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        weekdayStackView.snp.makeConstraints {
            $0.top.equalTo(view).offset(18)
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(view).offset(-16)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(weekdayStackView.snp.bottom).offset(18)
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(view).offset(-16)
            $0.height.equalTo(81)
        }
        
        spacingEndStackView.snp.makeConstraints {
            $0.top.equalTo(separatorView).offset(1)
            $0.leading.trailing.bottom.equalTo(separatorView)
        }
        
        spacingLabel.snp.makeConstraints {
            $0.top.equalTo(spacingButton).offset(15)
            $0.centerX.equalTo(spacingButton)
        }

        spacingStackView.snp.makeConstraints {
            $0.top.equalTo(spacingButton).offset(41)
            $0.centerX.equalTo(spacingButton)
        }

        endLabel.snp.makeConstraints {
            $0.top.equalTo(endButton).offset(15)
            $0.centerX.equalTo(endButton)
        }

        endDateLabel.snp.makeConstraints {
            $0.top.equalTo(endButton).offset(41)
            $0.centerX.equalTo(endButton)
        }
        
        datePickerOuterView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(236)
        }
        
        datePickerView.snp.makeConstraints {
            $0.top.equalTo(datePickerOuterView).offset(5)
            $0.leading.equalTo(datePickerOuterView).offset(40)
            $0.trailing.equalTo(datePickerOuterView).offset(-40)
            $0.bottom.equalTo(datePickerOuterView).offset(-5)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, touch.location(in: view).y < datePickerOuterView.frame.minY else {
            return
        }
        if !datePickerOuterView.isHidden {
            datePickerOuterView.isHidden = true
            endDateLabel.text = "\(selectedDate.year)년 \(selectedDate.month)월 \(selectedDate.day ?? 1)일"
        }
    }
    
    @objc func weekdayButtonTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            sender.isSelected = !sender.isSelected
            
            if sender.isSelected {
                selectedWeekday.append(title)
            } else {
                if let index = selectedWeekday.firstIndex(of: title) {
                    selectedWeekday.remove(at: index)
                }
            }
            
            updateCycleButtonDesign(sender)
        }
    }
    
    func updateCycleButtonDesign(_ sender: UIButton) {
        sender.backgroundColor = sender.isSelected ? .color1C1C1C : .colorEAE6E1
        sender.setTitleColor(sender.isSelected ? .colorFFFFFF : .color1C1C1C, for: .normal)
    }
    
    func setSelectedDate() {
        let year = selectedDate.year
        if let currentYearIndex = years.firstIndex(of: year) {
            datePickerView.selectRow(currentYearIndex, inComponent: 0, animated: true)
        }
        let month = selectedDate.month
        if let currentMonthIndex = months.firstIndex(of: month) {
            datePickerView.selectRow(currentMonthIndex, inComponent: 1, animated: true)
        }

        if let day = selectedDate.day, let currentDayIndex = days.firstIndex(of: day) {
            datePickerView.selectRow(currentDayIndex, inComponent: 2, animated: true)
        }
    }
    
    @objc func endDateButtonTapped(_ sender: UIButton) {
        datePickerOuterView.isHidden = false
    }
}

extension WeekdayRepeatViewController: UITextFieldDelegate {
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

extension WeekdayRepeatViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    enum ComponentType: Int, CaseIterable {
        case year
        case month
        case day
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return ComponentType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        guard let componentType = ComponentType(rawValue: component) else {
            return 0
        }
        
        switch componentType {
        case .year:
            return years.count
        case .month:
            return months.count
        case .day:
            return days.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        guard let componentType = ComponentType(rawValue: component) else { return nil }
        
        switch componentType {
        case .year:
            return "\(years[row])"
        case .month:
            return "\(months[row])"
        case .day:
            return "\(days[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let componentType = ComponentType(rawValue: component) else { return }
        switch componentType {
        case .year:
            selectedDate.year = years[row]
            days = monthlyCalendar.getDays(year: selectedDate.year, month: selectedDate.month)
            datePickerView.reloadComponent(2)
        case .month:
            selectedDate.month = months[row]
            days = monthlyCalendar.getDays(year: selectedDate.year, month: selectedDate.month)
            datePickerView.reloadComponent(2)
        case .day:
            selectedDate.day = days[row]
        }
    }
}
