//
//  EditViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/03.
//

import UIKit

class EditViewController: BaseViewController {
    var categoryName: String = ""
    var onModifyButtonTapped: ((String) -> Void)?
    var onDeleteButtonTapped: (() -> Void)?
    
    private let modalView = UIView()
    private let barView = UIView()
    private let modifyButton = UIButton()
    private let modifyImage = UIImageView()
    private let modifyLabel = UILabel()
    private let deleteButton = UIButton()
    private let deleteImage = UIImageView()
    private let deleteLabel = UILabel()

    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .color404040.withAlphaComponent(0.1)
        
        modalView.layer.cornerRadius = 24
        modalView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        modalView.layer.masksToBounds = true
        modalView.backgroundColor = .colorF9F8F7
        
        barView.backgroundColor = .colorC9C6C2
        
<<<<<<< Updated upstream:Mappilogue/Mappilogue/Sources/Presenter/Record/MyRecord/EditCategoryViewController.swift
        modifyCategoryImage.image = UIImage(named: "common_modify")
        modifyCategoryLabel.text = "카테고리 이름 바꾸기"
        modifyCategoryLabel.textColor = .color1C1C1C
        modifyCategoryLabel.font = .title02
        modifyCategoryButton.addTarget(self, action: #selector(modifyCategoryButtonTapped), for: .touchUpInside)
        
        deleteCategoryImage.image = UIImage(named: "common_delete")
        deleteCategoryImage.tintColor = .colorF14C4C
        deleteCategoryLabel.text = "카테고리 삭제하기"
        deleteCategoryLabel.textColor = .color1C1C1C
        deleteCategoryLabel.font = .title02
        deleteCategoryButton.addTarget(self, action: #selector(deleteCategoryButtonTapped), for: .touchUpInside)
=======
        modifyImage.image = UIImage(named: "common_modify")
        modifyLabel.textColor = .color1C1C1C
        modifyLabel.font = .title02
        modifyButton.addTarget(self, action: #selector(modifyCategoryButtonTapped), for: .touchUpInside)
        
        deleteImage.image = UIImage(named: "common_delete")
        deleteImage.tintColor = .colorF14C4C
        deleteLabel.textColor = .color1C1C1C
        deleteLabel.font = .title02
        deleteButton.addTarget(self, action: #selector(deleteCategoryButtonTapped), for: .touchUpInside)
>>>>>>> Stashed changes:Mappilogue/Mappilogue/Sources/Presenter/Reusable/EditViewController.swift
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(modalView)
        modalView.addSubview(barView)
        modalView.addSubview(modifyButton)
        modifyButton.addSubview(modifyImage)
        modifyButton.addSubview(modifyLabel)
        modalView.addSubview(deleteButton)
        deleteButton.addSubview(deleteImage)
        deleteButton.addSubview(deleteLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        modalView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalTo(view)
            $0.height.equalTo(216)
        }
        
        barView.snp.makeConstraints {
            $0.top.equalTo(modalView).offset(12)
            $0.centerX.equalTo(modalView)
            $0.width.equalTo(36)
            $0.height.equalTo(4)
        }
        
        modifyButton.snp.makeConstraints {
            $0.top.equalTo(modalView).offset(42)
            $0.leading.equalTo(modalView).offset(16)
            $0.trailing.equalTo(modalView).offset(16)
            $0.height.equalTo(56)
        }
        
        modifyImage.snp.makeConstraints {
            $0.leading.centerY.equalTo(modifyButton)
            $0.width.equalTo(18)
            $0.height.equalTo(17)
        }
        
        modifyLabel.snp.makeConstraints {
            $0.leading.equalTo(modifyImage.snp.trailing).offset(16)
            $0.centerY.equalTo(modifyButton)
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.equalTo(modifyButton.snp.bottom)
            $0.leading.equalTo(modalView).offset(16)
            $0.trailing.equalTo(modalView).offset(-16)
            $0.height.equalTo(56)
        }
        
        deleteImage.snp.makeConstraints {
            $0.leading.centerY.equalTo(deleteButton)
            $0.width.equalTo(18)
            $0.height.equalTo(20)
        }
        
        deleteLabel.snp.makeConstraints {
            $0.leading.equalTo(deleteImage.snp.trailing).offset(15)
            $0.centerY.equalTo(deleteButton)
        }
    }
    
    func configure(modifyTitle: String, deleteTitle: String) {
        modifyLabel.text = modifyTitle
        deleteLabel.text = deleteTitle
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first, touch.location(in: view).y < modalView.frame.maxY else {
            return
        }
        dismiss(animated: false)
    }
    
    @objc func modifyButtonTapped(_ button: UIButton) {
        let inputAlertViewController = InputAlertViewController()
        inputAlertViewController.modalPresentationStyle = .overCurrentContext
        inputAlertViewController.configure(categoryName)
        inputAlertViewController.onCancelTapped = {
            self.dismiss(animated: false)
        }
        inputAlertViewController.onCompletionTapped = { inputText in
            self.dismiss(animated: false) {
                self.onModifyButtonTapped?(inputText)
            }
        }
        present(inputAlertViewController, animated: false)
    }
    
    @objc func deleteCategoryButtonTapped(_ button: UIButton) {
        let alertViewController = AlertViewController()
        alertViewController.modalPresentationStyle = .overCurrentContext
        let alert = Alert(titleText: "이 카테고리를 삭제할까요?",
                          messageText: nil,
                          cancelText: "취소",
                          doneText: "삭제",
                          buttonColor: .colorF14C4C,
                          alertHeight: 140)
        alertViewController.configureAlert(with: alert)
        alertViewController.onDoneTapped = {
            self.dismiss(animated: false) {
                self.onDeleteButtonTapped?()
           }
        }
        present(alertViewController, animated: false)
    }
}
