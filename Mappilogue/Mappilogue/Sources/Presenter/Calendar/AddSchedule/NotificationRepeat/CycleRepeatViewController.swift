//
//  CycleRepeatViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/16.
//

import UIKit

class CycleRepeatViewController: BaseViewController {
    var selectedCycle: String?
    
    var weekdayButton: [UIButton] = []
    
    private let weekdayStackView = UIStackView()
    private var dailyButton = UIButton()
    private let monthlyButton = UIButton()
    private let yearlyButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        weekdayStackView.axis = .horizontal
        weekdayStackView.distribution = .fillEqually
        weekdayStackView.spacing = 8
        
        dailyButton.setTitle("매일", for: .normal)
        dailyButton.setTitleColor(.colorC9C6C2, for: .normal)
        dailyButton.titleLabel?.font = .title02
        dailyButton.layer.cornerRadius = 16
        dailyButton.layer.borderWidth = 2
        dailyButton.layer.borderColor = UIColor.colorC9C6C2.cgColor
        dailyButton.addTarget(self, action: #selector(cycleButtonTapped), for: .touchUpInside)
        
        monthlyButton.setTitle("매월", for: .normal)
        monthlyButton.setTitleColor(.colorC9C6C2, for: .normal)
        monthlyButton.titleLabel?.font = .title02
        monthlyButton.layer.cornerRadius = 16
        monthlyButton.layer.borderWidth = 2
        monthlyButton.layer.borderColor = UIColor.colorC9C6C2.cgColor
        monthlyButton.addTarget(self, action: #selector(cycleButtonTapped), for: .touchUpInside)
        
        yearlyButton.setTitle("매년", for: .normal)
        yearlyButton.setTitleColor(.colorC9C6C2, for: .normal)
        yearlyButton.titleLabel?.font = .title02
        yearlyButton.layer.cornerRadius = 16
        yearlyButton.layer.borderWidth = 2
        yearlyButton.layer.borderColor = UIColor.colorC9C6C2.cgColor
        yearlyButton.addTarget(self, action: #selector(cycleButtonTapped), for: .touchUpInside)
        
        weekdayButton = [dailyButton, monthlyButton, yearlyButton]
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(weekdayStackView)
        [dailyButton, monthlyButton, yearlyButton].forEach {
            weekdayStackView.addArrangedSubview($0)
        }
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        weekdayStackView.snp.makeConstraints {
            $0.top.equalTo(view).offset(18)
            $0.leading.equalTo(view).offset(16)
        }
        
        dailyButton.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.height.equalTo(32)
        }

        monthlyButton.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.height.equalTo(32)
        }

        yearlyButton.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.height.equalTo(32)
        }
    }

    @objc func cycleButtonTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text, !sender.isSelected {
            selectedCycle = title
        }
        
        sender.isSelected = !sender.isSelected
        
        for button in weekdayButton {
            if button != sender {
                button.isSelected = false
            }
            updateCycleButtonDesign(button)
        }
    }
    
    func updateCycleButtonDesign(_ sender: UIButton) {
        sender.layer.borderWidth = sender.isSelected ? 0 : 2
        sender.backgroundColor = sender.isSelected ? .color1C1C1C : .colorFFFFFF
        sender.setTitleColor(sender.isSelected ? .colorFFFFFF : .colorC9C6C2, for: .normal)
    }
}
