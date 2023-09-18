//
//  InquiryViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/06.
//

import UIKit

class InquiryViewController: BaseViewController {
    private let email = "mappilogue@naver.com"
    
    private let inquiryTitleLabel = UILabel()
    private let inquiryContentLabel = UILabel()
    private let emailView = UIView()
    private let emailImage = UIImageView()
    private let emailLabel = UILabel()
    private let emailCopyButton = UIButton()
    private var emailCopyToastMessage = EmailCopyToastMessageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationTitleAndBackButton("문의하기", backButtonAction: #selector(backButtonTapped))
        
        inquiryTitleLabel.text = "여러분의 이야기를 기다려요"
        inquiryTitleLabel.textColor = .color1C1C1C
        inquiryTitleLabel.font = .title01
        inquiryContentLabel.setTextWithLineHeight(text: "맵필로그 팀은 여러분의 질문을 언제든지 기다리고 있어요.\n궁금한 점이나 건의할 점, 사소한 의견이라도 맵필로그 팀에게 전해 주세요.", lineHeight: 21)
        inquiryContentLabel.textColor = .color707070
        inquiryContentLabel.font = .body02
        inquiryContentLabel.numberOfLines = 0
        inquiryContentLabel.lineBreakMode = .byWordWrapping
        
        emailView.layer.cornerRadius = 12
        emailView.backgroundColor = .colorF5F3F0
        emailImage.image = UIImage(named: "my_email")
        emailLabel.text = email
        emailCopyButton.setTitle("복사하기", for: .normal)
        emailCopyButton.setTitleColor(.color2EBD3D, for: .normal)
        emailCopyButton.titleLabel?.font = .body03
        emailCopyButton.addTarget(self, action: #selector(emailCopyButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(inquiryTitleLabel)
        view.addSubview(inquiryContentLabel)
        view.addSubview(emailView)
        view.addSubview(emailImage)
        view.addSubview(emailLabel)
        view.addSubview(emailCopyButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        inquiryTitleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        inquiryContentLabel.snp.makeConstraints {
            $0.top.equalTo(inquiryTitleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        emailView.snp.makeConstraints {
            $0.top.equalTo(inquiryContentLabel.snp.bottom).offset(33)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(44)
        }
        
        emailImage.snp.makeConstraints {
            $0.leading.equalTo(emailView).offset(12)
            $0.centerY.equalTo(emailView)
            $0.width.equalTo(17)
            $0.height.equalTo(14)
        }
        
        emailLabel.snp.makeConstraints {
            $0.leading.equalTo(emailImage.snp.trailing).offset(8)
            $0.centerY.equalTo(emailView)
        }
        
        emailCopyButton.snp.makeConstraints {
            $0.trailing.equalTo(emailView).offset(-12)
            $0.centerY.equalTo(emailView)
        }
    }
    
    @objc func emailCopyButtonTapped() {
        showGatheringToastMessage()
    }
    
    func setGatheringToastMessage() {
        view.addSubview(emailCopyToastMessage)
        
        emailCopyToastMessage.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func showGatheringToastMessage() {
        self.setGatheringToastMessage()
        
        UIView.animate(withDuration: 2, delay: 0, options: .curveLinear, animations: {
            
        }, completion: { (_) in
            UIView.animate(withDuration: 0.3, delay: 1, options: .curveEaseIn, animations: {
                self.emailCopyToastMessage.alpha = 0.0
            }, completion: { (_) in
                self.emailCopyToastMessage.alpha = 1.0
                self.emailCopyToastMessage.removeFromSuperview()
                
                self.copyEmail()
            })
        })
    }
    
    private func copyEmail() {
        UIPasteboard.general.string = email
    }
}
