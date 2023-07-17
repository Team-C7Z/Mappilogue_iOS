//
//  CycleRepeatViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/16.
//

import UIKit

class CycleRepeatViewController: BaseViewController {
    private let cycle = ["매일", "매월", "매년"]
    private var cycleButtons: [UIButton] = []
    private var selectedCycle: String?
    
    private let cycleStackView = UIStackView()

    override func setupProperty() {
        super.setupProperty()
        
        setupCycleStackView()
        createCycleButton()
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(cycleStackView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        cycleStackView.snp.makeConstraints {
            $0.top.equalTo(view).offset(18)
            $0.leading.equalTo(view).offset(16)
        }
    }
    
    private func setupCycleStackView() {
        cycleStackView.axis = .horizontal
        cycleStackView.distribution = .fillEqually
        cycleStackView.spacing = 8
    }
    
    private func createCycleButton() {
        for text in cycle {
            let button = createButton(text)
            cycleStackView.addArrangedSubview(button)
            cycleButtons.append(button)
        }
    }
    
    private func createButton(_ text: String) -> UIButton {
        let button = UIButton()
        button.setTitle(text, for: .normal)
        button.setTitleColor(.colorC9C6C2, for: .normal)
        button.titleLabel?.font = .title02
        button.layer.cornerRadius = 16
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.colorC9C6C2.cgColor
        button.addTarget(self, action: #selector(cycleButtonTapped), for: .touchUpInside)
        
        button.snp.makeConstraints {
            $0.width.equalTo(64)
            $0.height.equalTo(32)
        }
        
        return button
    }

    @objc func cycleButtonTapped(_ sender: UIButton) {
        guard let title = sender.titleLabel?.text else { return }
        
        if !sender.isSelected {
            selectedCycle = title
        }
        
        sender.isSelected = !sender.isSelected
        
        for button in cycleButtons {
            if button != sender {
                button.isSelected = false
            }
            updateCyclebuttonDesign(button)
        }
    }

    func updateCyclebuttonDesign(_ sender: UIButton) {
        sender.layer.borderWidth = sender.isSelected ? 0 : 2
        sender.backgroundColor = sender.isSelected ? .color1C1C1C : .colorFFFFFF
        sender.setTitleColor(sender.isSelected ? .colorFFFFFF : .colorC9C6C2, for: .normal)
    }
}
