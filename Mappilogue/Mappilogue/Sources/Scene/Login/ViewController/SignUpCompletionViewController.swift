//
//  SignUpCompletionViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/26.
//

import UIKit
import MappilogueKit

protocol SignUpCompletionControllerDelegate {
    func showTabBarController()
}

class SignUpCompletionViewController: BaseViewController {
    var dismissTimer: Timer?
    var minterval = 3.0
    
    private let stackView = UIStackView()
    private let completionImage = UIImageView()
    private let labelStackView = UIStackView()
    private let completionLabel = UILabel()
    private let goToHomeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissTimer = Timer.scheduledTimer(timeInterval: 1,
                             target: self,
                             selector: #selector(remainingSeconds),
                             userInfo: nil,
                             repeats: true)
    
        dismissAfterDelay()
    }
    
    override func setupProperty() {
        super.setupProperty()
    
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 40
        
        completionImage.image = Images.image(named: .imageSignupCompletion)
        completionImage.contentMode = .scaleAspectFit
        
        labelStackView.axis = .vertical
        labelStackView.distribution = .equalSpacing
        labelStackView.alignment = .center
        labelStackView.spacing = 3
        
        completionLabel.text = "맵필로그에 오신 걸 환영해요!"
        completionLabel.textColor = .black1C1C1C
        completionLabel.font = .title01
        
        goToHomeLabel.text = "\(Int(minterval))초 뒤에 홈으로 이동할게요"
        goToHomeLabel.textColor = .gray9B9791
        goToHomeLabel.font = .body02
    }

    override func setupHierarchy() {
        super.setupHierarchy()

        view.addSubview(stackView)
        stackView.addArrangedSubview(completionImage)
        stackView.addArrangedSubview(labelStackView)
        labelStackView.addArrangedSubview(completionLabel)
        labelStackView.addArrangedSubview(goToHomeLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        stackView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
        }
        
        completionImage.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(104)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // self.dismissViewController()
    }
    
    @objc func remainingSeconds() {
        minterval -= 1
        if minterval == 0 {
            if let timer = dismissTimer {
                timer.invalidate()
            }
        } else {
            goToHomeLabel.text = "\(Int(minterval))초 뒤에 홈으로 이동할게요"
        }
    }
    
    private func dismissAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dismissViewController()
        }
    }
    
    private func dismissViewController() {
        dismiss(animated: false)
    }
}
