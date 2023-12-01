//
//  DatePickerViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/11.
//

import UIKit

class DatePickerViewController: BaseViewController {
    var selectedDate: SelectedDate?
    weak var delegate: ChangedDateDelegate?
    
    let years = Array(1970...2050)
    let months = Array(1...12)
    
    let datePickerOuterView = UIView()
    let datePickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateDatePickerView()
    }
    
    override func setupProperty() {
        super.setupProperty()
    
        view.backgroundColor = .clear
        
        datePickerOuterView.backgroundColor = .grayF5F3F0
        datePickerView.delegate = self
        datePickerView.dataSource = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        view.addSubview(datePickerOuterView)
        datePickerOuterView.addSubview(datePickerView)
    }
    
    override func setupLayout() {
        super.setupLayout()

        datePickerOuterView.snp.makeConstraints {
            $0.top.equalTo(view)
            $0.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(238)
        }
        
        datePickerView.snp.makeConstraints {
            $0.top.centerX.equalTo(datePickerOuterView)
            $0.width.equalTo(245)
            $0.height.equalTo(230)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, touch.location(in: view).y > datePickerView.frame.maxY else {
            return
        }
        
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.datePickerOuterView.frame.origin.y = 0
        }, completion: { _ in
            self.dismiss(animated: false) {
                guard let date = self.selectedDate else { return }
                self.delegate?.chagedDate(date)
            }
        })
    }

    func setDate() {
        if let year = selectedDate?.year, let currentYearIndex =
            years.firstIndex(of: year) {
            datePickerView.selectRow(currentYearIndex, inComponent: 0, animated: false)
        }
        
        if let month = selectedDate?.month, let currentMonthIndex = months.firstIndex(of: month) {
            datePickerView.selectRow(currentMonthIndex, inComponent: 1, animated: false)
        }
    }
    
    private func animateDatePickerView() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.datePickerOuterView.frame.origin.y = 88
            self.view.layoutIfNeeded()
        })
    }
}

extension DatePickerViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return years.count
        case 1:
            return months.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            if let selectedYear = selectedDate?.year, selectedYear == years[row] {
                return "\(years[row]) 년"
            }
            return "\(years[row])"
        case 1:
            if let selectedMonth = selectedDate?.month, selectedMonth == months[row] {
                return "\(months[row]) 월"
            }
            return "\(months[row])"
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            selectedDate?.year = years[row]
        case 1:
            selectedDate?.month = months[row]
        default:
            break
        }
        pickerView.reloadComponent(component)
    }
}

protocol ChangedDateDelegate: AnyObject {
    func chagedDate(_ selectedDate: SelectedDate)
}
