//
//  MainLocationAlertViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/15.
//

import UIKit

class MainLocationAlertViewController: BaseViewController {
    var onCanelTapped: (() -> Void)?
    var onDoneTapped: (() -> Void)?

    private let alertView = UIView()
    private let titleLabel = UILabel()
    private let messageLabel = UILabel()
    private let cancelButton = UIButton()
    private let doneButton = UIButton()

    override func setupProperty() {
        super.setupProperty()

        view.backgroundColor = .gray404040.withAlphaComponent(0.1)

        alertView.layer.cornerRadius = 12
        alertView.backgroundColor = .grayF9F8F7

        titleLabel.text = "사용자 지정 위치를 대표 위치로 설정할까요?"
        titleLabel.textColor = .color000000
        titleLabel.font = .title02

        messageLabel.setTextWithLineHeight(text: "위치 정보가 없어 지도 상에서는 표시되지 않고\n기록 리스트에서만 확인할 수 있어요", lineHeight: 21)
        messageLabel.textColor = .gray707070
        messageLabel.font = .body02
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center

        cancelButton.layer.cornerRadius = 12
        cancelButton.backgroundColor = .grayF5F3F0
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.black1C1C1C, for: .normal)
        cancelButton.titleLabel?.font = .body02
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)

        doneButton.layer.cornerRadius = 12
        doneButton.backgroundColor = .green2EBD3D
        doneButton.setTitle("확인", for: .normal)
        doneButton.setTitleColor(.whiteFFFFFF, for: .normal)
        doneButton.titleLabel?.font = .body03
        doneButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }

    override func setupHierarchy() {
        super.setupHierarchy()

        view.addSubview(alertView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(messageLabel)
        alertView.addSubview(cancelButton)
        alertView.addSubview(doneButton)
    }

    override func setupLayout() {
        super.setupLayout()

        alertView.snp.makeConstraints {
            $0.center.equalTo(view.safeAreaLayoutGuide)
            $0.width.equalTo(310)
            $0.height.equalTo(194)
        }

        titleLabel.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(34)
            $0.centerX.equalTo(alertView)
        }

        messageLabel.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(66)
            $0.centerX.equalTo(alertView)
        }

        cancelButton.snp.makeConstraints {
            $0.bottom.equalTo(alertView).offset(-10)
            $0.leading.equalTo(alertView).offset(16)
            $0.width.equalTo(134)
            $0.height.equalTo(42)
        }

        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(alertView).offset(-10)
            $0.trailing.equalTo(alertView).offset(-16)
            $0.width.equalTo(134)
            $0.height.equalTo(42)
        }
    }

    @objc private func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            self.onCanelTapped?()
        }
    }

    @objc private func deleteButtonTapped(_ sender: UIButton) {
        dismiss(animated: false) {
            self.onDoneTapped?()
        }
    }
}
