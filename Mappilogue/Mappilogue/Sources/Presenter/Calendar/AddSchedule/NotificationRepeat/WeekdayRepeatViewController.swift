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
    
    private let weekdayStackView = UIStackView()
    private let separatorView = UIView()
    private let spacingEndStackView = UIStackView()
    private let spacingButton = UIButton()
    private let spacingLabel = UILabel()
    private let spacingTextField = UITextField()
    private let endButton = UIButton()
    private let endLabel = UILabel()
    private let endDateLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        weekdayStackView.axis = .horizontal
        weekdayStackView.distribution = .equalSpacing
        
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
            
            weekdayStackView.addArrangedSubview(button)
        }
        
        separatorView.backgroundColor = .colorEAE6E1
        
        spacingEndStackView.axis = .horizontal
        spacingEndStackView.distribution = .fillEqually
        spacingEndStackView.spacing = 1
        
        spacingButton.backgroundColor = .colorFFFFFF
        endButton.backgroundColor = .colorFFFFFF
        
        spacingLabel.text = "간격"
        spacingLabel.textColor = .color707070
        spacingLabel.font = .body02

        spacingTextField.text = "1주"
        spacingTextField.textColor = .color1C1C1C
        spacingTextField.font = .title02

        endLabel.text = "간격"
        endLabel.textColor = .color707070
        endLabel.font = .body02

        endDateLabel.text = "없음"
        endDateLabel.textColor = .color1C1C1C
        endDateLabel.font = .title02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(weekdayStackView)
        view.addSubview(separatorView)
        separatorView.addSubview(spacingEndStackView)
        
        [spacingButton, endButton].forEach {
            spacingEndStackView.addArrangedSubview($0)
        }
        
        spacingButton.addSubview(spacingLabel)
        spacingButton.addSubview(spacingTextField)

        endButton.addSubview(endLabel)
        endButton.addSubview(endDateLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        weekdayStackView.snp.makeConstraints {
            $0.top.equalTo(view).offset(18)
            $0.leading.trailing.equalTo(view)
        }
        
        separatorView.snp.makeConstraints {
            $0.top.equalTo(weekdayStackView.snp.bottom).offset(18)
            $0.leading.trailing.equalTo(view)
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

        spacingTextField.snp.makeConstraints {
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
        
    }
    
    @objc func weekdayButtonTapped(_ sender: UIButton) {
        if let title = sender.titleLabel?.text {
            selectedWeekday = title
        }
    }
}
