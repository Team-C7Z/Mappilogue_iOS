//
//  ScheduleDurationView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class ScheduleDurationView: BaseView {
    private let stackView = UIStackView()
    let startDateButton = UIButton()
    private let startLabel = UILabel()
    private let startDateLabel = UILabel()
    let endDateButton = UIButton()
    private let endLabel = UILabel()
    private let endDateLabel = UILabel()
   
    override func setupProperty() {
        super.setupProperty()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        
        startDateButton.backgroundColor = .colorF9F8F7
        endDateButton.backgroundColor = .colorF9F8F7

        startLabel.text = "시작"
        startLabel.textColor = .color707070
        startLabel.font = .body02

        startDateLabel.textColor = .color1C1C1C
        startDateLabel.font = .title02
        
        endLabel.text = "종료"
        endLabel.textColor = .color707070
        endLabel.font = .body02
        
        endDateLabel.textColor = .color1C1C1C
        endDateLabel.font = .title02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
    
        [startDateButton, endDateButton].forEach {
            stackView.addArrangedSubview($0)
        }
        addSubview(stackView)
        startDateButton.addSubview(startLabel)
        startDateButton.addSubview(startDateLabel)
        endDateButton.addSubview(endLabel)
        endDateButton.addSubview(endDateLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
  
        self.snp.makeConstraints {
            $0.height.equalTo(81)
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalTo(self)
        }

        startLabel.snp.makeConstraints {
            $0.centerX.equalTo(startDateButton)
            $0.top.equalTo(startDateButton).offset(15)
        }

        startDateLabel.snp.makeConstraints {
            $0.centerX.equalTo(startDateButton)
            $0.top.equalTo(startDateButton).offset(41)
        }

        endLabel.snp.makeConstraints {
            $0.centerX.equalTo(endDateButton)
            $0.top.equalTo(endDateButton).offset(15)
        }

        endDateLabel.snp.makeConstraints {
            $0.centerX.equalTo(endDateButton)
            $0.top.equalTo(endDateButton).offset(41)
        }
    }
    
    func configure(startDate: SelectedDate, endDate: SelectedDate, dateType: AddScheduleDateType) {
        startDateLabel.text = "\(startDate.year)년 \(startDate.month)월 \(startDate.day ?? 1)일"
        endDateLabel.text = "\(endDate.year)년 \(endDate.month)월 \(endDate.day ?? 1)일"
        
        if dateType == .startDate {
            startDateButton.backgroundColor = .colorF5F3F0
            endDateButton.backgroundColor = .colorF9F8F7
        } else if dateType == .endDate {
            startDateButton.backgroundColor = .colorF9F8F7
            endDateButton.backgroundColor = .colorF5F3F0
        } else {
            startDateButton.backgroundColor = .colorF9F8F7
            endDateButton.backgroundColor = .colorF9F8F7
        }
    }
}
