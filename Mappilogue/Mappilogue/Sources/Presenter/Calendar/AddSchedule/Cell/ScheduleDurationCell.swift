//
//  ScheduleDurationCell.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/13.
//

import UIKit

class ScheduleDurationCell: BaseTableViewCell {
    static let registerId = "\(ScheduleDurationCell.self)"
    
    private let stackView = UIStackView()
    private let startView = UIView()
    private let startLabel = UILabel()
    private let startDateLabel = UILabel()
    private let endView = UIView()
    private let endLabel = UILabel()
    private let endDateLabel = UILabel()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        contentView.backgroundColor = .colorEAE6E1
        
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        
        startView.backgroundColor = .colorFFFFFF
        endView.backgroundColor = .colorFFFFFF
        
        startLabel.text = "시작"
        startLabel.textColor = .color707070
        startLabel.font = .body02
        
        startDateLabel.text = "2023년 5월 10일"
        startDateLabel.textColor = .color1C1C1C
        startDateLabel.font = .title02
        
        endLabel.text = "종료"
        endLabel.textColor = .color707070
        endLabel.font = .body02
        
        endDateLabel.text = "2023년 5월 10일"
        endDateLabel.textColor = .color1C1C1C
        endDateLabel.font = .title02
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
    
        [startView, endView].forEach {
            stackView.addArrangedSubview($0)
        }
        contentView.addSubview(stackView)
        startView.addSubview(startLabel)
        startView.addSubview(startDateLabel)
        endView.addSubview(endLabel)
        endView.addSubview(endDateLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
  
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(1)
            $0.bottom.leading.trailing.equalTo(contentView)
        }

        startLabel.snp.makeConstraints {
            $0.centerX.equalTo(startView)
            $0.top.equalTo(startView).offset(15)
        }

        startDateLabel.snp.makeConstraints {
            $0.centerX.equalTo(startView)
            $0.top.equalTo(startView).offset(41)
        }

        endLabel.snp.makeConstraints {
            $0.centerX.equalTo(endView)
            $0.top.equalTo(endView).offset(15)
        }

        endDateLabel.snp.makeConstraints {
            $0.centerX.equalTo(endView)
            $0.top.equalTo(endView).offset(41)
        }
    }
}
