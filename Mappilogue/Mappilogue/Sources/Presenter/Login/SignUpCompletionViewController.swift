//
//  SignUpCompletionViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/26.
//

import UIKit

class SignUpCompletionViewController: BaseViewController {
    var onTapped: (() -> Void)?
    
    private let completionRoundView = UIView()
    private let completionImage = UIImageView()
    private let completionLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
    
        completionRoundView.layer.cornerRadius = 35 / 2
        completionRoundView.layer.borderWidth = 2
        completionRoundView.layer.borderColor = UIColor.color707070.cgColor
        completionRoundView.backgroundColor = .clear
    
        completionImage.image = UIImage(named: "login_completion")
        
        completionLabel.text = "회원가입이 완료되었어요"
        completionLabel.textColor = .color1C1C1C
        completionLabel.font = .title01
    }

    override func setupHierarchy() {
        super.setupHierarchy()

        view.addSubview(completionRoundView)
        completionRoundView.addSubview(completionImage)
        view.addSubview(completionLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        completionRoundView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(35)
        }
        
        completionImage.snp.makeConstraints {
            $0.center.equalTo(completionRoundView)
            $0.width.equalTo(17)
            $0.height.equalTo(10)
        }
        
        completionLabel.snp.makeConstraints {
            $0.top.equalTo(completionRoundView.snp.bottom).offset(25)
            $0.centerX.equalToSuperview()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true) {
            self.onTapped?()
        }
    }
}
