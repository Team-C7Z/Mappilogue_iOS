//
//  SignUpCompletionViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/26.
//

import UIKit

class SignUpCompletionViewController: BaseViewController {
    var onTapped: (() -> Void)?
    
    private let stackView = UIStackView()
    private let completionImage = UIImageView()
    private let labelStackView = UIStackView()
    private let completionLabel = UILabel()
    private let goToHomeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dimissAfterDelay()
    }
    
    override func setupProperty() {
        super.setupProperty()
    
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 40
        
        completionImage.image = UIImage(named: "login_completion")
        completionImage.contentMode = .scaleAspectFit
        
        labelStackView.axis = .vertical
        labelStackView.distribution = .equalSpacing
        labelStackView.alignment = .center
        labelStackView.spacing = 3
        
        completionLabel.text = "맵필로그에 오신 걸 환영해요!"
        completionLabel.textColor = .color1C1C1C
        completionLabel.font = .title01
        
        goToHomeLabel.text = "3초 뒤에 홈으로 이동할게요"
        goToHomeLabel.textColor = .color9B9791
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
        self.dimissViewController()
    }
    
    private func dimissAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.dimissViewController()
        }
    }
    
    private func dimissViewController() {
        dismiss(animated: true) {
            self.onTapped?()
        }
    }
}
