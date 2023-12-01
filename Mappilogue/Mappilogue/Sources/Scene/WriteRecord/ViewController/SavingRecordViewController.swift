//
//  SavingRecordViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/17.
//

import UIKit
import Lottie

class SavingRecordViewController: BaseViewController {
    var onSaveComplete: (() -> Void)?
    
    private let modalView = UIView()
    private let titleLabel = UILabel()
    private let lottieAnimationView = LottieAnimationView(name: "saving")
    private let cancelButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.dismissViewController()
        }
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .gray404040.withAlphaComponent(0.1)
        
        modalView.layer.cornerRadius = 12
        modalView.backgroundColor = .grayF9F8F7
        
        titleLabel.text = "기록 저장 중이에요"
        titleLabel.textColor = .color000000
        titleLabel.font = .title02
        
        lottieAnimationView.contentMode = .scaleAspectFit
        lottieAnimationView.loopMode = .loop
        lottieAnimationView.play()
        
        cancelButton.backgroundColor = .grayF5F3F0
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.setTitleColor(.black1C1C1C, for: .normal)
        cancelButton.titleLabel?.font = .body02
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
  
        view.addSubview(modalView)
        modalView.addSubview(titleLabel)
        modalView.addSubview(lottieAnimationView)
        modalView.addSubview(cancelButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        modalView.snp.makeConstraints {
            $0.center.equalTo(view)
            $0.width.equalTo(270)
            $0.height.equalTo(161)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(modalView).offset(32)
            $0.centerX.equalTo(modalView)
        }
        
        lottieAnimationView.snp.makeConstraints {
            $0.top.equalTo(modalView).offset(63)
            $0.centerX.equalTo(modalView)
            $0.width.equalTo(56)
            $0.height.equalTo(32)
        }
        
        cancelButton.snp.makeConstraints {
            $0.bottom.equalTo(modalView).offset(-10)
            $0.centerX.equalTo(modalView)
            $0.width.equalTo(238)
            $0.height.equalTo(42)
        }
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: false)
    }
    
    private func dismissViewController() {
        lottieAnimationView.stop()
        dismiss(animated: false) {
            self.onSaveComplete?()
        }
    }
}
