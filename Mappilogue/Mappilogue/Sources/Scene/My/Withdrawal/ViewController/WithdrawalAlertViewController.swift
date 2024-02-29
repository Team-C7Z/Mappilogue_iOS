//
//  WithdrawalAlertViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit
import MappilogueKit

class WithdrawalAlertViewController: BaseViewController {
    var viewModel = WithdrawalAlertViewModel()
    
    private let alertView = UIView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let checkButton = UIButton()
    private let checkImage = UIImageView()
    private let checkLabel = UILabel()
    private let cancelButton = UIButton()
    private let doneButton = UIButton()
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .gray404040.withAlphaComponent(0.1)
        
        alertView.layer.cornerRadius = 12
        alertView.backgroundColor = .grayF9F8F7
        
        titleLabel.text = "정말 탈퇴하시겠어요?"
        titleLabel.textColor = .color000000
        titleLabel.font = .title02
        
        messageLabel.setTextWithLineHeight(text: "이때까지 저장된 기록과 정보가 모두 지워지고 이는 복구할 수 없어요", lineHeight: 21)
        messageLabel.textColor = .gray707070
        messageLabel.font = .body02
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.lineBreakMode = .byWordWrapping
        
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        checkImage.image = Images.image(named: .buttonUncheck)
        checkLabel.text = "주의사항을 확인했어요"
        checkLabel.textColor = .gray707070
        checkLabel.font = .body02
        
        cancelButton.layer.cornerRadius = 12
        cancelButton.backgroundColor = .grayF5F3F0
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.black1C1C1C, for: .normal)
        cancelButton.titleLabel?.font = .body02
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        doneButton.layer.cornerRadius = 12
        doneButton.backgroundColor = .grayC9C6C2
        doneButton.setTitle("탈퇴하기", for: .normal)
        doneButton.setTitleColor(.whiteFFFFFF, for: .normal)
        doneButton.titleLabel?.font = .body03
        doneButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(alertView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(messageLabel)
        alertView.addSubview(checkButton)
        checkButton.addSubview(checkImage)
        checkButton.addSubview(checkLabel)
        alertView.addSubview(cancelButton)
        alertView.addSubview(doneButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        alertView.snp.makeConstraints {
            $0.centerX.centerY.equalTo(view)
            $0.width.equalTo(278)
            $0.height.equalTo(222)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(32)
            $0.centerX.equalTo(alertView)
        }
        
        messageLabel.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(56)
            $0.leading.equalTo(alertView).offset(15)
            $0.trailing.equalTo(alertView).offset(-15)
            $0.centerX.equalTo(alertView)
        }
        
        checkButton.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(114)
            $0.centerX.equalTo(alertView)
            $0.width.equalTo(157)
        }
        
        checkImage.snp.makeConstraints {
            $0.width.height.equalTo(24)
            $0.leading.centerY.equalTo(checkButton)
        }
        
        checkLabel.snp.makeConstraints {
            $0.centerY.equalTo(checkImage)
            $0.leading.equalTo(checkImage.snp.trailing).offset(8)
        }
        
        cancelButton.snp.makeConstraints {
            $0.bottom.equalTo(alertView).offset(-10)
            $0.leading.equalTo(alertView).offset(14)
            $0.width.equalTo(120)
            $0.height.equalTo(42)
        }
        
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(alertView).offset(-10)
            $0.trailing.equalTo(alertView).offset(-14)
            $0.width.equalTo(120)
            $0.height.equalTo(42)
        }
    }
    
    @objc private func checkButtonTapped() {
        viewModel.toggleCheck()
        updateUI()
    }
    
    private func updateUI() {
        checkImage.image = Images.image(named: viewModel.isChecked ? .buttonCheck : .buttonUncheck)
        doneButton.backgroundColor = viewModel.isChecked ? .redF14C4C : .grayC9C6C2
    }
    
    @objc private func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: false)
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        if viewModel.isChecked {
            dismiss(animated: false) {
                self.viewModel.onDeleteButtonTapped?()
            }
        }
    }
}
