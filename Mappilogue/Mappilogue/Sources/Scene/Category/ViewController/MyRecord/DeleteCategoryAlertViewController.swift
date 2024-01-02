//
//  DeleteCategoryAlertViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/11/15.
//

import UIKit
import MappilogueKit

class DeleteCategoryAlertViewController: BaseViewController {
    weak var coordinator: DeleteCategoryAlertCoordinator?
    
    var onCancelTapped: (() -> Void)?
    var onDoneTapped: ((String) -> Void)?
    
    private let alertView = UIView()
    private let titleLabel = UILabel()
    private let checkButton = UIButton()
    private let checkImage = UIImageView()
    private let messageLabel = UILabel()
    private let cancelButton = UIButton()
    private let doneButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .gray404040.withAlphaComponent(0.1)
        
        alertView.layer.cornerRadius = 12
        alertView.backgroundColor = .grayF9F8F7
        
        titleLabel.text = "이 카테고리를 삭제할까요?"
        titleLabel.textColor = .color000000
        titleLabel.font = .title02
        
        checkButton.addTarget(self, action: #selector(checkButtonTapped), for: .touchUpInside)
        
        checkImage.image = Images.image(named: .buttonUncheck)
        
        messageLabel.text = "카테고리 안 기록까지 모두 삭제"
        messageLabel.textColor = .gray707070
        messageLabel.font = .body02
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        cancelButton.setTitle("취소", for: .normal)
        cancelButton.layer.cornerRadius = 12
        cancelButton.backgroundColor = .grayF5F3F0
        cancelButton.setTitleColor(.black1C1C1C, for: .normal)
        cancelButton.titleLabel?.font = .body02
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
        
        doneButton.setTitle("삭제", for: .normal)
        doneButton.layer.cornerRadius = 12
        doneButton.setTitleColor(.whiteFFFFFF, for: .normal)
        doneButton.titleLabel?.font = .body03
        doneButton.backgroundColor = .redF14C4C
        doneButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(alertView)
        alertView.addSubview(titleLabel)
        alertView.addSubview(checkButton)
        checkButton.addSubview(checkImage)
        checkButton.addSubview(messageLabel)
        alertView.addSubview(cancelButton)
        alertView.addSubview(doneButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        alertView.snp.makeConstraints {
            $0.center.equalTo(view)
            $0.width.equalTo(270)
            $0.height.equalTo(165)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(32)
            $0.centerX.equalTo(alertView)
        }
        
        checkButton.snp.makeConstraints {
            $0.height.equalTo(21)
            $0.centerY.leading.equalTo(checkImage)
            $0.trailing.equalTo(messageLabel)
        }
        
        checkImage.snp.makeConstraints {
            $0.top.equalTo(alertView).offset(68.5)
            $0.leading.equalTo(alertView).offset(35)
            $0.width.height.equalTo(20)
        }
        
        messageLabel.snp.makeConstraints {
            $0.centerY.equalTo(checkImage)
            $0.leading.equalTo(checkImage.snp.trailing).offset(8)
        }
        
        cancelButton.snp.makeConstraints {
            $0.bottom.equalTo(alertView).offset(-10)
            $0.leading.equalTo(alertView).offset(10)
            $0.width.equalTo(120)
            $0.height.equalTo(42)
        }
        
        doneButton.snp.makeConstraints {
            $0.bottom.equalTo(alertView).offset(-10)
            $0.trailing.equalTo(alertView).offset(-10)
            $0.width.equalTo(120)
            $0.height.equalTo(42)
        }
    }
    
    @objc func checkButtonTapped(_ button: UIButton) {
        checkImage.image = Images.image(named: button.isSelected ? .buttonUncheck : .buttonCheck)
      
        button.isSelected.toggle()
    }
    
    @objc private func cancelButtonTapped(_ sender: UIButton) {
        onCancelTapped?()
        coordinator?.dismissViewController()
    }
    
    @objc private func deleteButtonTapped(_ sender: UIButton) {
        let option = self.checkButton.isSelected ? "all" : "only"
        onDoneTapped?(option)
        coordinator?.dismissViewController()
    }
}
