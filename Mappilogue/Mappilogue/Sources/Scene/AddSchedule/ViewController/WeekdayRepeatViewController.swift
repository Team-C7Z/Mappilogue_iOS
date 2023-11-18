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
    
    weak var delegate: WeekdayRepeatDelegate?

    private let years: [Int] = Array(1970...2050)
    private let months: [Int] = Array(1...12)
    private var days: [Int] = []
    
    private let weekdayView = WeekdayView()
    private let separatorView = UIView()
    private let spacingEndStackView = UIStackView()
    private let spacingButton = SpacingView()
    private let endView = EndView()
    private let datePickerOuterView = UIView()
    private let datePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        hideKeyboardWhenTappedAround()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        separatorView.backgroundColor = .colorEAE6E1
        
        spacingEndStackView.axis = .horizontal
        spacingEndStackView.distribution = .fillEqually
        spacingEndStackView.spacing = 1
        
        endView.endDateButton.addTarget(self, action: #selector(endDateButtonTapped), for: .touchUpInside)
        
        datePickerOuterView.backgroundColor = .colorF5F3F0

        datePickerView.backgroundColor = .colorF5F3F0
        datePickerView.delegate = self
        datePickerView.dataSource = self
        datePickerOuterView.isHidden = true
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(weekdayView)
        
        view.addSubview(separatorView)
        separatorView.addSubview(spacingEndStackView)
        spacingEndStackView.addArrangedSubview(spacingButton)
        spacingEndStackView.addArrangedSubview(endView)
    
        view.addSubview(datePickerOuterView)
        datePickerOuterView.addSubview(datePickerView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        weekdayView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view)
            $0.height.equalTo(72)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(weekdayView.snp.bottom)
            $0.leading.equalTo(view).offset(16)
            $0.trailing.equalTo(view).offset(-16)
            $0.height.equalTo(81)
        }
        
        spacingEndStackView.snp.makeConstraints {
            $0.top.equalTo(separatorView).offset(1)
            $0.leading.trailing.bottom.equalTo(separatorView)
        }

        datePickerOuterView.snp.makeConstraints {
            $0.leading.bottom.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(236)
        }
        
        datePickerView.snp.makeConstraints {
            $0.top.equalTo(datePickerOuterView).offset(5)
            $0.leading.equalTo(datePickerOuterView).offset(33)
            $0.trailing.equalTo(datePickerOuterView).offset(-33)
            $0.bottom.equalTo(datePickerOuterView).offset(-5)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, touch.location(in: view).y < datePickerOuterView.frame.minY else {
            return
        }
        
        if !datePickerOuterView.isHidden {
            datePickerOuterView.isHidden = true
            endView.deleteEndDateButton.isHidden = false
            endView.updateEndDateLabelText("\(selectedDate.year)년 \(selectedDate.month)월 \(selectedDate.day ?? 1)일")
        }
    }
    
    private func setupData() {
        days = monthlyCalendar.getDays(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth)
        selectedDate = .init(year: monthlyCalendar.currentYear, month: monthlyCalendar.currentMonth, day: monthlyCalendar.currentDay)
        
        setSelectedDate()
    }
    
    func setSelectedDate() {
        if let currentYearIndex = years.firstIndex(of: selectedDate.year) {
            datePickerView.selectRow(currentYearIndex, inComponent: 0, animated: true)
        }
        if let currentMonthIndex = months.firstIndex(of: selectedDate.month) {
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
            if selectedDate.year == years[row] {
                return "\(years[row]) 년"
            }
            return "\(years[row])"
        case .month:
            if selectedDate.month == months[row] {
                return "\(months[row]) 월"
            }
            return "\(months[row])"
        case .day:
            if selectedDate.day == days[row] {
                return "\(days[row]) 일"
            }
            return "\(days[row])"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        guard let componentType = ComponentType(rawValue: component) else { return }
        switch componentType {
        case .year:
            selectedDate.year = years[row]
        case .month:
            selectedDate.month = months[row]
        case .day:
            selectedDate.day = days[row]
        }
        updateDaysComponent()
    }
    
    private func updateDaysComponent() {
        days = monthlyCalendar.getDays(year: selectedDate.year, month: selectedDate.month)
        datePickerView.reloadComponent(ComponentType.day.rawValue)
    }
}

protocol WeekdayRepeatDelegate: AnyObject {
    func selecteWeekdayRepeat(weekday: [String], spacing: String, endDate: SelectedDate)
}
