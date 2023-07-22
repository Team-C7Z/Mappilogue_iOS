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
    private let stackView = UIStackView()
    let deleteEndDateButton = UIButton()
    
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
        backgroundColor = .colorF9F8F7
        
        endLabel.text = "종료"
        endLabel.textColor = .color707070
        endLabel.font = .body02
        
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.spacing = 0

        endDateLabel.text = "없음"
        endDateLabel.textColor = .color1C1C1C
        endDateLabel.font = .title02
        
        deleteEndDateButton.setImage(UIImage(named: "deleteEndDate"), for: .normal)
        deleteEndDateButton.addTarget(self, action: #selector(deleteEndDateButtonTapped), for: .touchUpInside)
        deleteEndDateButton.isHidden = true
    }
    
    private func setupHierarchy() {
        addSubview(endLabel)
        addSubview(stackView)
        stackView.addArrangedSubview(endDateLabel)
        stackView.addArrangedSubview(deleteEndDateButton)
    }
    
    private func setupLayout() {
        endLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.centerX.equalToSuperview()
        }

        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(37)
            $0.centerX.equalTo(endLabel)
        }
        
        deleteEndDateButton.snp.makeConstraints {
            $0.width.height.equalTo(32)
        }
    }
    
    func updateEndDateLabelText(_ title: String) {
        endDateLabel.text = title
    }
    
    @objc func deleteEndDateButtonTapped(_ sender: UIButton) {
        endDateLabel.text = "없음"
        deleteEndDateButton.isHidden = true
    }
}
