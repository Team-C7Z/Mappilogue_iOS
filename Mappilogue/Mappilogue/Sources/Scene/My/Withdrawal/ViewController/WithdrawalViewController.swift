//
//  WithdrawalViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit
import KakaoSDKUser

class WithdrawalViewController: WithdrawalNavigationViewController {
    var viewModel = WithdrawalViewModel()
    
    var onWithdrawal: (() -> Void)?
    
    private let withdrawalTitleLabel = UILabel()
    private let withdrawalSubTitleLabel = UILabel()
    private let stackView = UIStackView()
    private let submitButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.selectedReasons = Array(repeating: false, count: viewModel.withdrawalReasons.count)
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
        for (index, title) in viewModel.withdrawalReasons.enumerated() {
            let withdrawalReasonView = WithdrawalReasonView()
            withdrawalReasonView.configure(title, index)
            withdrawalReasonView.onReasonSelected = { [weak self] index in
                guard let self = self else { return }
                
                viewModel.updateSelectedReasons(index)
                updateSubmitButtonDesign()
            }
            stackView.addArrangedSubview(withdrawalReasonView)
        }
    }
    
    private func updateSubmitButtonDesign() {
        submitButton.backgroundColor = viewModel.isSelectedReason ? .green2EBD3D : .grayC9C6C2
    }
    
    @objc func submitButtonTapped() {
        if viewModel.isSelectedReason {
            performWithdrawal()
        }
    }
    
    @objc private func performWithdrawal() {
        completeWithdrawal()
        UserApi.shared.unlink { error in
            if let error = error {
                print(error)
            } else {
                self.handleUserManagerWithdrawal()
            }
        }
    }
    
    private func handleUserManagerWithdrawal() {
        viewModel.withdrawal(reason: self.viewModel.withdrawalReasonText)
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
            .store(in: &viewModel.cancellables)
    }
    
    private func clearAuthUserDefaults() {
        AuthUserDefaults.accessToken = nil
        AuthUserDefaults.refreshToken = nil
    }
    
    func completeWithdrawal() {
        onWithdrawal?()
        
    }
}
