//
//  MyRecordContentViewController.swift
//  Mappilogue
//
//  Created by hyemi on 2023/08/17.
//

import UIKit

class MyRecordContentViewController: BaseViewController {
    var schedule: Schedule = Schedule()
    var isNewWrite: Bool = false
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let stackView = UIStackView()
    private let recordContentHeaderView = MyRecordContentHeaderView()
    private let myRecordContentImageView = MyRecordContentImageView()
    private let myRecordContentTextView = MyRecordContentTextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func setupProperty() {
        super.setupProperty()
        
        setNavigationTitleAndItems(imageName: "menu", action: #selector(menuButtonTapped), isLeft: false)
        setNavigationTitleAndBackButton("나의 기록", backButtonAction: isNewWrite ? #selector(navigateToMyCategoryViewController) : #selector(backButtonTapped))
        
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = 0
        
        recordContentHeaderView.configure(schedule)
        if let images = schedule.image {
            myRecordContentImageView.configure(images, size: view.frame.width - 32)
        }
        myRecordContentTextView.configure(schedule.content ?? "", width: view.frame.width - 32)
        myRecordContentTextView.stackViewHeightUpdated = {
            self.stackView.layoutIfNeeded()
        }
    }
    
    override func setupHierarchy() {
        super.setupHierarchy()
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(recordContentHeaderView)
        stackView.addArrangedSubview(myRecordContentImageView)
        stackView.addArrangedSubview(myRecordContentTextView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scrollView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView)
            $0.width.equalTo(scrollView)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(contentView).offset(10)
            $0.leading.equalTo(contentView).offset(16)
            $0.trailing.equalTo(contentView).offset(-16)
            $0.bottom.equalTo(contentView).offset(-58)
        }
        
    }
    
    @objc func navigateToMyCategoryViewController() {
        let myCategoryViewController = MyCategoryViewController()
        myCategoryViewController.isNewWrite = true
        myCategoryViewController.categoryName = "전체" 
        navigationController?.pushViewController(myCategoryViewController, animated: false)
    }
    
    @objc func menuButtonTapped() {
        let editViewController = EditViewController()
        editViewController.modalPresentationStyle = .overFullScreen
        editViewController.configure(modifyTitle: "수정하기",
                                             deleteTitle: "삭제하기",
                                             alert: Alert(titleText: "이 기록을 삭제할까요?",
                                                          messageText: nil,
                                                          cancelText: "취소",
                                                          doneText: "삭제",
                                                          buttonColor: .colorF14C4C,
                                                          alertHeight: 140)
        )
        editViewController.onModify = { self.modifyRecord() }
        editViewController.onDelete = { self.deleteRecord() }
        present(editViewController, animated: false)
    }
    
    private func modifyRecord() {
        let writeRecordViewController = WriteRecordViewController()
        navigationController?.pushViewController(writeRecordViewController, animated: true)
    }
    
    private func deleteRecord() {
        if isNewWrite {
            if let viewControllerToPopTo = navigationController?.viewControllers.first(where: { $0 is SelectWriteRecordViewController }) {
                
                navigationController?.popToViewController(viewControllerToPopTo, animated: true)
            }
        } else {
            navigationController?.popViewController(animated: true)
        }
    }
}
