//
//  WithdrawalViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit
import KakaoSDKUser

class WithdrawalViewController: WithdrawalNavigationViewController {
    var authViewModel = AuthViewModel()
    
    let withdrawalReasons = [
        "이제 이 서비스가 필요하지 않아요",
        "어플이 사용하기 어려워요",
        "어플에 오류가 있어요",
        "재가입을 하고 싶어요",
        "기능들이 마음에 들지 않거나 부족해요",
        "기타"
    ]
    var selectedReasons: [Bool] = []
    var isSelectedReason: Bool = false
    var onWithdrawal: (() -> Void)?
    
    private let withdrawalTitleLabel = UILabel()
    private let withdrawalSubTitleLabel = UILabel()
    private let stackView = UIStackView()
    private let submitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        selectedReasons = Array(repeating: false, count: withdrawalReasons.count)
        createWithdrawalReasonView()
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        skipButton.addTarget(self, action: #selector(performWithdrawal), for: .touchUpInside)
        
        withdrawalTitleLabel.text = "탈퇴하는 이유가 있나요?"
        withdrawalTitleLabel.textColor = .black1C1C1C
        withdrawalTitleLabel.font = .title01
        
        withdrawalSubTitleLabel.text = "더 좋은 서비스를 만드는 데에 참고할게요"
        withdrawalSubTitleLabel.textColor = .gray707070
        withdrawalSubTitleLabel.font = .body02
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        
        submitButton.layer.cornerRadius = 12
        submitButton.backgroundColor = .grayC9C6C2
        submitButton.setTitle("제출하기", for: .normal)
        submitButton.setTitleColor(.whiteFFFFFF, for: .normal)
        submitButton.titleLabel?.font = .body03
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()

        view.addSubview(withdrawalTitleLabel)
        view.addSubview(withdrawalSubTitleLabel)
        view.addSubview(stackView)
        view.addSubview(submitButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        withdrawalTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(98)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        withdrawalSubTitleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(142)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(withdrawalSubTitleLabel.snp.bottom).offset(19)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        submitButton.snp.makeConstraints {
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(53)
        }
    }
    
    private func createWithdrawalReasonView() {
        for (index, title) in withdrawalReasons.enumerated() {
            let withdrawalReasonView = WithdrawalReasonView()
            withdrawalReasonView.configure(title, index)
            withdrawalReasonView.onReasonSelected = { index in
                self.updateSelectedReasons(index)
            }
            stackView.addArrangedSubview(withdrawalReasonView)
        }
    }
    
    private func updateSelectedReasons(_ index: Int) {
        selectedReasons[index] = !selectedReasons[index]
        isSelectedReason = selectedReasons.contains(true)
        updateSubmitButtonDesign()
    }
    
    private func updateSubmitButtonDesign() {
        submitButton.backgroundColor = isSelectedReason ? .green2EBD3D : .grayC9C6C2
    }
    
    @objc func submitButtonTapped() {
        if isSelectedReason {
            performWithdrawal()
        }
    }
    
    @objc private func performWithdrawal() {
        UserApi.shared.unlink { error in
            if let error = error {
                print(error)
            } else {
                self.handleUserManagerWithdrawal()
            }
        }
    }
    
    private func handleUserManagerWithdrawal() {
        authViewModel.withdrawal(reason: self.withdrawalReason())
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("error: \(error.localizedDescription)")
                }
            } receiveValue: { _ in
                self.clearAuthUserDefaults()
                self.completeWithdrawal()
            }
            .store(in: &authViewModel.cancellables)
    }
    
    private func clearAuthUserDefaults() {
        AuthUserDefaults.accessToken = nil
        AuthUserDefaults.refreshToken = nil
    }
    
    private func withdrawalReason() -> String? {
        return isSelectedReason ? setWithdrawlReason() : nil
    }
    
    private func setWithdrawlReason() -> String {
        var reasons: [String] = []
        for (index, selectedReason) in selectedReasons.enumerated() where selectedReason {
            reasons.append(withdrawalReasons[index])
        }
        return reasons.joined(separator: " / ")
    }
    
    func completeWithdrawal() {
        navigationController?.popViewController(animated: false)
        onWithdrawal?()
    }
}
