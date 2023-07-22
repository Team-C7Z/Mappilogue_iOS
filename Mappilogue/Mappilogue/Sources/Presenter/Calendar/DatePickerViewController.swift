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
    
    let pickerOuterView = UIView()
    let pickerView = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setDate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        animateView()
    }
    
    override func setupProperty() {
        super.setupProperty()
    
        view.backgroundColor = .clear
        
        pickerOuterView.backgroundColor = .colorF5F3F0
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        view.addSubview(pickerOuterView)
        pickerOuterView.addSubview(pickerView)
    }
    
    override func setupLayout() {
        super.setupLayout()

        pickerOuterView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(-50)
            $0.leading.trailing.equalTo(view.safeAreaInsets)
            $0.height.equalTo(238)
        }
        
        pickerView.snp.makeConstraints {
            $0.top.centerX.equalTo(pickerOuterView)
            $0.width.equalTo(245)
            $0.height.equalTo(230)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, touch.location(in: view).y > pickerView.frame.maxY else {
            return
        }
        
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseInOut, animations: {
            self.pickerOuterView.frame.origin.y = 20
            self.view.layoutIfNeeded()
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.2) {
                self.dismiss(animated: false) {
                    guard let date = self.selectedDate else { return }
                    self.delegate?.chagedDate(date)
                }
            }
        })
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
    
    private func animateView() {
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.pickerOuterView.frame.origin.y = 90
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
