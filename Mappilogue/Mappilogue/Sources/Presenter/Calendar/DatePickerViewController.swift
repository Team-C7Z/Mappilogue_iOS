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

    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDate()
    }
    
    override func setupProperty() {
        super.setupProperty()
    
        view.backgroundColor = .clear
        
        pickerView.backgroundColor = .colorF5F3F0
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        view.addSubview(pickerView)
    }
    
    override func setupLayout() {
        super.setupLayout()

        pickerView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(88)
            $0.leading.trailing.equalTo(view.safeAreaInsets)
            $0.height.equalTo(226)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first!.location(in: self.view).y > pickerView.frame.maxY {
            dismiss(animated: false) {
                guard let date = self.selectedDate else { return }
                
                self.delegate?.chagedDate(date)
            }
        }
    }
    
    func setDate() {
        if let year = selectedDate?.year, let currentYearIndex =
            years.firstIndex(of: year) {
            pickerView.selectRow(currentYearIndex, inComponent: 0, animated: false)
        }
        
        if let month = selectedDate?.month, let currentMonthIndex = months.firstIndex(of: month) {
            pickerView.selectRow(currentMonthIndex, inComponent: 1, animated: false)
        }
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
            return "\(years[row]) 년"
        case 1:
            return "\(months[row]) 월"
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
    }
}

protocol ChangedDateDelegate: AnyObject {
    func chagedDate(_ selectedDate: SelectedDate)
}
