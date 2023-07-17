//
//  WeekdayView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/17.
//

import UIKit

class WeekdayView: BaseView {
    private let weekday = ["월", "화", "수", "목", "금", "토", "일"]
    private var selectedWeekdays: [String] = []
    
    private let weekdayStackView = UIStackView()
    
    override func setupProperty() {
        super.setupProperty()
        
        weekdayStackView.axis = .horizontal
        weekdayStackView.distribution = .equalSpacing
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        addSubview(weekdayStackView)
        createWeekdayButton()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        weekdayStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
            $0.trailing.equalToSuperview().offset(-16)
        }
    }
    
    private func createWeekdayButton() {
        for day in weekday {
            let button = createButton(day)
            weekdayStackView.addArrangedSubview(button)
        }
    }
    
    private func createButton(_ title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.titleLabel?.font = .body01
        button.setTitleColor(.color1C1C1C, for: .normal)
        button.layer.cornerRadius = 18
        button.backgroundColor = .colorEAE6E1
        button.addTarget(self, action: #selector(weekdayButtonTapped), for: .touchUpInside)
    
        button.snp.makeConstraints {
            $0.width.height.equalTo(36)
        }
        
        return button
    }
    
    @objc func weekdayButtonTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            selectedWeekdays.append(title)
        } else {
            if let index = selectedWeekdays.firstIndex(of: title) {
                selectedWeekdays.remove(at: index)
            }
        }
        
        updateCycleButtonDesign(sender)
    }
    
    func updateCycleButtonDesign(_ button: UIButton) {
        button.backgroundColor = button.isSelected ? .color1C1C1C : .colorEAE6E1
        button.setTitleColor(button.isSelected ? .colorFFFFFF : .color1C1C1C, for: .normal)
    }
}
