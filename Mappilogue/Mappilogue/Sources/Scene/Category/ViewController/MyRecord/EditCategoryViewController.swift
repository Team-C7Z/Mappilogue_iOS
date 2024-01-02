//
//  EditCategoryViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/03.
//

import UIKit
import MappilogueKit

class EditCategoryViewController: BaseViewController {
    weak var coordinator: EditCategoryCoordinator?
    private var categoryViewModel = CategoryViewModel()
    
    var categoryId: Int = 0
    var categoryName: String = ""
    var editMode: Bool = true
    var onDeleteCategory: (() -> Void)?
    
    private let modalView = UIView()
    private let barView = UIView()
    private let modifyCategoryButton = UIButton()
    private let modifyCategoryImage = UIImageView()
    private let modifyCategoryLabel = UILabel()
    private let deleteCategoryButton = UIButton()
    private let deleteCategoryImage = UIImageView()
    private let deleteCategoryLabel = UILabel()

    override func setupProperty() {
        super.setupProperty()
        
        view.backgroundColor = .gray404040.withAlphaComponent(0.1)
        
        modalView.layer.cornerRadius = 24
        modalView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        modalView.layer.masksToBounds = true
        modalView.backgroundColor = .grayF9F8F7
        
        barView.backgroundColor = .grayC9C6C2
        
        modifyCategoryImage.image = Images.image(named: .imageModify)
        modifyCategoryLabel.text = "카테고리 이름 바꾸기"
        modifyCategoryLabel.textColor = .black1C1C1C
        modifyCategoryLabel.font = .title02
        modifyCategoryButton.addTarget(self, action: #selector(modifyCategoryButtonTapped), for: .touchUpInside)
        
        deleteCategoryImage.image = Images.image(named: .imageDelete)
        deleteCategoryImage.tintColor = .redF14C4C
        deleteCategoryLabel.text = "카테고리 삭제하기"
        deleteCategoryLabel.textColor = .black1C1C1C
        deleteCategoryLabel.font = .title02
        deleteCategoryButton.addTarget(self, action: #selector(deleteCategoryButtonTapped), for: .touchUpInside)
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(modalView)
        modalView.addSubview(barView)
        modalView.addSubview(modifyCategoryButton)
        modifyCategoryButton.addSubview(modifyCategoryImage)
        modifyCategoryButton.addSubview(modifyCategoryLabel)
        modalView.addSubview(deleteCategoryButton)
        deleteCategoryButton.addSubview(deleteCategoryImage)
        deleteCategoryButton.addSubview(deleteCategoryLabel)
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
        
        modifyCategoryButton.snp.makeConstraints {
            $0.top.equalTo(modalView).offset(42)
            $0.leading.equalTo(modalView).offset(16)
            $0.trailing.equalTo(modalView).offset(16)
            $0.height.equalTo(56)
        }
        
        modifyCategoryImage.snp.makeConstraints {
            $0.leading.centerY.equalTo(modifyCategoryButton)
            $0.width.equalTo(18)
            $0.height.equalTo(17)
        }
        
        modifyCategoryLabel.snp.makeConstraints {
            $0.leading.equalTo(modifyCategoryImage.snp.trailing).offset(16)
            $0.centerY.equalTo(modifyCategoryButton)
        }
        
        deleteCategoryButton.snp.makeConstraints {
            $0.top.equalTo(modifyCategoryButton.snp.bottom)
            $0.leading.equalTo(modalView).offset(16)
            $0.trailing.equalTo(modalView).offset(-16)
            $0.height.equalTo(56)
        }
        
        deleteCategoryImage.snp.makeConstraints {
            $0.leading.centerY.equalTo(deleteCategoryButton)
            $0.width.equalTo(18)
            $0.height.equalTo(20)
        }
        
        deleteCategoryLabel.snp.makeConstraints {
            $0.leading.equalTo(deleteCategoryImage.snp.trailing).offset(15)
            $0.centerY.equalTo(deleteCategoryButton)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if editMode {
            guard let touch = touches.first, touch.location(in: view).y < modalView.frame.maxY else {
                return
            }
            coordinator?.dismissViewController()
        }
    }
    
    @objc func modifyCategoryButtonTapped(_ button: UIButton) {
        editMode = false
        

//        inputAlertViewController.onCancelTapped = {
//            self.dismiss(animated: false)
//        }
//        inputAlertViewController.onCompletionTapped = { inputText in
//            self.editMode = true
//            
//            let updateCategory = UpdatedCategory(markCategoryId: self.categoryId, title: inputText)
//            self.categoryViewModel.updateCategory(updateCategory: updateCategory)
//            
//            self.dismiss(animated: false)
//        }
        coordinator?.showInputModalViewController()
    
    }
    
    @objc func deleteCategoryButtonTapped(_ button: UIButton) {
        editMode = false

//        alertViewController.onCancelTapped = {
//            self.editMode = true
//        }
//        
//        alertViewController.onDoneTapped = { option in
//            self.editMode = true
//            
//            let deleteCategory = DeletedCategory(markCategoryId: self.categoryId, option: option)
//            self.dismiss(animated: false) {
//                self.categoryViewModel.deleteCategory(deleteCategory: deleteCategory)
//                self.onDeleteCategory?()
//            }
//        }
        coordinator?.showDeleatCategoryAlert()
    }
}
