//
//  WithdrawalReasonView.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class WithdrawalReasonView: BaseView {
    private let withdrawalReasonLabel = UILabel()
    private let withdrawalReasonCheckButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()
        
        withdrawalReasonLabel.textColor = .color000000
        withdrawalReasonLabel.font = .body02
        withdrawalReasonCheckButton.setImage(UIImage(named: "unCheck"), for: .normal)
        withdrawalReasonCheckButton.addTarget(self, action: #selector(withdrawalReasonCheckButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        self.addSubview(withdrawalReasonLabel)
        self.addSubview(withdrawalReasonCheckButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        self.snp.makeConstraints {
            $0.height.equalTo(42)
        }
        
        withdrawalReasonLabel.snp.makeConstraints {
            $0.leading.centerY.equalTo(self)
        }
        
        withdrawalReasonCheckButton.snp.makeConstraints {
            $0.trailing.centerY.equalTo(self)
            $0.width.height.equalTo(24)
        }
    }
    
    func configure(_ title: String, _ tag: Int) {
        withdrawalReasonLabel.text = title
        withdrawalReasonCheckButton.tag = tag
    }
    
    @objc func withdrawalReasonCheckButtonTapped(_ button: UIButton) {
        button.isSelected = !button.isSelected
        updateCheckButtonDesign(button)
    }
    
    private func updateCheckButtonDesign(_ button: UIButton) {
        button.setImage(UIImage(named: button.isSelected ? "check" : "unCheck"), for: .normal)
    }
}
