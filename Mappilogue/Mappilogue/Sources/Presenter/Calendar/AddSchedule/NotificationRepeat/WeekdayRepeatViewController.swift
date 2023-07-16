//
//  WeekdayRepeatViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/16.
//

import UIKit

class WeekdayRepeatViewController: BaseViewController {
    let days = ["월", "화", "수", "목", "금", "토", "일"]
    
    var selectedWeekday: String?
    
    var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        super.setupProperty()
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        for day in days {
            let button = UIButton()
            button.setTitle(day, for: .normal)
            button.titleLabel?.font = .body01
            button.setTitleColor(.color1C1C1C, for: .normal)
            button.layer.cornerRadius = 18
            button.backgroundColor = .colorEAE6E1
            button.addTarget(self, action: #selector(weekdayButtonTapped), for: .touchUpInside)
            
            button.snp.makeConstraints {
                $0.width.height.equalTo(36)
            }
            
            stackView.addArrangedSubview(button)
            
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(stackView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(view).offset(18)
            $0.leading.trailing.equalTo(view)
        }
    }
    
    @objc func weekdayButtonTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            selectedWeekday = title
        }
    }
}
