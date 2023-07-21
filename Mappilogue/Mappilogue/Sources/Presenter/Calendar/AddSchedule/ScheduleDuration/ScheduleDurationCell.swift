//
//  ScheduleDurationCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class ScheduleDurationCell: BaseTableViewCell {
    static let registerId = "\(ScheduleDurationCell.self)"
    
    private var startDate: SelectedDate = SelectedDate(year: 0, month: 0, day: 0)
    private var endDate: SelectedDate = SelectedDate(year: 0, month: 0, day: 0)
    
    weak var startDateDelegate: DatePickerStartDateDelegate?
    weak var endDateDelegate: DatePickerEndDateDelegate?
    
    private let stackView = UIStackView()
    private let startDateButton = UIButton()
    private let startLabel = UILabel()
    private let startDateLabel = UILabel()
    private let endDateButton = UIButton()
    private let endLabel = UILabel()
    private let endDateLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        
        startDateButton.backgroundColor = .colorF9F8F7
        startDateButton.addTarget(self, action: #selector(startDateButtonTapped), for: .touchUpInside)
        
        endDateButton.backgroundColor = .colorF9F8F7
        endDateButton.addTarget(self, action: #selector(endDateButtonTapped), for: .touchUpInside)

        startLabel.text = "시작"
        startLabel.textColor = .color707070
        startLabel.font = .body02
        
        startDateLabel.text = "\(startDate.year)년 \(startDate.month)월 \(startDate.day ?? 1)일"
        startDateLabel.textColor = .color1C1C1C
        startDateLabel.font = .title02
        
        endLabel.text = "종료"
        endLabel.textColor = .color707070
        endLabel.font = .body02
        
        endDateLabel.text = "\(endDate.year)년 \(endDate.month)월 \(endDate.day ?? 1)일"
        endDateLabel.textColor = .color1C1C1C
        endDateLabel.font = .title02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
    
        [startDateButton, endDateButton].forEach {
            stackView.addArrangedSubview($0)
        }
        contentView.addSubview(stackView)
        startDateButton.addSubview(startLabel)
        startDateButton.addSubview(startDateLabel)
        endDateButton.addSubview(endLabel)
        endDateButton.addSubview(endDateLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
  
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(1)
            $0.bottom.leading.trailing.equalTo(contentView)
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
    
    func configure(startDate: SelectedDate, endDate: SelectedDate) {
        self.startDate = startDate
        self.endDate = endDate
    }
    
    @objc func startDateButtonTapped(_ sender: UIButton) {
        startDateDelegate?.startDateButtonTapped()
    }
    
    @objc func endDateButtonTapped(_ sender: UIButton) {
        endDateDelegate?.endDateButtonTapped()
    }
}

protocol DatePickerStartDateDelegate: AnyObject {
    func startDateButtonTapped()
}

protocol DatePickerEndDateDelegate: AnyObject {
    func endDateButtonTapped()
}
