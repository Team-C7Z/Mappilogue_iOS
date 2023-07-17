//
//  EndButton.swift
//  Mappilogue
//
//  Created by hyemi on 2023/07/17.
//

import UIKit

class EndButton: UIButton {
    private let endLabel = UILabel()
    private let endDateLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        setupProperty()
        setupHierarchy()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupProperty()
        setupHierarchy()
        setupLayout()
     }
    
    private func setupProperty() {
        backgroundColor = .colorFFFFFF
        
        endLabel.text = "종료"
        endLabel.textColor = .color707070
        endLabel.font = .body02

        endDateLabel.text = "없음"
        endDateLabel.textColor = .color1C1C1C
        endDateLabel.font = .title02
    }
    
    private func setupHierarchy() {
        addSubview(endLabel)
        addSubview(endDateLabel)
    }
    
    private func setupLayout() {
        endLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.centerX.equalToSuperview()
        }

        endDateLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(41)
            $0.centerX.equalToSuperview()
        }
    }
    
    func updateEndDateLabelText(_ title: String) {
        endDateLabel.text = title
    }
}
